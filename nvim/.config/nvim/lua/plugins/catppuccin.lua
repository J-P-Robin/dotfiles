return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
      flavour = "mocha",
			transparent_background = true,
			color_overrides = {},
			highlight_overrides = {
				all = function(colors)
					return {
            --Cursor = { fg = "#ffffff", bg = colors.rosewater },
						CursorLineNr = { fg = colors.rosewater, style = { "bold" } },
						CursorLine = { bg = "NONE" },
					}
				end,
			},
		})
	end,
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
