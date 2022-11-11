local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
  return
end

require('lsp.lsp-installer')
require('lsp.handlers')
require('lsp.lsp-signature')
require('lsp.lspconfig')

local ok, fidget = pcall(require, 'fidget')
if ok then
  fidget.setup{}
end
