vim.opt.termguicolors = true

pcall(vim.cmd.colorscheme, "catppuccin")

local transparent_groups = {
  "Normal",
  "NormalNC",
  "EndOfBuffer",
  "SignColumn",
  "FoldColumn",
  "LineNr",
  "NormalFloat",
  "FloatBorder",
  "Pmenu",
  "PmenuSel",
  "TelescopeNormal",
  "TelescopeBorder",
  "TelescopePromptNormal",
  "TelescopePromptBorder",
  "TelescopeResultsNormal",
  "TelescopeResultsBorder",
  "TelescopePreviewNormal",
  "TelescopePreviewBorder",
}

for _, group in ipairs(transparent_groups) do
  vim.api.nvim_set_hl(0, group, { bg = "NONE" })
end

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#313244" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#45475A" })
vim.api.nvim_set_hl(0, "Search", { fg = "#1E1E2E", bg = "#F9E2AF" })
vim.api.nvim_set_hl(0, "IncSearch", { fg = "#1E1E2E", bg = "#F5C2E7" })
