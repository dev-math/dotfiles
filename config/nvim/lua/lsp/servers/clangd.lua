local M = {}
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.offsetEncoding = { "utf-16" }
return M
