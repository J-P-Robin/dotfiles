return {
  "folke/which-key.nvim",
  -- keymaps.lua registers mappings through which-key during startup.
  lazy = false,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    require("which-key").setup({
      preset = "helix",
      delay = 500,
    })
  end,
}
