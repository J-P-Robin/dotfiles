return {
  "rmagatti/auto-session",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("auto-session").setup({
      auto_session_suppress_dirs = { "~/", "~/Work", "~/Downloads", "~/Documents", "~/Desktop" },
      post_restore_cmds = {
        function()
          vim.schedule(function()
            vim.cmd("filetype detect")
            for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_loaded(buffer) and vim.bo[buffer].buflisted and vim.bo[buffer].filetype ~= "" then
                vim.api.nvim_buf_call(buffer, vim.treesitter.start)
              end
            end
          end)
        end,
      },
    })
  end,
}
