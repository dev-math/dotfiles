local M = {}

M.root_dir = function(fname)
	local util = require("lspconfig").util
	return util.root_pattern(".git")(fname)
		or util.root_pattern("tsconfig.base.json")(fname)
		or util.root_pattern("package.json")(fname)
		or util.root_pattern(".eslintrc.js")(fname)
		or util.root_pattern(".eslintrc.json")(fname)
		or util.root_pattern("tsconfig.json")(fname)
end

M.autostart = true

M.single_file_support = true

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)

return M
