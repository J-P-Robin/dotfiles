return {
  "Wansmer/treesj",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = "TSJToggle",
  config = function()
    require("treesj").setup()
  end,
}
