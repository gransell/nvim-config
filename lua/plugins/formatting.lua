return {
  'stevearc/conform.nvim',
  events = { 'BufReadPre', 'BufNewFile' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = false }
      end,
      mode = { 'n', 'v' },
      desc = 'Format buffer',
    },
  },
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      css = { 'prettierd' },
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      swift = { 'swift_format' },
    },
    format_on_save = {
      lsp_fallback = false,
      async = false,
    },
  },
}
