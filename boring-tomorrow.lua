-- test colors: :highlight

vim.o.background = "light"
vim.o.termguicolors = false

if vim.g.colors_name then vim.cmd("hi clear") end

vim.cmd("syntax reset")

vim.g.colors_name = "Boring Tomorrow"

-- Default Colours using ANSI standard integers
local term_colors = {
  black = 0,
  red = 1,
  green = 2,
  yellow = 3,
  blue = 4,
  magenta = 5,
  cyan = 6,
  white = 7,
  br_black = 8,
  br_red = 9,
  br_green = 10,
  br_yellow = 11,
  br_blue = 12,
  br_magenta = 13,
  br_cyan = 14,
  br_white = 15,
}

-- Used by UI elements implicitly
local foreground = term_colors.black
local background = term_colors.br_white
local selection = term_colors.white
local window = term_colors.white

-- github diff colors
local diffadd = term_colors.green
local diffrm = term_colors.red
local diffupdateadd = term_colors.br_green
local diffupdaterm = term_colors.br_red

local hl = function(group, params)
  local cterm_params = {}
  if params.fg then cterm_params.ctermfg = params.fg end
  if params.bg then cterm_params.ctermbg = params.bg end
  if params.bold then
    cterm_params.bold = true
    cterm_params.cterm = cterm_params.cterm or {}
    cterm_params.cterm.bold = true
  end
  if params.reverse then
    cterm_params.reverse = true
    cterm_params.cterm = cterm_params.cterm or {}
    cterm_params.cterm.reverse = true
  end
  if params.link then cterm_params.link = params.link end
  return vim.api.nvim_set_hl(0, group, cterm_params)
end

-- Interface Highlighting
hl("LineNr", { fg = term_colors.br_black })
hl("Normal", { fg = foreground, bg = background })
hl("NormalFloat", { link = "Normal" })
hl("Winbar", { link = "Normal" })
hl("WinbarNC", { link = "Normal" })
hl("NonText", { fg = selection })
hl("SpecialKey", { fg = selection })
hl("Search", { bg = term_colors.br_yellow })
hl("CurSearch", { bg = term_colors.br_yellow })
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
hl("WarningMsg", { fg = foreground, bg = term_colors.br_red })
hl("ErrorMsg", { fg = foreground, bg = diffupdaterm })
hl("NvimInternalError", { fg = foreground, bg = term_colors.br_red })
hl("MatchParen", { bg = term_colors.br_yellow })
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
hl("Comment", { fg = term_colors.green, bold = true })
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
hl("ShowMarksHLl", { fg = term_colors.yellow, bg = background })
hl("ShowMarksHLo", { fg = term_colors.magenta, bg = background })
hl("ShowMarksHLu", { fg = term_colors.br_yellow, bg = background })
hl("ShowMarksHLm", { fg = term_colors.cyan, bg = background })

-- misc
hl("Underlined", { fg = foreground })
hl("CocMenuSel", { bold = true })
hl("CocSearch", { fg = foreground, bg = term_colors.br_yellow })
