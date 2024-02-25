return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip", -- Required
    "rafamadriz/friendly-snippets", -- Set of preconfigured snippets
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "andersevenrud/cmp-tmux",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    vim.keymap.set({"i"}, "<leader>se", function() luasnip.expand() end, {silent = true})
    vim.keymap.set({"i", "s"}, "<leader>sn", function() luasnip.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<leader>sp", function() luasnip.jump(-1) end, {silent = true})

    luasnip.config.set_config({
      history = true,
      -- Update more often, :h events for more info.
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    })

    luasnip.snippets = {
      all = {},
      html = {},
    }

    -- enable html snippets in javascript/javascript(REACT)
    luasnip.snippets.javascript = luasnip.snippets.html
    luasnip.snippets.javascriptreact = luasnip.snippets.html
    luasnip.snippets.typescriptreact = luasnip.snippets.html

    -- You can also use lazy loading so you only get in memory snippets of languages you use
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup({})

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    cmp.setup({
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "orgmode" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "nvim_lua", ft = "lua" },
        -- { name = "cmdline" },
      }),
    })
  end
}
