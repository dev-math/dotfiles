local ok, mason = pcall(require, 'mason')
if not ok then
  return
end

local on_windows = vim.loop.os_uname().version:match 'Windows'

local function join_paths(...)
  local path_sep = on_windows and '\\' or '/'
  local result = table.concat({ ... }, path_sep)
  return result
end

mason.setup {
  install_root_dir = join_paths(vim.call('stdpath', 'data'), 'lsp_servers'),
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}

local ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not ok then
  return
end

mason_lspconfig.setup {
  ensure_installed = { "clangd", "tsserver", "html", "cssls", "jsonls", "jdtls" },
  automatic_installation = false, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
}
