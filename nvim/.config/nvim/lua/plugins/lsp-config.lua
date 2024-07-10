return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })

      lspconfig.eslint.setup({
        capabilities = capabilities,
        flags = { debounce_text_changes = 500 },
        on_attach = function(client)
          client.resolved_capabilities.document_formatting = true
          if client.resolved_capabilities.document_formatting then
            local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
              pattern = "*",
              callback = function()
                vim.lsp.buf.formatting_sync()
              end,
              group = au_lsp,
            })
          end
        end,
      })

      lspconfig.stylelint_lsp.setup({
        capabilities = capabilities,
        filetypes = { "css", "scss" },
        settings = {
          stylelintplus = {
            autoFixOnFormat = true,
            autoFixOnSave = true,
          },
        },
        root_dir = lspconfig.util.root_pattern("package.json", ".git"),
        on_attach = function(client)
          client.server_capabilities.document_formatting = false
        end,
      })
    end,
  },
}
