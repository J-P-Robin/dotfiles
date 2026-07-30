return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Oil",
  config = function()
    local oil = require("oil")
    local git_ignored = setmetatable({}, {
      __index = function(self, key)
        local proc = vim.system({ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" }, {
          cwd = key,
          text = true,
        })
        local result = proc:wait()
        local ret = {}
        if result.code == 0 then
          for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
            line = line:gsub("/$", "")
            table.insert(ret, line)
          end
        end

        rawset(self, key, ret)
        return ret
      end,
    })

    oil.setup({
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
      },
      view_options = {
        is_hidden_file = function(name, _)
          local dir = oil.get_current_dir()

          if not dir then
            return false
          end

          return vim.list_contains(git_ignored[dir], name)
        end,
        is_always_hidden = function(name, bufnr)
          return vim.startswith(name, ".git")
        end,
      },
    })
  end,
}
