require('lualine').setup {
  options = {
    globalstatus = true,
    theme = 'auto',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_b = { { 'diagnostics' } },
    lualine_x = { {
      'tabs',
      mode = '2',
      path = '0',
    } }
  }
}
