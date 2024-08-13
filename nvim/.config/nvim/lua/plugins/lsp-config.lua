return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          --require("none-ls.diagnostics.eslint"),
          --require("none-ls.formatting.eslint_d"),
          --require("none-ls.code_actions.eslint_d"),
          --null_ls.builtins.diagnostics.stylelint,
          --null_ls.builtins.formatting.stylelint.with({
          --  extra_args = { "--fix" },
          --}),
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lsp_servers = {
        "cssls",
        "cssmodules_ls",
        "css_variables",
        "emmet_language_server",
        "html",
        "jsonls",
        "lua_ls",
      }

      for _, server in ipairs(lsp_servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end

      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = function(client)
          client.server_capabilities.document_formatting = false
        end,
      })

      lspconfig.eslint.setup({
        capabilities = capabilities,
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
      })

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
