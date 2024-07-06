return {
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          -- CSS
          'stylelint_lsp',
          'cssls',
          'cssmodules_ls',
          'css_variables',
          'somesass_ls',
          -- JS
          'eslint',
          'tsserver',
          'biome',
          'vtsls',
          'volar',
          'vuels',
          -- HTML
          'html',
          -- JSON
          'jsonls',
          -- MARKDOWN
          'markdown_oxide',
          'marksman',
          'prosemd_lsp',
          'remark_ls',
          'vale_ls',
          'zk',
          -- YAML
          'hydra_lsp',
          'yamlls'
        }
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })

      lspconfig.eslint.setup({
        capabilities = capabilities,
        flags = { debounce_text_changes = 500 },
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = true
          if client.resolved_capabilities.document_formatting then
            local au_lsp = vim.api.nvim_create_augroup('eslint_lsp', { clear = true })
            vim.api.nvim_create_autocmd('BufWritePre', {
              pattern = '*',
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
        filetypes = { 'css', 'scss' },
        settings = {
          stylelintplus = {
            autoFixOnFormat = true,
            autoFixOnSave = true,
          },
        },
        root_dir = lspconfig.util.root_pattern('package.json', '.git'),
        on_attach = function(client)
          client.server_capabilities.document_formatting = false
        end
      })
    end
  }
}
