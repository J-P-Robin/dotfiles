return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    indent = { char = "|" },
    scope = { highlight = "IndentBlanklineIndent1", show_start = false, show_end = false },
  },
}
