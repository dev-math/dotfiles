return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "andymass/vim-matchup",
    "windwp/nvim-ts-autotag",
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "comment",
        "cpp",
        "css",
        "glimmer",
        "go",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "markdown",
        "org",
        "lua",
        "php",
        "python",
        "query",
        "rst",
        "rust",
        "scss",
        "svelte",
        "tsx",
        "typescript",
        "tsx",
        "vim",
        "vimdoc",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "org", "markdown" },
      },
      autotag = { enable = true },
      matchup = { enable = true },
      indent = { enable = true },
      refactor = {
        highlight_definitions = {
          enable = true,
          -- Set to false if you have an `updatetime` of ~100.
          clear_on_cursor_move = false,
        },
      },
    })
  end
}
