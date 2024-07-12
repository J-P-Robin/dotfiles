----- TELESCOPE -----
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

----- NEOTREE -----
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})

----- UNDOTREE -----
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", {})

----- LSP -----
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

----- TMUX -----
vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>", {})
vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>", {})

----- VIM -----
-- center cursor on half scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
-- move selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {})
-- keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z", {})
-- center cursor on search
vim.keymap.set("n", "n", "nzzzv", {})
vim.keymap.set("n", "N", "Nzzzv", {})
-- paste without yank
vim.keymap.set("x", "<leader>p", '"_dP', {})
-- copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", {})
vim.keymap.set("n", "<leader>Y", "\"+Y", {})
-- replace word under cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {})
