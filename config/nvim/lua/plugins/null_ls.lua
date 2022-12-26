local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettierd,
    formatting.stylua,
    formatting.eslint_d,
    code_actions.eslint_d,
    diagnostics.eslint_d,
  },
}

local ok, mason_null_ls = pcall(require, "mason-null-ls")
if not ok then
  return
end

mason_null_ls.setup {
  ensure_installed = nil,
  automatic_installation = true,
  automatic_setup = false,
}
