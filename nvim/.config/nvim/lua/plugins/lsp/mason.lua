return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup({})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"cssls",
					"cssmodules_ls",
					"css_variables",
					"emmet_language_server",
					"html",
					"jsonls",
					"lua_ls",
					"stylelint_lsp",
					"tsserver",
				},
				automatic_installation = true,
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"twigcs",
					"twig-cs-fixer",
				},
			})
		end,
	},
}
