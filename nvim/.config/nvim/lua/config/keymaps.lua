local wk = require("which-key")

----- HARPOON -----
local harpoon_telescope = function()
	local harpoon = require("harpoon")
	local telescope_conf = require("telescope.config").values

	local function toggle(harpoon_files)
		local make_finder = function()
			local paths = {}
			for index, item in ipairs(harpoon_files.items) do
				local title = string.format("(%s) %s", index, item.value)
				table.insert(paths, title)
			end

			return require("telescope.finders").new_table({
				results = paths,
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
		end,
		desc = "Add to Harpoon",
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

----- LSP -----
wk.add({
	{ "<leader>bh", vim.lsp.buf.hover, desc = "Buffer Hover" },
	{ "<leader>bd", vim.lsp.buf.definition, desc = "Buffer Definition" },
	{ "<leader>br", vim.lsp.buf.references, desc = "Buffer References" },
	{ "<leader>ba", vim.lsp.buf.code_action, desc = "Buffer Code Action" },
	{ "<leader>bf", vim.lsp.buf.format, desc = "Buffer Format" },
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

--[[

----- VIM -----
-- center cursor on half scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
]]
--
-- move selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {})
--[[
-- keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z", {})
-- center cursor on search
vim.keymap.set("n", "n", "nzzzv", {})
vim.keymap.set("n", "N", "Nzzzv", {})
-- paste without yank
vim.keymap.set("x", "<leader>p", '"_dP', {})
]]
--
-- copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', {})
vim.keymap.set("n", "<leader>Y", '"+Y', {})
-- replace word under cursor
--[[
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {})
]]
--
