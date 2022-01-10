local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require "lsp.null-ls"
require "lsp.handlers"
require "lsp.lspconfig"
require "lsp.lsp-signature"
require "lsp.lsp-installer"
