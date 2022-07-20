do
  local ok, _ = pcall(require, 'impatient')

  if not ok then
    vim.notify('impatient.nvim not installed', vim.log.levels.WARN)
  end
end
require('core')
require('lsp')
require'lspconfig'.tsserver.setup {}
