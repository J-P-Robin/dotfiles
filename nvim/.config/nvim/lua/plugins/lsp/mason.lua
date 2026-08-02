return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "cssls",
          "cssmodules_ls",
          "emmet_language_server",
          "eslint",
          "html",
          "jsonls",
          "lua_ls",
          "stylelint_lsp",
          "ts_ls",
          "twiggy_language_server",
        },
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "oxfmt",
          "oxlint",
          "twigcs",
          "twig-cs-fixer",
        },
      })
    end,
  },
}
