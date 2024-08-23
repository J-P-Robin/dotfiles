local wk = require("which-key")

----- AUTO-SESSION -----
wk.add({
  {
    "<leader>ws",
    "<cmd> SessionSave <CR>",
    desc = "Save Session",
  },
  {
    "<leader>wr",
    "<cmd> SessionRestore <CR>",
    desc = "Restore Session",
  },
  {
    "<leader>wf",
    "<cmd> SessionSearch <CR>",
    desc = "Find Session",
  },
})

----- FORMATTING -----
--[[ wk.add({
	{
		"<leader>bf",
		function()
			require("conform").format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end,
		desc = "Format (Conform)",
	},
})
 ]]
----- HARPOON -----
local harpoon_telescope = function()
  local harpoon = require("harpoon")
  local telescope_conf = require("telescope.config").values

  local function toggle(harpoon_files)
    local make_finder = function()
      local paths = {}
      for index, item in ipairs(harpoon_files.items) do
        table.insert(paths, {
          value = item.value,
          display = string.format("(%s) %s", index, item.value),
          ordinal = item.value,
        })
      end

      return require("telescope.finders").new_table({
        results = paths,
        entry_maker = function(entry)
          return {
            value = entry.value,
            display = entry.display,
            ordinal = entry.ordinal,
            path = entry.value,
          }
        end,
      })
    end

    require("telescope.pickers")
      .new({}, {
        prompt_title = "Harpoon",
        finder = make_finder(),
        previewer = telescope_conf.file_previewer({}),
        sorter = telescope_conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          map("i", "<C-d>", function()
            local state = require("telescope.actions.state")
            local selected_entry = state.get_selected_entry()
            local current_picker = state.get_current_picker(prompt_bufnr)

            table.remove(harpoon_files.items, selected_entry.index)
            current_picker:refresh(make_finder())
          end)

          map("i", "<C-c>", function()
            local state = require("telescope.actions.state")
            local current_picker = state.get_current_picker(prompt_bufnr)

            harpoon:list():clear()
            current_picker:refresh(make_finder())
          end)

          return true
        end,
      })
      :find()
  end

  return toggle(harpoon:list())
end

wk.add({
  {
    "<leader>ha",
    function()
      require("harpoon"):list():add()
      vim.notify("Added to Harpoon")
    end,
    desc = "Add to Harpoon",
  },
  {
    "<leader>hc",
    function()
      require("harpoon"):list():clear()
      vim.notify("Cleared Harpoon")
    end,
    desc = "Clear Harpoon",
  },
  {
    "<leader>hd",
    function()
      require("harpoon"):list():remove_at()
    end,
    desc = "Remove from Harpoon",
  },
  {
    "<leader>h1",
    function()
      require("harpoon"):list():select(1)
    end,
    desc = "Harpoon 1",
  },
  {
    "<leader>h2",
    function()
      require("harpoon"):list():select(2)
    end,
    desc = "Harpoon 2",
  },
  {
    "<leader>h3",
    function()
      require("harpoon"):list():select(3)
    end,
    desc = "Harpoon 3",
  },
  {
    "<leader>h4",
    function()
      require("harpoon"):list():select(4)
    end,
    desc = "Harpoon 4",
  },
  {
    "<leader>hp",
    function()
      require("harpoon"):list():prev()
    end,
    desc = "Previous Harpoon",
  },
  {
    "<leader>hn",
    function()
      require("harpoon"):list():next()
    end,
    desc = "Next Harpoon",
  },
  { "<leader>hh", harpoon_telescope, desc = "Harpoon" },
})

----- LAZYGIT -----
wk.add({
  { "<leader>lg", "<cmd> LazyGit <CR>", desc = "LazyGit" },
})

----- LINTING -----
wk.add({
  {
    "<leader>l",
    function()
      require("lint").try_lint()
    end,
    desc = "Lint",
  },
})

