vim.opt.termguicolors = true
vim.o.background = "dark"

local set = vim.api.nvim_set_hl

set(0, "Normal",       { fg = "#F5EDED", bg = "#080608" })
set(0, "NormalNC",     { fg = "#D9C7C7", bg = "#080608" })
set(0, "EndOfBuffer",  { fg = "#080608", bg = "#080608" })
set(0, "SignColumn",   { bg = "#080608" })
set(0, "LineNr",       { fg = "#5B1A1A", bg = "#080608" })
set(0, "CursorLineNr", { fg = "#FF3B30", bg = "#080608", bold = true })
set(0, "CursorLine",   { bg = "#13090A" })

set(0, "Comment",    { fg = "#A98E8E", italic = true })
set(0, "Constant",   { fg = "#FF6B5A" })
set(0, "String",     { fg = "#D95F43" })
set(0, "Character",  { fg = "#D95F43" })
set(0, "Number",     { fg = "#FF875F" })
set(0, "Boolean",    { fg = "#FF875F", bold = true })
set(0, "Identifier", { fg = "#F5EDED" })
set(0, "Function",   { fg = "#FF3B30", bold = true })
set(0, "Statement",  { fg = "#FF3B30", bold = true })
set(0, "Keyword",    { fg = "#FF3B30", bold = true })
set(0, "Type",       { fg = "#FF6B5A" })
set(0, "Special",    { fg = "#FF5C5C" })
set(0, "PreProc",    { fg = "#B91C1C" })

set(0, "Visual",     { bg = "#3A1212" })
set(0, "Search",     { fg = "#080608", bg = "#FF6B5A" })
set(0, "IncSearch",  { fg = "#080608", bg = "#FF3B30" })
set(0, "MatchParen", { fg = "#FFFFFF", bg = "#5B1A1A", bold = true })

set(0, "Pmenu",      { fg = "#F5EDED", bg = "#12090A" })
set(0, "PmenuSel",   { fg = "#080608", bg = "#FF3B30", bold = true })
set(0, "NormalFloat",{ fg = "#F5EDED", bg = "#12090A" })
set(0, "FloatBorder",{ fg = "#FF3B30", bg = "#12090A" })

set(0, "DiagnosticError", { fg = "#FF1F1F" })
set(0, "DiagnosticWarn",  { fg = "#FF875F" })
set(0, "DiagnosticInfo",  { fg = "#FF6B5A" })
set(0, "DiagnosticHint",  { fg = "#D95F43" })

set(0, "TelescopeNormal",       { fg = "#F5EDED", bg = "#080608" })
set(0, "TelescopeBorder",       { fg = "#FF3B30", bg = "#080608" })
set(0, "TelescopePromptNormal", { fg = "#F5EDED", bg = "#12090A" })
set(0, "TelescopePromptBorder", { fg = "#FF3B30", bg = "#12090A" })
set(0, "TelescopeResultsNormal",{ fg = "#F5EDED", bg = "#080608" })
set(0, "TelescopeResultsBorder",{ fg = "#5B1A1A", bg = "#080608" })
set(0, "TelescopePreviewNormal",{ fg = "#F5EDED", bg = "#080608" })
set(0, "TelescopePreviewBorder",{ fg = "#5B1A1A", bg = "#080608" })
