local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
	vim.notify("JDTLS not found")
	return
end

local config = require("lsp.servers.jdtls")

jdtls.start_or_attach(config)
