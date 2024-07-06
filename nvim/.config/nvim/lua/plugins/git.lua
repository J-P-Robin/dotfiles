return {
	{
		"tpope/vim-fugitive",
		lazy = true,
		cmd = "Git",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
        signcolumn = true,
			})
		end,
	},
}
