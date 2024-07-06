return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local custom_dracula = require 'lualine.themes.dracula'
    custom_dracula.normal.c.bg = 'NONE'
    custom_dracula.insert.c.bg = 'NONE'
    custom_dracula.visual.c.bg = 'NONE'
    custom_dracula.replace.c.bg = 'NONE'
    custom_dracula.command.c.bg = 'NONE'
    custom_dracula.inactive.c.bg = 'NONE'

    require('lualine').setup({
      options = {
        theme = custom_dracula,
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
    })
  end,
}
