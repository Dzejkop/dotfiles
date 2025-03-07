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
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return require "configs.telescope"
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = "nvim-telescope/telescope.nvim",
  },
  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },
  {
    "David-Kunz/cmp-npm",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "json",
    config = function()
      require("cmp-npm").setup {}
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    lazy = false,
    config = function()
      require("grug-far").setup {
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      }
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    ---@type snacks.Config
    opts = {
      lazygit = {},
      win = {},
    },
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "LintaoAmons/bookmarks.nvim",
    tag = "v2.3.0",
    lazy = false,
    dependencies = {
      { "kkharji/sqlite.lua" },
      { "nvim-telescope/telescope.nvim" },
      { "stevearc/dressing.nvim" }, -- optional: better UI
    },
    config = function()
      local opts = {}
      require("bookmarks").setup(opts) -- you must call setup to init sqlite db
    end,
  },
  {
    "sindrets/diffview.nvim",
    lazy = false,
    opts = {}
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" }
  }
}
