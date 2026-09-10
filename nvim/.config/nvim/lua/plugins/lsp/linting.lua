local ox_markers = {
  ".oxfmtrc.json",
  ".oxfmtrc.jsonc",
  "oxfmt.config.ts",
  "oxfmt.config.mts",
  "oxlint.json",
  ".oxlintrc.json",
}

local stylelint_markers = {
  ".stylelintrc",
  ".stylelintrc.js",
  ".stylelintrc.cjs",
  ".stylelintrc.json",
  ".stylelintrc.yaml",
  ".stylelintrc.yml",
  "stylelint.config.js",
  "stylelint.config.cjs",
  "stylelint.config.mjs",
}

local javascript_filetypes = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
}

local style_filetypes = {
  css = true,
  scss = true,
}

local function is_ox_project(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  return vim.fs.find(ox_markers, { path = filename, upward = true })[1] ~= nil
end

local function is_stylelint_project(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  return vim.fs.find(stylelint_markers, { path = filename, upward = true })[1] ~= nil
end

return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>bl",
        function()
          require("lint").try_lint()
        end,
        desc = "Run linter",
      },
    },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        css = { "stylelint" },
        javascript = { "oxlint" },
        javascriptreact = { "oxlint" },
        scss = { "stylelint" },
        typescript = { "oxlint" },
        typescriptreact = { "oxlint" },
      }

      -- stylelint's stderr (e.g. Browserslist nags) breaks the JSON parser
      lint.linters.stylelint.stream = "stdout"

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
        callback = function(args)
          local filetype = vim.bo[args.buf].filetype

          if javascript_filetypes[filetype] and is_ox_project(args.buf) then
            lint.try_lint("oxlint")
          end

          if style_filetypes[filetype] and is_stylelint_project(args.buf) then
            lint.try_lint("stylelint")
          end
        end,
      })
    end,
  },
}
