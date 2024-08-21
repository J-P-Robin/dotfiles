return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspStart", "LspStop", "LspRestart", "LspTrouble", "LspLog" },
		config = function()
			require("lspconfig.ui.windows").default_options.border = "single"

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lsp_servers = {
				cssls = {
					init_options = {
						provideFormatter = false,
					},
				},
				cssmodules_ls = {},
				css_variables = {},
				emmet_language_server = {
					filetypes = {
						"html",
						"css",
						"scss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"html",
						"twig",
					},
					init_options = {
						includeLanguages = {
							twig = "html",
						},
					},
				},
				eslint = {
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = true
						if client.server_capabilities.documentFormattingProvider then
							vim.api.nvim_create_autocmd("BufWritePre", {
								pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
								callback = function()
									vim.lsp.buf.format({ async = true })
								end,
								group = vim.api.nvim_create_augroup("eslint_lsp", { clear = true }),
							})
						end
					end,
				},
				html = {},
				jsonls = {},
				lua_ls = {
					on_init = function(client)
						client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
									"${3rd}/luv/library",
								},
							},
						})
					end,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				},
				stylelint_lsp = {
					settings = {
						stylelintplus = {
							autoFixOnFormat = true,
							autoFixOnSave = true,
						},
					},
					filetypes = { "css", "scss" },
					root_dir = lspconfig.util.root_pattern("package.json", ".git"),
					on_attach = function(client)
						client.server_capabilities.document_formatting = false
					end,
				},
				tsserver = {
					on_attach = function(client)
						client.server_capabilities.document_formatting = false
					end,
				},
				twiggy_language_server = {},
			}

			for server, opts in pairs(lsp_servers) do
				lspconfig[server].setup(vim.tbl_deep_extend("force", opts, {
					capabilities = capabilities,
				}))
			end

			-- UI

			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = true,
			})

			local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- BORDERS

			--vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
			--vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=red guibg=#1f2335]])
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			---@diagnostic disable-next-line: duplicate-set-field
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or "single"
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			-- Diagnostic dialog on hover

			vim.opt.updatetime = 250
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false })
				end,
			})
		end,
	},
}
