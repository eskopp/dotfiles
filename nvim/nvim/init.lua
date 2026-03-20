-- Show normal line numbers.
vim.opt.number = true

-- Make the Neovim background transparent.
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
vim.cmd("highlight EndOfBuffer guibg=NONE ctermbg=NONE")

-- Do not use relative line numbers.
vim.opt.relativenumber = false

-- Enable mouse support.
vim.opt.mouse = "a"
