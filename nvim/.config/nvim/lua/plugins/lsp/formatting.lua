local javascript_filetypes = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
}

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

local ox_markers = {
  ".oxfmtrc.json",
  ".oxfmtrc.jsonc",
  "oxfmt.config.ts",
  "oxfmt.config.mts",
  "oxlint.json",
  ".oxlintrc.json",
}

local function project_has_marker(filename, markers)
  return vim.fs.find(markers, { path = filename, upward = true })[1] ~= nil
end

local function format_options(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)

  if javascript_filetypes[vim.bo[bufnr].filetype] then
    if project_has_marker(filename, eslint_markers) then
      return {
        lsp_format = "prefer",
        timeout_ms = 1000,
        filter = function(client)
          return client.name == "eslint"
        end,
      }
    end

    if project_has_marker(filename, ox_markers) then
      return { lsp_format = "never", timeout_ms = 1000 }
    end

    return nil
  end

  return { lsp_format = "never", timeout_ms = 1000 }
end

return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>bf",
        function()
          local opts = format_options(0)
          if opts then
            opts.async = true
            require("conform").format(opts)
          end
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        twig = { "twig-cs-fixer" },
        javascript = { "oxfmt" },
        javascriptreact = { "oxfmt" },
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
      },
      formatters = {
        oxfmt = {
          condition = function(_, ctx)
            return project_has_marker(ctx.filename, ox_markers)
          end,
        },
      },
      format_on_save = format_options,
    },
  },
}