----- LSP -----
wk.add({
  { "<leader>bh", vim.lsp.buf.hover, desc = "Buffer Hover" },
  { "<leader>bd", vim.lsp.buf.definition, desc = "Buffer Definition" },
  { "<leader>br", vim.lsp.buf.references, desc = "Buffer References" },
  { "<leader>ba", vim.lsp.buf.code_action, desc = "Buffer Code Action" },
  {
    "<leader>bf",
    function()
      require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })

      -- vim.lsp.buf.format()
    end,
    desc = "Buffer Format",
  },
})

----- NEOTREE -----
wk.add({
  { "<C-n>", "<cmd> Neotree filesystem reveal left<CR>", desc = "File Explorer" },
})

----- OIL -----
wk.add({
  { "-", "<cmd> Oil <CR>", desc = "Open parent directory" },
})

----- TELESCOPE -----
wk.add({
  { "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "Find Files" },
  { "<leader>fg", "<cmd> Telescope live_grep <CR>", desc = "Live Grep" },
  { "<leader>fs", "<cmd> Telescope grep_string <CR>", desc = "Find string" },
  { "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "Buffers" },
  { "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "Help" },
  { "<leader>FF", "<cmd> Telescope file_browser <CR>", desc = "File Browser" },
})

----- TMUX -----
wk.add({
  { "<C-h>", "<cmd> TmuxNavigateLeft <CR>", desc = "Navigate left" },
  { "<C-j>", "<cmd> TmuxNavigateDown <CR>", desc = "Navigate down" },
  { "<C-k>", "<cmd> TmuxNavigateUp <CR>", desc = "Navigate up" },
  { "<C-l>", "<cmd> TmuxNavigateRight <CR>", desc = "Navigate right" },
  { "<C-\\>", "<cmd> TmuxNavigatePrevious <CR>", desc = "Navigate previous" },
})

----- TREESJ -----
wk.add({
  { "<leader>j", "<cmd> TSJToggle <CR>", desc = "Toggle block split/join" },
})

----- TROUBLE -----
wk.add({
  { "<leader>xx", "<cmd> Trouble diagnostics toggle <CR>", desc = "Diagnostics" },
  { "<leader>xX", "<cmd> Trouble diagnostics toggle filter.buf=0 <CR>", desc = "Buffer Diagnostics" },
  { "<leader>xs", "<cmd> Trouble symbols toggle focus=false <CR>", desc = "Symbols" },
  {
    "<leader>xl",
    "<cmd> Trouble lsp toggle focus=false win.position=right <CR>",
    desc = "LSP Definitions / references / ... ",
  },
  { "<leader>xL", "<cmd> Trouble loclist toggle <CR>", desc = "Location List" },
  { "<leader>xQ", "<cmd> Trouble qflist toggle <CR>", desc = "Quickfix List" },
})

----- UNDOTREE -----
wk.add({
  { "<leader>u", "<cmd> UndotreeToggle <CR>", desc = "Undotree" },
})

----- VIM -----
wk.add({
  { "<C-d>", "<C-d>zz", desc = "Center cursor on half scroll down" },
  { "<C-u>", "<C-u>zz", desc = "Center cursor on half scroll up" },
})

wk.add({
  mode = "v",
  { "J", ":m '>+1<CR>gv=gv", desc = "Move selection up" },
  { "K", ":m '<-2<CR>gv=gv", desc = "Move selection down" },
})

wk.add({
  { "J", "mzJ`z", desc = "Join lines with cursor" },
})

wk.add({
  { "n", "nzzzv", desc = "Center cursor on search down" },
  { "N", "Nzzzv", desc = "Center cursor on search up" },
})

wk.add({
  mode = "x",
  { "<leader>p", '"_dP', desc = "Paste without yank" },
})

wk.add({
  mode = "v",
  { "<leader>y", '"+y', desc = "Copy to clipboard" },
  { "<leader>Y", '"+Y', desc = "Copy to clipboard" },
})

wk.add({
  { "<leader>s", "<cmd> %s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", desc = "Replace word under cursor" },
})

wk.add({
  { "<leader>nh", "<cmd> nohl <CR>", desc = "Clear search highlights" },
})
