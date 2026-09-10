-- opencode.nvim — bridge between nvim and the opencode TUI.
--
-- Flow: highlight code (or not) -> <leader>oa to ask -> prompt input pops ->
-- submit -> the opencode TUI split shows so you can continue the session there.
-- Edits opencode makes reload in nvim buffers; permission requests surface here.

local opencode_cmd = "opencode --port"

---@type snacks.terminal.Opts
local snacks_terminal_opts = {
  win = {
    position = "right",
    enter = false,
  },
}

return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    event = "VeryLazy",
    init = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Start an integrated opencode server in a snacks terminal split if none
        -- is already running. The plugin auto-discovers any running `opencode --port`.
        server = {
          start = function()
            require("snacks").terminal.open(opencode_cmd, snacks_terminal_opts)
          end,
        },
      }
    end,
    keys = {
      -- <C-.> toggles the opencode TUI split. Don't use <leader> here: nvim would
      -- add input delay to <leader> while typing in the terminal watching for the mapping.
      {
        "<C-.>",
        function()
          require("snacks").terminal.toggle(opencode_cmd, snacks_terminal_opts)
        end,
        desc = "Toggle OpenCode TUI",
      },
      -- Ask: opens prompt input. In visual mode, @this expands to the selection;
      -- in normal mode, to the cursor position.
      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ")
        end,
        mode = { "n", "x" },
        desc = "Ask OpenCode…",
      },
      -- Select: picker for built-in prompts (explain, fix, review, test, …), commands, servers.
      {
        "<leader>os",
        function()
          require("opencode").select()
        end,
        mode = { "n", "x" },
        desc = "Select OpenCode…",
      },
      -- Operator: pending motion appends a range as @this to the prompt. Dot-repeatable.
      {
        "go",
        function()
          return require("opencode").operator("@this ")
        end,
        mode = { "n", "x" },
        expr = true,
        desc = "Append range to OpenCode",
      },
      {
        "goo",
        function()
          return require("opencode").operator("@this ") .. "_"
        end,
        mode = "n",
        expr = true,
        desc = "Append line to OpenCode",
      },
      -- Scroll the opencode session from any buffer.
      {
        "<S-C-u>",
        function()
          require("opencode").command("session.half.page.up")
        end,
        desc = "Scroll OpenCode up",
      },
      {
        "<S-C-d>",
        function()
          require("opencode").command("session.half.page.down")
        end,
        desc = "Scroll OpenCode down",
      },
    },
    config = function()
      -- Show the TUI split when a prompt is submitted so you can continue the
      -- session in opencode without manually focusing the terminal.
      vim.api.nvim_create_autocmd("User", {
        pattern = { "OpencodeEvent:tui.command.execute" },
        callback = function(args)
          ---@type opencode.server.Event
          local event = args.data.event
          if event.properties.command == "prompt.submit" then
            local win = require("snacks").terminal.get(opencode_cmd, { create = false })
            if win then
              win:show()
            end
          end
        end,
      })
    end,
  },

  -- Completions (contexts, subagents) in the opencode prompt input via blink.cmp.
  -- The plugin exposes an in-process LSP for the `opencode_ask` filetype.
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        per_filetype = {
          opencode_ask = { "lsp", "buffer" },
        },
        providers = { lsp = { fallbacks = {} } },
      },
    },
  },
}
