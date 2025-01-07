require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

-- Local leader

-- : -> ;
map("n", ";", ":", { desc = "CMD enter command mode" })

-- LSP functionality
map("n", "<leader>ls", "<cmd> Telescope lsp_document_symbols <cr>", { desc = "telescope document symbols" })
map("n", "<leader>lS", "<cmd> Telescope lsp_workspace_symbols <cr>", { desc = "telescope workspace symbols" })
map("n", "<leader>lr", "<cmd> Telescope lsp_references <cr>", { desc = "telescope references" })
map("n", "<leader>li", "<cmd> Telescope lsp_implementations <cr>", { desc = "telescope implementations" })

-- Useful
map("n", "<leader>fk", "<cmd> Telescope keymaps <cr>", { desc = "telescope keymaps" })
map("n", "<leader>fc", "<cmd> Telescope commands <cr>", { desc = "telescope commands" })
map("n", "<leader>fj", "<cmd> Telescope jumplist <cr>", { desc = "telescope jumplist" })
map("n", "<leader>fb", "<cmd> Telescope buffers <cr>", { desc = "telescope buffers" })

-- Snacks - lazygit
cmd("Lazygit", function()
  Snacks.lazygit()
end, { desc = "Toggle lazygit" })

map("n", "<leader>lg", "<cmd> Lazygit <cr>", { desc = "open lazygit" })

-- GrugFar
local far_fun = function()
  Snacks.win {
    position = "bottom",
    enter = true,
    on_win = function(win)
      vim.api.nvim_create_autocmd("BufWinLeave", {
        callback = function(ev)
          if vim.bo[ev.buf].filetype == "grug-far" then
            win:close()
          end
        end,
      })

      vim.cmd "GrugFar"
    end,
  }
end

cmd("Far", far_fun, { desc = "Search & Replace: With GrugFar" })
cmd("SearchAndReplace", far_fun, { desc = "Search & Replace: With GrugFar" })

-- Remove the default mapping to focus the nvimtree
vim.keymap.del("n", "<leader>e")

map("n", "<leader>e", "<cmd> NvimTreeToggle <cr>", { desc = "toggle nvim tree" })

-- Bookmarks
map("n", "<leader>Bm", "<cmd> BookmarksMark <cr>", { desc = "Bookmark"} )
map("n", "<leader>Bg", "<cmd> BookmarksGoto <cr>", { desc = "Find and go to bookmarks"} )

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
