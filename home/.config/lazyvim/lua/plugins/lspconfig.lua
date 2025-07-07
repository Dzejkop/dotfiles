return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      solidity_ls = {},

      terraformls = {},

      kotlin_language_server = {},
    },
  },
}
