-- Show absolute line numbers.
vim.opt.number = true

-- Do not use relative line numbers.
vim.opt.relativenumber = false

-- Enable mouse support in all modes.
vim.opt.mouse = "a"

-- Keep undo history between sessions.
vim.opt.undofile = true

-- Use the system clipboard.
vim.opt.clipboard = "unnamedplus"

-- Use case-insensitive search unless uppercase is used.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep a few lines visible above and below the cursor.
vim.opt.scrolloff = 5

-- Use spaces instead of tabs.
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Make the Neovim background transparent.
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
vim.cmd("highlight EndOfBuffer guibg=NONE ctermbg=NONE")


-- Loeschen von Stuff
vim.opt.backspace = { "indent", "eol", "start" }
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("i", "<C-v>", '<C-r>+', { desc = "Paste from system clipboard" })
vim.keymap.set("v", "<C-v>", '"+p', { desc = "Paste from system clipboard" })
