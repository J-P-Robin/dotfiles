return {
  "milanglacier/minuet-ai.nvim",
  lazy = false,
  config = function()
    require("minuet").setup({
      provider = "openai_compatible",
      context_window = 6000,
      n_completions = 1,
      throttle = 1500,
      debounce = 700,
      request_timeout = 4,
      default_system_prefix_first = {
        template = "{{{prompt}}}\n{{{guidelines}}}",
        prompt = "You are an inline code completion engine.",
        guidelines = [[Return only the code inserted at <cursorPosition>.
Never explain, use Markdown fences, or repeat context.
Keep the completion concise.]],
        n_completion_template = "",
      },
      virtualtext = {
        auto_trigger_ft = { "*" },
        keymap = {
          accept = "<C-g>",
          accept_line = "<C-l>",
          next = "<C-]>",
          dismiss = "<C-e>",
        },
      },
      provider_options = {
        openai_compatible = {
          name = vim.env.LITELLM_API_NAME,
          api_key = "LITELLM_API_KEY",
          end_point = vim.env.LITELLM_COMPLETIONS_ENDPOINT,
          model = "gpt-4.1",
          stream = false,
          optional = {
            max_tokens = 48,
            temperature = 0.2,
          },
        },
      },
    })

    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("MinuetAutoTrigger", { clear = true }),
      callback = function(args)
        if vim.bo[args.buf].buftype == "" and vim.bo[args.buf].filetype ~= "" then
          vim.b[args.buf].minuet_virtual_text_auto_trigger = true
        end
      end,
      desc = "Enable Minuet ghost text in file buffers",
    })

    if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
      vim.b.minuet_virtual_text_auto_trigger = true
    end
  end,
}
