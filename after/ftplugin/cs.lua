-- Filetype-specific settings
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

-- Attach LSP keymaps only for C#
local lsp = require 'lspconfig'
if lsp.csharp_ls.manager then
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = 'Goto Definition' })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = true, desc = 'Code Action' })
end
