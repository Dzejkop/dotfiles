#!/usr/bin/env -S uv run --python 3.10 --script
# /// script
# dependencies = ["openai>=1.70.0", "openai-agents>=0.0.7"]
# ///

import argparse
import json
import os
import subprocess
import sys
import asyncio
from openai.types.responses import ResponseTextDeltaEvent
from agents import Agent, Runner, function_tool, WebSearchTool, handoff, trace

CONTEXTS_DIR = os.path.expanduser("~/.cache/a/contexts/")
MAIN_CACHE_FILE = os.path.expanduser("~/.cache/a/cache.json")


@function_tool
async def exec_shell_command(cmd: str) -> str:
    if not args.yes:
        print("Executing command: ", cmd)
        decision = input("Do you want to execute this command? (y/N): ")
        if decision.lower() != "y":
            return "Command execution rejected by user."

    """Execute shell command and terminate the process."""
    try:
        subprocess.run(cmd, shell=True, check=True)
        sys.exit(0)
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {e}")
        sys.exit(1)


def ensure_dirs():
    os.makedirs(CONTEXTS_DIR, exist_ok=True)


def load_cache():
    ensure_dirs()

    if os.path.exists(MAIN_CACHE_FILE):
        with open(MAIN_CACHE_FILE, "r") as f:
            context = f.read().strip()
            if context:
                return json.loads(context)

    return {"meta": {"name": "chat"}, "chat": []}


def save_cache(cache):
    with open(MAIN_CACHE_FILE, "w") as f:
        json.dump(cache, f, indent=2)


def set_active_context(new_context):
    ensure_dirs()
    current_cache = load_cache()
    # Retrieve the current context's name from the cache meta, defaulting to "chat"
    current_context_name = current_cache.get("meta", {}).get("name", "chat")
    # Save the current active context to its own file based on its name
    current_context_file = os.path.join(CONTEXTS_DIR, f"{current_context_name}.json")
    with open(current_context_file, "w") as f:
        json.dump(current_cache, f, indent=2)
    # Determine the file path for the new context.
    new_context_file = os.path.join(CONTEXTS_DIR, f"{new_context}.json")
    if os.path.exists(new_context_file):
        # Load the existing context from its file and remove the file.
        with open(new_context_file, "r") as f:
            new_context_content = json.load(f)
        save_cache(new_context_content)
        os.remove(new_context_file)
    else:
        # Create an entirely new (empty) context with the new context name.
        save_cache({"meta": {"name": new_context}, "chat": []})


def update_context(cache, new_message):
    if "chat" not in cache:
        cache["chat"] = []
    cache["chat"].append(new_message)


def create_agents():
    cmd_agent = Agent(
        name="Cmd Agent",
        instructions="""
        You are a cmd agent. Your job is to execute a shell command on the user's behalf.

        You have a tool at your disposal that will execute a command you specify. 

        Try to always execute some command for the user.

        Current working directory: {cwd}
        """.format(cwd=os.getcwd()),
        tools=[exec_shell_command],
    )

    basic_agent = Agent(
        name="Basic",
        instructions="""
        You are a basic question answering agent. Your job is to answer any questions the user might have.
        """,
        tools=[WebSearchTool()],
    )

    planner = Agent(
        name="Planner",
        instructions="""
        Your name is "a".

        You are a terminal assistant planner.

        Your job is to figure out the user's intent and handoff the request to an appropriate agent.

        The user might ask you questions, issue tasks, etc.

        At your disposal are the following agents:
        1. Cmd agent - this agent is designed to execute a shell command
        2. Basic agent - this agent is designed to answer basic questions

        You should in general favour executing commands to answering questions.

        Don't pay too much attention to your chat histroy - it's only relevant to answer questions about past user interactions.
        Don't try to infer what the user wants to do know based on previous content - unless the user explicitly requests to do that.
        """,
        handoffs=[cmd_agent, basic_agent],
        model="gpt-4o-2024-08-06",
    )

    return cmd_agent, basic_agent, planner


cmd_agent, basic_agent, planner = create_agents()


async def main():
    global args
    parser = argparse.ArgumentParser(description="Terminal Assistant")
    parser.add_argument("-c", "--ctx", type=str, help="Switch to a new context")
    parser.add_argument("-y", "--yes", action="store_true", help="Auto run commands")
    parser.add_argument("user_input", nargs="*", help="Command or query")
    args = parser.parse_args()

    if args.ctx:
        set_active_context(args.ctx)
        print(f"Switched context to {args.ctx}")
        sys.exit(0)

    cache = load_cache()
    active_context = "chat"

    command_input = " ".join(args.user_input).strip()

    if not command_input:
        command_input = (
            "User did not provide input. Infer what they might want you to do next"
        )

    update_context(cache, {"role": "user", "content": command_input})
    save_cache(cache)
    conversation_history = cache.get(active_context, [])
    context_items = conversation_history
    result = Runner.run_streamed(planner, input=context_items)
    full_response = ""
    async for event in result.stream_events():
        if event.type == "raw_response_event" and isinstance(
            event.data, ResponseTextDeltaEvent
        ):
            delta = event.data.delta
            full_response += delta
            if delta != "%":
                print(delta, end="", flush=True)

    update_context(cache, {"role": "assistant", "content": full_response})
    save_cache(cache)


if __name__ == "__main__":
    asyncio.run(main())
