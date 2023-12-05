require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	ensure_installed = {
		"clangd",
		"tsserver",
		"html",
		"cssls",
		"jsonls",
		"jdtls",
		"rust_analyzer",
		"lua_ls",
		"intelephense",
	},
})

local skip_server_setup = { "jdtls" }
local config = require("lsp_servers.default_config")

mason_lspconfig.setup_handlers({
	-- default handler
	function(server_name)
		-- skip server
		for _, value in ipairs(skip_server_setup) do
			if value == server_name then
				return
			end
		end

		local ok, server_config = pcall(require, "lsp_servers." .. server_name)
		if ok then
			-- merge tables
			config = vim.tbl_deep_extend("force", config, server_config)
		end

		require("lspconfig")[server_name].setup(config)
	end,
})
