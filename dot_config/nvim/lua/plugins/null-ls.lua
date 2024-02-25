-- Formatter and linter
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    { "jayp0521/mason-null-ls.nvim" },
  },
  config = function()
    local null_ls = require("null-ls")
    require("mason-null-ls").setup({
      ensure_installed = nil,
      handlers = {},
      automatic_installation = true,
    })

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
        -- formatting.prettier_eslint.with(eslint_config),
        code_actions.eslint_d.with(eslint_config),
        diagnostics.eslint_d.with(eslint_config),
      },
    })
  end
}
