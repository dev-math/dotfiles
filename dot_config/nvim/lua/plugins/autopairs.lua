return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {},
  config = function()
    local autopairs = require("nvim-autopairs")

    local cmp = require("cmp")
    autopairs.setup({
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "vim" },
      fast_wrap = {},
    })
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
  end,
}
