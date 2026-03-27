vim.opt.termguicolors = true

pcall(vim.cmd.colorscheme, "nord")

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

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2E3440" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#434C5E" })
vim.api.nvim_set_hl(0, "Search", { fg = "#2E3440", bg = "#EBCB8B" })
vim.api.nvim_set_hl(0, "IncSearch", { fg = "#2E3440", bg = "#88C0D0" })
