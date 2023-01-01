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
    formatting.clang_format,
    formatting.prettierd.with({
      prefer_local = "node_modules/.bin",
    }),
    formatting.stylua,
    formatting.eslint_d.with({
      prefer_local = "node_modules/.bin",
    }),
    code_actions.eslint_d({
      prefer_local = "node_modules/.bin",
    }),
    diagnostics.eslint_d({
      prefer_local = "node_modules/.bin",
    }),
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
