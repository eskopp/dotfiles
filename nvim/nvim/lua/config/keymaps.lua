-- Set the leader key to space.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Save file with Ctrl+s.
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })

-- Quit the current window with leader + q.
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit window" })

-- Open the built-in file explorer with leader + e.
vim.keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "Open file explorer" })

-- Clear search highlighting with Esc in normal mode.
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })
