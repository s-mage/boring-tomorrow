-- .config/nvim/lua/boring-tomorrow/init.lua
-- Boring Tomorrow colorscheme.
-- Colors used by the colorscheme itself, fzf.vim and lualine.nvim live here.
-- for autoload: :help runtimepath

local M = {}

M.term_colors = {
  black = "NONE",
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

-- usage: in init.lua
--   local boring_tomorrow = require("boring-tomorrow")
--   vim.g.fzf_colors = boring_tomorrow.fzf_colors
--
-- https://github.com/junegunn/fzf/blob/master/README-VIM.md#explanation-of-gfzf_colors
M.fzf_colors = {
  fg      = {'fg', 'Normal'},
  bg      = {'bg', 'Normal'},
  hl      = {'fg', 'Normal'},
  ['fg+'] = {'fg', 'Normal'},
  ['bg+'] = {'bg', 'Visual' },
  ['hl+'] = {'fg', 'Normal'},
  info    = {'fg', 'Normal'},
  border  = {'bg', 'Normal'},
  prompt  = {'fg', 'Normal'},
  pointer = {'fg', 'Exception'},
  marker  = {'fg', 'Normal'},
  spinner = {'fg', 'Normal'},
  header  = {'fg', 'Normal'}
}

-- usage: in init.lua
--   require('lualine').setup { options = { theme = boring-tomorrow.lualine_theme } }
-- https://github.com/nvim-lualine/lualine.nvim
M.lualine_theme = {
  normal = {
    a = { fg = M.term_colors.br_white, bg = M.term_colors.green, gui = 'bold' },
    b = { fg = M.term_colors.black, bg = M.term_colors.white },
    c = { fg = M.term_colors.black, bg = M.term_colors.white },
  },
  insert = { a = { fg = M.term_colors.br_white, bg = M.term_colors.blue, gui = 'bold' } },
  visual = { a = { fg = M.term_colors.br_white, bg = M.term_colors.red, gui = 'bold' } },
  replace = { a = { fg = M.term_colors.br_white, bg = M.term_colors.magenta, gui = 'bold' } },
  inactive = {
    a = { fg = M.term_colors.black, bg = M.term_colors.white, gui = 'bold' },
    b = { fg = M.term_colors.black, bg = M.term_colors.white },
    c = { fg = M.term_colors.black, bg = M.term_colors.white },
  },
}

-- usage: in colors/boring-tomorrow.lua
--   require("boring-tomorrow").load()
-- test colors: :highlight
function M.load()
  vim.o.background = "light"
  vim.o.termguicolors = false

  if vim.g.colors_name then vim.cmd("hi clear") end

  vim.cmd("syntax reset")

  vim.g.colors_name = "Boring Tomorrow"

  local t = M.term_colors

  -- Used by UI elements implicitly
  local foreground = t.black
  local background = "NONE"
  local selection = t.white
  local window = "NONE"

  -- github diff colors
  local diffadd = t.br_green
  local diffrm = t.br_red
  local diffupdateadd = t.br_green
  local diffupdaterm = t.br_red

  local hl = function(group, params)
    return vim.api.nvim_set_hl(0, group, params)
  end

  -- Interface Highlighting
  hl("LineNr", { ctermfg = t.br_black })
  hl("Normal", { ctermfg = foreground, ctermbg = background })
  hl("NormalFloat", { link = "Normal" })
  hl("Winbar", { link = "Normal" })
  hl("WinbarNC", { link = "Normal" })
  hl("NonText", { ctermfg = selection })
  hl("SpecialKey", { ctermfg = selection })
  hl("Search", { ctermbg = t.br_yellow })
  hl("CurSearch", { ctermbg = t.br_yellow })
  hl("TabLine", { ctermbg = window, ctermfg = foreground, reverse = true })
  hl("TabLineFill", { ctermbg = window, ctermfg = foreground, reverse = true })
  hl("StatusLine", { ctermbg = window, ctermfg = window, reverse = true })
  hl("StatusLineNC", { ctermbg = window, ctermfg = foreground, reverse = true })
  hl("VertSplit", { ctermbg = window, ctermfg = window })
  hl("Visual", { ctermbg = selection })
  hl("Directory", { ctermfg = foreground })
  hl("ModeMsg", { ctermbg = background })
  hl("MoreMsg", { ctermbg = background })
  hl("Question", { ctermbg = background })
  hl("WarningMsg", { ctermfg = foreground, ctermbg = t.br_red })
  hl("ErrorMsg", { ctermfg = foreground, ctermbg = diffupdaterm })
  hl("NvimInternalError", { ctermfg = foreground, ctermbg = t.br_red })
  hl("MatchParen", { ctermbg = t.br_yellow })
  hl("Folded", { ctermbg = background, ctermfg = foreground })
  hl("FoldColumn", { ctermbg = background })
  hl("CursorLine", { ctermbg = window })
  hl("CursorColumn", { ctermbg = window })
  hl("Cursor", { ctermbg = foreground, ctermfg = background })
  hl("PMenu", { ctermfg = foreground, ctermbg = selection })
  hl("PMenuSel", { ctermfg = foreground, ctermbg = selection, reverse = true })
  hl("PMenuThumb", { ctermfg = foreground, ctermbg = selection, reverse = true })
  hl("SignColumn", { ctermbg = background })
  hl("ColorColumn", { ctermbg = window })
  hl("Conceal", { ctermfg = foreground, ctermbg = selection })

  -- comments are important, make them stand out
  hl("Comment", { bold = true, ctermfg = foreground })
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

  hl("diffAdded", { ctermbg = diffadd })
  hl("diffRemoved", { ctermbg = diffrm })
  hl("DiffAdd", { ctermbg = diffupdateadd })
  hl("DiffChange", {})
  hl("DiffDelete", { ctermbg = diffrm })
  hl("DiffText", { ctermbg = diffupdateadd })

  hl("CocGitChangedSign", { ctermbg = background })
  hl("CocGitAddedSign", { ctermbg = background })
  hl("CocGitRemovedSign", { ctermbg = background })
  hl("CocGitChangeRemovedSign", { ctermbg = background })

  -- ShowMarks Highlighting
  hl("ShowMarksHLl", { ctermfg = t.yellow, ctermbg = background })
  hl("ShowMarksHLo", { ctermfg = t.magenta, ctermbg = background })
  hl("ShowMarksHLu", { ctermfg = t.br_yellow, ctermbg = background })
  hl("ShowMarksHLm", { ctermfg = t.cyan, ctermbg = background })

  -- misc
  hl("Underlined", { ctermfg = foreground })
  hl("CocMenuSel", { bold = true })
  hl("CocSearch", { ctermfg = foreground, ctermbg = t.br_yellow })

end

return M
