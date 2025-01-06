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

-- Goto functionality

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
