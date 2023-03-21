local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local eslint_config = {
	prefer_local = "node_modules/.bin",
	condition = function(utils)
		return utils.root_has_file({
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.yaml",
			".eslintrc.yml",
			".eslintrc.json",
		})
	end,
}

null_ls.setup({
	debug = false,
	sources = {
		formatting.clang_format,
		formatting.prettierd.with({
			prefer_local = "node_modules/.bin",
		}),
		formatting.stylua,
		formatting.prettier_eslint.with(eslint_config),
		code_actions.eslint_d.with(eslint_config),
		diagnostics.eslint_d.with(eslint_config),
	},
})

local ok, mason_null_ls = pcall(require, "mason-null-ls")
if not ok then
	return
end

mason_null_ls.setup({
	ensure_installed = nil,
	automatic_installation = false,
	automatic_setup = true,
})
