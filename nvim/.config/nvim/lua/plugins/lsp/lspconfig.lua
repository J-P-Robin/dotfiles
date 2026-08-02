return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspStart", "LspStop", "LspRestart", "LspLog" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local eslint_markers = {
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        "eslint.config.ts",
        "eslint.config.mts",
        "eslint.config.cts",
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml",
      }

      local servers = {
        cssls = {
          init_options = { provideFormatter = false },
        },
        cssmodules_ls = {},
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
            "twig",
          },
          init_options = {
            includeLanguages = { twig = "html" },
          },
        },
        eslint = { root_markers = eslint_markers },
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = {
                checkThirdParty = false,
                library = {
                  [vim.env.VIMRUNTIME .. "/lua"] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                  ["${3rd}/luv/library"] = true,
                },
              },
            },
          },
        },
        stylelint_lsp = {
          settings = {
            stylelintplus = {
              autoFixOnFormat = true,
              autoFixOnSave = false,
            },
          },
          filetypes = { "css", "scss" },
        },
        ts_ls = {},
        twiggy_language_server = {},
      }

      for name, config in pairs(servers) do
        vim.lsp.config(name, vim.tbl_deep_extend("force", config, { capabilities = capabilities }))
        vim.lsp.enable(name)
      end

      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
      })

      local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }
      for type, icon in pairs(signs) do
        local highlight = "DiagnosticSign" .. type
        vim.fn.sign_define(highlight, { text = icon, texthl = highlight, numhl = highlight })
      end

      local open_floating_preview = vim.lsp.util.open_floating_preview
      ---@diagnostic disable-next-line: duplicate-set-field
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "single"
        return open_floating_preview(contents, syntax, opts, ...)
      end

      vim.opt.updatetime = 250
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
        callback = function()
          vim.diagnostic.open_float(nil, { focus = false, border = "single" })
        end,
      })
    end,
  },
}
