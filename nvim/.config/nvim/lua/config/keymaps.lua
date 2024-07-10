-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- NeoTree
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})

-- LSP
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- TMUX
vim.keymap.set('n', 'C-h', ':TmuxNavigateLeft<CR>', {})
vim.keymap.set('n', 'C-j', ':TmuxNavigateDown<CR>', {})
vim.keymap.set('n', 'C-k', ':TmuxNavigateUp<CR>', {})
vim.keymap.set('n', 'C-l', ':TmuxNavigateRight<CR>', {})

-- Testing
vim.keymap.set('n', '<leader>t', ':TestNearest<CR>', {})
vim.keymap.set('n', '<leader>T', ':TestFile<CR>', {})
vim.keymap.set('n', '<leader>a', ':TestSuite<CR>', {})
vim.keymap.set('n', '<leader>l', ':TestLast<CR>', {})
vim.keymap.set('n', '<leader>g', ':TestVisit<CR>', {})
