vim.opt.termguicolors = true
vim.o.background = "dark"

local set = vim.api.nvim_set_hl

set(0, "Normal",       { fg = "#F4E7DA", bg = "#2B211C" })
set(0, "NormalNC",     { fg = "#DFCCBB", bg = "#2B211C" })
set(0, "EndOfBuffer",  { fg = "#2B211C", bg = "#2B211C" })
set(0, "SignColumn",   { bg = "#2B211C" })
set(0, "LineNr",       { fg = "#8F6F5A", bg = "#2B211C" })
set(0, "CursorLineNr", { fg = "#DDA15E", bg = "#2B211C", bold = true })
set(0, "CursorLine",   { bg = "#332720" })

set(0, "Comment",    { fg = "#BFA089", italic = true })
set(0, "Constant",   { fg = "#D4A373" })
set(0, "String",     { fg = "#C39A76" })
set(0, "Character",  { fg = "#C39A76" })
set(0, "Number",     { fg = "#E9C46A" })
set(0, "Boolean",    { fg = "#E9C46A", bold = true })
set(0, "Identifier", { fg = "#F4E7DA" })
set(0, "Function",   { fg = "#DDA15E", bold = true })
set(0, "Statement",  { fg = "#DDA15E", bold = true })
set(0, "Keyword",    { fg = "#DDA15E", bold = true })
set(0, "Type",       { fg = "#E0A96D" })
set(0, "Special",    { fg = "#B66A50" })
set(0, "PreProc",    { fg = "#C08A6E" })

set(0, "Visual",     { bg = "#6B4F3D" })
set(0, "Search",     { fg = "#2B211C", bg = "#E9C46A" })
set(0, "IncSearch",  { fg = "#2B211C", bg = "#DDA15E" })
set(0, "MatchParen", { fg = "#FFF5EC", bg = "#8F6F5A", bold = true })

set(0, "Pmenu",      { fg = "#F4E7DA", bg = "#332720" })
set(0, "PmenuSel",   { fg = "#2B211C", bg = "#DDA15E", bold = true })
set(0, "NormalFloat",{ fg = "#F4E7DA", bg = "#332720" })
set(0, "FloatBorder",{ fg = "#DDA15E", bg = "#332720" })

set(0, "DiagnosticError", { fg = "#B66A50" })
set(0, "DiagnosticWarn",  { fg = "#E9C46A" })
set(0, "DiagnosticInfo",  { fg = "#C39A76" })
set(0, "DiagnosticHint",  { fg = "#BFA089" })

set(0, "TelescopeNormal",       { fg = "#F4E7DA", bg = "#2B211C" })
set(0, "TelescopeBorder",       { fg = "#DDA15E", bg = "#2B211C" })
set(0, "TelescopePromptNormal", { fg = "#F4E7DA", bg = "#332720" })
set(0, "TelescopePromptBorder", { fg = "#DDA15E", bg = "#332720" })
set(0, "TelescopeResultsNormal",{ fg = "#F4E7DA", bg = "#2B211C" })
set(0, "TelescopeResultsBorder",{ fg = "#8F6F5A", bg = "#2B211C" })
set(0, "TelescopePreviewNormal",{ fg = "#F4E7DA", bg = "#2B211C" })
set(0, "TelescopePreviewBorder",{ fg = "#8F6F5A", bg = "#2B211C" })
