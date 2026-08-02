return {
  "folke/snacks.nvim",
  event = "VeryLazy",
  opts = {
    notifier = {
      enabled = true,
      timeout = 6000,
      style = "notification",
    },
    input = { enabled = true },
    picker = {
      enabled = true,
      ui_select = true,
    },
  },
}
