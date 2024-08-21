return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
		"hrsh7th/nvim-cmp",
	},
	event = "VeryLazy",
	config = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
			views = {
				cmdline_popup = {
					position = "50%",
				},
			},
		})
	end,
}
