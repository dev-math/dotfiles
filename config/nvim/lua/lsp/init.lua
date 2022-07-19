local ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not ok then
  return
end

local ok, fidget = pcall(require, 'fidget')
if ok then
  fidget.setup{}
end

require('lsp.lsp-installer')
require('lsp.lspconfig')
require('lsp.handlers')
