require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fs", "<cmd> Telescope lsp_document_symbols <cr>", { desc = "telescope document symbols" })
map("n", "<leader>fS", "<cmd> Telescope lsp_workspace_symbols <cr>", { desc = "telescope workspace symbols" })
map("n", "<leader>fr", "<cmd> Telescope lsp_references <cr>", { desc = "telescope references" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
