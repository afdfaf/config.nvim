-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command under that to load whatever the name of that colorscheme is.
--
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
-- vim.pack.add { { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' } }
-- vim.pack.add { { src = 'https://github.com/folke/tokyonight.nvim' } }
vim.pack.add { { src = 'https://github.com/wtfox/jellybeans.nvim' } }
-- vim.pack.add { { src = 'https://github.com/serhez/teide.nvim' } }
-- vim.pack.add { { src = 'https://github.com/uhs-robert/oasis.nvim' } }
-- vim.pack.add { { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } }
-- vim.pack.add { { src = 'https://github.com/rebelot/kanagawa.nvim' } }

-- require('rose-pine').setup {
--   styles = {
--     bold = true,
--     italic = false,
--     transparency = false,
--   },
-- }

-- Load the colorscheme here.
-- Like many other themes, this one has different styles, and you could load
-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
vim.cmd.colorscheme 'jellybeans'
