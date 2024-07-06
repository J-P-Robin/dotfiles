return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
	lazy = false,
  config = function()
    require "nvim-treesitter.configs".setup({
      sync_install = true,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
