return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",

        "javascript",
        "json",
        "typescript",
        "tsx",

        "elixir",
        "heex",

        "rust",
        "toml",

        "astro",
        "go",
      },
    },
  },
  {
    "davidmh/mdx.nvim",
    lazy = false,
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
}
