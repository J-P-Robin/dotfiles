return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end,
  config = function()
    require("catppuccin").setup({
      flavour = vim.env.THEME_MODE == "light" and "latte" or "mocha",
			transparent_background = true,
			color_overrides = {},
			highlight_overrides = {
				all = function(colors)
					return {
            --Cursor = { fg = "#ffffff", bg = colors.rosewater },
						CursorLineNr = { fg = colors.rosewater, style = { "bold" } },
						CursorLine = { bg = "NONE" },

            CmpItemMenu = { fg = colors.surface0 },
					}
				end,
			},
      integrations = {
        mason = true,
        neotree = true,
      },
    })
  end,
}
