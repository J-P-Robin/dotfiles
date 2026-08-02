return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "default",
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-e>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        menu = { border = "single" },
        documentation = { window = { border = "single" } },
      },
      sources = {
        default = { "lsp", "path", "buffer" },
        providers = {
          cmdline = {
            min_keyword_length = function(ctx)
              if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                return 3
              end

              return 0
            end,
          },
        },
      },
      cmdline = {
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
      },
    },
  },
}
