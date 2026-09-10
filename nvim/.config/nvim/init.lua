-- fnm use-on-cd can pin an old Node (e.g. .nvmrc v10) that breaks Mason's Node-based LSP servers
vim.env.PATH = vim.env.HOME .. "/Library/Application Support/fnm/aliases/neovim-node/bin:" .. vim.env.PATH

require("config.options")
require("config.lazy")
require("config.keymaps")
