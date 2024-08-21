return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local flavour = vim.env.THEME_MODE == "light" and "latte" or "mocha"
    local catppuccin = require("catppuccin.palettes").get_palette(flavour)
    local custom_theme = require("lualine.themes.catppuccin")
    custom_theme.inactive.c.bg = catppuccin.crust

    local lazy_status = require("lazy.status")

    require("lualine").setup({
      options = {
        theme = custom_theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = catppuccin.peach },
          },
          { "filetype" },
        },
      },
    })
  end,
}
