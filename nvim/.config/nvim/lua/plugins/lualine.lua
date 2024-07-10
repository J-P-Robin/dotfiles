return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local catppuccin = require("catppuccin.palettes").get_palette "mocha"
    local custom_theme = require 'lualine.themes.catppuccin'
    custom_theme.inactive.c.bg = catppuccin.crust

    require('lualine').setup({
      options = {
        theme = custom_theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
    })
  end,
}
