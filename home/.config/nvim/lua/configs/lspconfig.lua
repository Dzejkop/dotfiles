-- load defaults i.e lua_lsp
local configs = require "nvchad.configs.lspconfig"

configs.defaults()

local lspconfig = require "lspconfig"

local servers = {
  html = {},
  cssls = {},
  ts_ls = {},

  elixirls = {
    cmd = { vim.fn.stdpath "data" .. "/mason/bin/elixir-ls" },
  },

  lua_ls = {},

  rust_analyzer = {},

  marksman = {},

  mdx_analyzer = {},
  astro = {},
  gopls = {},

  pyright = {},

  solidity_ls = {},
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  lspconfig[name].setup(opts)
end
