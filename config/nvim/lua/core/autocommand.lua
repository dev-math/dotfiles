-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Autocommand that reloads neovim whenever you save config files
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/* source <afile> | PackerSync
    autocmd BufWritePost ~/.config/nvim/lua/core/config.lua source ~/.config/nvim/lua/core/plugins.lua | PackerSync
  augroup end
]]

-- formatoptios dont take effect on editor.lua
vim.cmd [[
  autocmd BufWinEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd BufRead * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd BufNewFile * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
]]

vim.cmd [[
  augroup format_on_save
    autocmd!
    autocmd BufWritePre *.prisma lua vim.lsp.buf.formatting_sync()
  augroup end
]]
