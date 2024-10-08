return {
  "ggandor/leap.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local leap = require("leap")

    leap.add_default_mappings()
    leap.opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

    -- Override some old defaults - use backspace instead of tab (see issue #165).
    leap.opts.special_keys.prev_target = "<backspace>"
    leap.opts.special_keys.prev_group = "<backspace>"

    -- Use the traversal keys to repeat the previous motion without explicitly
    -- invoking Leap.
    require("leap.user").set_repeat_keys("<enter>", "<backspace>")
  end,
}
