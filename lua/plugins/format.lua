-- [[ Formatting ]]
vim.pack.add { 'https://github.com/stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = {
    -- I recommend these options. See :help conform.format for details.
    lsp_format = 'fallback',
    timeout_ms = 500,
  },
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  -- You can also specify external formatters in here.
  formatters_by_ft = {
    lua = { 'stylua' },
    java = { 'google-java-format' },
    go = { 'gofmt' },
    -- Conform can also run multiple formatters sequentially
    -- python = { 'isort', 'black' },
    -- cs = { 'csharpier' },
    --
    -- You can use 'stop_after_first' to run the first available formatter from the list
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  -- custom options
  formatters = {
    ['google-java-format'] = {
      prepend_args = { '--aosp' },
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format { async = true }
end, { desc = '[F]ormat buffer' })
