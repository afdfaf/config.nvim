return {
  -- Markdown Syntax + Tools
  {
    'preservim/vim-markdown',
    ft = 'markdown',
    dependencies = {
      'godlygeek/tabular', -- Required for formatting
    },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0 -- Disable symbol concealment
      vim.g.vim_markdown_new_list_item_indent = 2
    end,
  },

  -- Live Preview (requires `glow` or `markdown-preview.nvim`)
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
