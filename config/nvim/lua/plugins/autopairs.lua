local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
  return
end

autopairs.setup({
  check_ts = true,
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
    java = false,
  },
  disable_filetype = { 'TelescopePrompt', 'vim' },
  fast_wrap = {},
})

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
