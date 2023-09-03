vim.diagnostic.config({
	virtual_text = true,
})

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return
end

local ok, mason = pcall(require, "mason")
if not ok then
	return
end
mason.setup()

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
	return
end

local u = require("utils")
local config = require("lsp.servers.default")
local skip_server_setup = { "jdtls" }

mason_lspconfig.setup({
	ensure_installed = { "clangd", "tsserver", "html", "cssls", "jsonls", "jdtls" },
	automatic_installation = false, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
})

mason_lspconfig.setup_handlers({
	function(server_name) -- default handler (optional)
		if u.contains(skip_server_setup, server_name) then
			return
		end

		local server_ok, server_config = pcall(require, "lsp.servers." .. server_name)
		if server_ok then
			config = u.merge(config, server_config)
		end

		local status_ok, coq = pcall(require, "coq")
		if not status_ok then
			lspconfig[server_name].setup(config)
		else
			lspconfig[server_name].setup(coq.lsp_ensure_capabilities(config))
		end
	end,
})
