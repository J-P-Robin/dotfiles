return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			color_overrides = {
				all = {
					surface1 = "#6C7086",
					base = "#323244",
				},
			},
			highlight_overrides = {
				all = function(colors)
					return {
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
