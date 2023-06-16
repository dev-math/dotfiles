local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
  return
end

local ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not ok then
  return
end

local u = require('core.utils')
local default_config = require('lsp.servers.default')
local config = default_config

mason_lspconfig.setup {
  ensure_installed = { "clangd", "tsserver", "html", "cssls", "jsonls", "jdtls" },
  automatic_installation = false, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
}

mason_lspconfig.setup_handlers {
  function(server_name)  -- default handler (optional)
    if server_name == 'jsonls' then
      config = u.merge(config, require('lsp.servers.jsonls'))
    elseif server_name == 'sumneko_lua' then
      config = u.merge(config, require('lsp.servers.sumneko_lua'))
    elseif server_name == 'clangd' then
      config = u.merge(config, require('lsp.servers.clangd'))
    elseif server_name == 'tsserver' then
      config = u.merge(config, require('lsp.servers.tsserver'))
    elseif server_name == 'jdtls' then
      return
    end

    local status_ok, coq = pcall(require, "coq")
    if not status_ok then
      lspconfig[server_name].setup(config)
    else
      lspconfig[server_name].setup(coq.lsp_ensure_capabilities(config))
    end
  end,
}
