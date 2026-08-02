local languages = {
  "css",
  "diff",
  "git_config",
  "gitignore",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "query",
  "scss",
  "toml",
  "tsx",
  "twig",
  "typescript",
  "vim",
  "vimdoc",
  "vue",
  "yaml",
}

local filetypes = {
  "css",
  "diff",
  "git_config",
  "gitignore",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "lua",
  "markdown",
  "query",
  "scss",
  "toml",
  "typescript",
  "typescriptreact",
  "twig",
  "vim",
  "vue",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install(languages)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "V",
            ["@class.outer"] = "<C-v>",
          },
          include_surrounding_whitespace = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      for _, mode in ipairs({ "x", "o" }) do
        vim.keymap.set(mode, "af", function()
          select.select_textobject("@function.outer", "textobjects")
        end)
        vim.keymap.set(mode, "if", function()
          select.select_textobject("@function.inner", "textobjects")
        end)
        vim.keymap.set(mode, "ac", function()
          select.select_textobject("@class.outer", "textobjects")
        end)
        vim.keymap.set(mode, "ic", function()
          select.select_textobject("@class.inner", "textobjects")
        end)
        vim.keymap.set(mode, "as", function()
          select.select_textobject("@local.scope", "locals")
        end)
      end
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
