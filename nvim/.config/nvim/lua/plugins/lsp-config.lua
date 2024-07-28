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

      -- BORDERS

      vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
      vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "single"
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
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
