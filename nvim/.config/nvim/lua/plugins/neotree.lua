return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    require('neo-tree').setup({
      filesystem = {
        filtered_items = {
          visible = false,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignore = false,
          hide_by_name = {
            '.DS_Store',
            'thumbs.db',
            '.git',
            '.github',
            '.husky',
            '.vscode',
          }
        }
      }
    })
  end,
}
