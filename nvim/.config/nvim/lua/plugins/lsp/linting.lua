local ox_markers = {
  ".oxfmtrc.json",
  ".oxfmtrc.jsonc",
  "oxfmt.config.ts",
  "oxfmt.config.mts",
  "oxlint.json",
  ".oxlintrc.json",
}

local javascript_filetypes = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
}

local function is_ox_project(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  return vim.fs.find(ox_markers, { path = filename, upward = true })[1] ~= nil
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
        javascript = { "oxlint" },
        javascriptreact = { "oxlint" },
        typescript = { "oxlint" },
        typescriptreact = { "oxlint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("Oxlint", { clear = true }),
        callback = function(args)
          if javascript_filetypes[vim.bo[args.buf].filetype] and is_ox_project(args.buf) then
            lint.try_lint("oxlint")
          end
        end,
      })
    end,
  },
}
