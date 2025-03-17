-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>tt", "<cmd>TSContextToggle<cr>", { desc = "Toggle tree-sitter context" })

vim.keymap.set("n", "<leader>hw", "<cmd>HopWord<cr>", { desc = "Hop word" })
vim.keymap.set("n", "<leader>ha", "<cmd>HopAnywhere<cr>", { desc = "Hop anywhere" })
vim.keymap.set("n", "<leader>hlw", "<cmd>HopWordCurrentLine<cr>", { desc = "Hop word current line" })
vim.keymap.set("n", "<leader>hla", "<cmd>HopAnywhereCurrentLine<cr>", { desc = "Hop anywhere current line" })
