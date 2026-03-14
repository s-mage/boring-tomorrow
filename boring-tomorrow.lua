-- test colors: :highlight

vim.o.background = "light"
vim.o.termguicolors = true

if vim.g.colors_name then vim.cmd("hi clear") end

vim.cmd("syntax reset")

vim.g.colors_name = "Boring Tomorrow"

-- Default GUI Colours
local foreground = "#000000"
local background = "#ffffff"
local selection = "#efefef"
local red = "#ffc1bf"
local orange = "#f5871f"
local yellow = "#fee2ae"
local aqua = "#3e999f"
local purple = "#8959a8"
local window = "#efefef"

-- github diff colors
local diffadd = "#e6ffeb"
local diffrm = "#ffebe9"
local diffupdateadd = "#aaf2bb"
local diffupdaterm = "#ffc1bf"

local hl = function(group, params) return vim.api.nvim_set_hl(0, group, params) end

-- Interface Highlighting
hl("LineNr", { fg = "darkGrey" })
hl("Normal", { fg = foreground, bg = background })
hl("NormalFloat", { link = "Normal" })
hl("Winbar", { link = "Normal" })
hl("WinbarNC", { link = "Normal" })
hl("NonText", { fg = selection })
hl("SpecialKey", { fg = selection })
hl("Search", { bg = yellow })
hl("CurSearch", { bg = yellow })
hl("TabLine", { bg = window, fg = foreground, reverse = true })
hl("TabLineFill", { bg = window, fg = foreground, reverse = true })
hl("StatusLine", { bg = window, fg = window, reverse = true })
hl("StatusLineNC", { bg = window, fg = foreground, reverse = true })
hl("VertSplit", { bg = window, fg = window })
hl("Visual", { bg = selection })
hl("Directory", { fg = foreground })
hl("ModeMsg", { bg = background })
hl("MoreMsg", { bg = background })
hl("Question", { bg = background })
hl("WarningMsg", { bg = red })
hl("ErrorMsg", { fg = foreground, bg = diffupdaterm })
hl("NvimInternalError", { bg = red })
hl("MatchParen", { bg = yellow })
hl("Folded", { bg = background, fg = foreground })
hl("FoldColumn", { bg = background })
hl("CursorLine", { bg = window })
hl("CursorColumn", { bg = window })
hl("Cursor", { bg = foreground, fg = background })
hl("PMenu", { fg = foreground, bg = selection })
hl("PMenuSel", { fg = foreground, bg = selection, reverse = true })
hl("PMenuThumb", { fg = foreground, bg = selection, reverse = true })
hl("SignColumn", { bg = background })
hl("ColorColumn", { bg = window })
hl("Conceal", { fg = foreground, bg = selection })

-- comments are important, make them stand out
hl("Comment", { bold = true })
hl("Todo", { link = "Comment" })

-- normalize the rest to be black on white
hl("Title", {})
hl("Identifier", {})
hl("Statement", {})
hl("Conditional", {})
hl("Repeat", {})
hl("Structure", {})
hl("Function", {})
hl("Constant", {})
hl("Keyword", {})
hl("String", {})
hl("Special", {})
hl("PreProc", {})
hl("Operator", {})
hl("Type", {})
hl("Define", {})
hl("Include", {})
hl("vimCommand", {})

-- git
hl("gitcommitSummary", { bold = true })

hl("diffAdded", { bg = diffadd })
hl("diffRemoved", { bg = diffrm })
hl("DiffAdd", { bg = diffupdateadd })
hl("DiffChange", {})
hl("DiffDelete", { bg = diffrm })
hl("DiffText", { bg = diffupdateadd })

hl("CocGitChangedSign", { bg = background })
hl("CocGitAddedSign", { bg = background })
hl("CocGitRemovedSign", { bg = background })
hl("CocGitChangeRemovedSign", { bg = background })

-- ShowMarks Highlighting
hl("ShowMarksHLl", { fg = orange, bg = background })
hl("ShowMarksHLo", { fg = purple, bg = background })
hl("ShowMarksHLu", { fg = yellow, bg = background })
hl("ShowMarksHLm", { fg = aqua, bg = background })

-- misc
hl("Underlined", { fg = foreground })
hl("CocMenuSel", { bold = true })
hl("CocSearch", { fg = foreground, bg = yellow })
