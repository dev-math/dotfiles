local u = require('core.utils')
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local default_config = require('lsp.servers.default')

for _, server in ipairs(lsp_installer.get_installed_servers()) do
  local config = default_config

  if server.name == 'jsonls' then
    config = u.merge(config, require('lsp.servers.jsonls'))
  elseif server.name == 'sumneko_lua' then
    config = u.merge(config, require('lsp.servers.sumneko_lua'))
  elseif server.name == 'tsserver' then
    config = u.merge(config, require('lsp.servers.tsserver'))
  end

  local status_ok, coq = pcall(require, "coq")
  if not status_ok then
    lspconfig[server.name].setup(config)
  else
    lspconfig[server.name].setup(coq.lsp_ensure_capabilities(config))
  end
end
