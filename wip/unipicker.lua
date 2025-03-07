local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local colors = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "colors",
      finder = finders.new_table {
        results = { "red", "green", "blue" },
      },
      sorter = conf.generic_sorter(opts),
    })
    :find()
end

colors(require("telescope.themes").get_dropdown {})
