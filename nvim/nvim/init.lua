require("config.options")
require("config.keymaps")
require("config.lazy")

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.g.nord_uniform_status_lines = 0
vim.g.nord_cursor_line_number_background = 1
vim.g.nord_uniform_diff_background = 1

pcall(vim.cmd.colorscheme, "nord")
