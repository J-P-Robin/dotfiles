local wk = require("which-key")

-- File explorers.
wk.add({ { "<C-n>", "<cmd>Neotree toggle filesystem reveal left<CR>", desc = "Toggle file explorer" } })
wk.add({ { "-", "<cmd>Oil<CR>", desc = "Open parent directory" } })

-- Telescope.
wk.add({
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
  { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
  { "<leader>fs", "<cmd>Telescope grep_string<CR>", desc = "Grep word under cursor" },
  { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
  { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find help" },
  { "<leader>FF", "<cmd>Telescope file_browser<CR>", desc = "File browser" },
})

-- Git.
wk.add({ { "<leader>lg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" } })

-- Terminal.
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle terminal" })

-- Tmux panes and Neovim splits.
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate up" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate right" })
vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", { desc = "Navigate previous" })

-- Sessions.
wk.add({
  { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
  { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session" },
  { "<leader>wf", "<cmd>SessionSearch<CR>", desc = "Find session" },
})

-- Undo history.
wk.add({ { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" } })

-- Structured code split/join.
wk.add({ { "<leader>j", "<cmd>TSJToggle<CR>", desc = "Toggle split/join" } })

-- Harpoon pins the small set of files active for the current task.
local harpoon_telescope = function()
  local harpoon = require("harpoon")
  local telescope_conf = require("telescope.config").values
  local harpoon_list = harpoon:list()

  local function make_finder()
    local paths = {}
    for index, item in ipairs(harpoon_list.items) do
      table.insert(paths, {
        value = item.value,
        display = string.format("(%s) %s", index, item.value),
        ordinal = item.value,
        index = index,
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
          index = entry.index,
        }
      end,
    })
  end

  require("telescope.pickers").new({}, {
      prompt_title = "Harpoon",
      finder = make_finder(),
      previewer = telescope_conf.file_previewer({}),
      sorter = telescope_conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        map("i", "<C-d>", function()
          local state = require("telescope.actions.state")
          local picker = state.get_current_picker(prompt_bufnr)
          local selected = state.get_selected_entry()

          harpoon_list:remove_at(selected.index)
          picker:refresh(make_finder())
        end)
        map("i", "<C-c>", function()
          local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)

          harpoon_list:clear()
          picker:refresh(make_finder())
        end)
        return true
      end,
    })
    :find()
end

wk.add({
  {
    "<leader>ha",
    function()
      require("harpoon"):list():add()
      vim.notify("Added file to Harpoon")
    end,
    desc = "Add file",
  },
  {
    "<leader>hc",
    function()
      require("harpoon"):list():clear()
      vim.notify("Cleared Harpoon files")
    end,
    desc = "Clear marked files",
  },
  {
    "<leader>hd",
    function()
      require("harpoon"):list():remove()
      vim.notify("Removed file from Harpoon")
    end,
    desc = "Remove current file",
  },
  {
    "<leader>hh",
    function()
      local harpoon = require("harpoon")
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "Toggle menu",
  },
  { "<leader>ht", harpoon_telescope, desc = "Find marked files" },
  { "<leader>h1", function() require("harpoon"):list():select(1) end, desc = "Go to file 1" },
  { "<leader>h2", function() require("harpoon"):list():select(2) end, desc = "Go to file 2" },
  { "<leader>h3", function() require("harpoon"):list():select(3) end, desc = "Go to file 3" },
  { "<leader>h4", function() require("harpoon"):list():select(4) end, desc = "Go to file 4" },
  { "<leader>hp", function() require("harpoon"):list():prev() end, desc = "Previous file" },
  { "<leader>hn", function() require("harpoon"):list():next() end, desc = "Next file" },
})

-- LSP navigation. Formatting returns with the formatting task.
wk.add({
  { "<leader>bh", vim.lsp.buf.hover, desc = "Hover documentation" },
  { "<leader>bd", vim.lsp.buf.definition, desc = "Go to definition" },
  { "<leader>br", vim.lsp.buf.references, desc = "Find references" },
  { "<leader>ba", vim.lsp.buf.code_action, desc = "Code action" },
})

-- Diagnostics and lists.
wk.add({
  { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Project diagnostics" },
  { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
  {
    "<leader>xs",
    "<cmd>Trouble symbols toggle<CR>",
    desc = "Document symbols",
  },
  { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP list" },
  { "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
  { "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
})

-- Core Vim mappings. Plugin mappings return with their respective features.
wk.add({
  { "<C-d>", "<C-d>zz", desc = "Center cursor on half scroll down" },
  { "<C-u>", "<C-u>zz", desc = "Center cursor on half scroll up" },
})

wk.add({
  mode = "v",
  { "J", ":m '>+1<CR>gv=gv", desc = "Move selection down" },
  { "K", ":m '<-2<CR>gv=gv", desc = "Move selection up" },
})

wk.add({ { "J", "mzJ`z", desc = "Join lines with cursor" } })

wk.add({
  { "n", "nzzzv", desc = "Center cursor on search down" },
  { "N", "Nzzzv", desc = "Center cursor on search up" },
})

wk.add({ mode = "x", { "<leader>p", '"_dP', desc = "Paste without yank" } })
wk.add({ mode = "v", { "<leader>y", '"+y', desc = "Copy to clipboard" } })

wk.add({
  {
    "<leader>r",
    "<cmd> %s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    desc = "Replace word under cursor",
  },
})

wk.add({ { "<leader>nh", "<cmd> nohl <CR>", desc = "Clear search highlights" } })
