return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      },
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local action_layout = require("telescope.actions.layout")

      telescope.setup({
        pickers = {
          find_files = {
            hidden = true,
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob",
              "!**/.git/*",
            },
          },
        },
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--with-filename",
            "--column",
            "--smart-case",
            "--hidden",
          },
          mappings = {
            n = {
              ["<M-p>"] = action_layout.toggle_preview,
            },
            i = {
              ["<esc>"] = actions.close,
              ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
              ["<M-p>"] = action_layout.toggle_preview,
            },
          },
        },
      })

      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    lazy = true,
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          file_browser = {
            hidden = true,
            auto_depth = true,
            git_status = false,
            display_stat = false,
          },
        },
      })

      telescope.load_extension("file_browser")
    end,
  },
}
