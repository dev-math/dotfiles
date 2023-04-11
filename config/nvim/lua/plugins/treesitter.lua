local ok, treesitter = pcall(require, "nvim-treesitter")
if not ok then
  return
end

require 'nvim-treesitter.configs'.setup {
  auto_install = true,
  ignore_install = {
    "haskell",
  },
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
    "vim",
    "vimdoc",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  autotag = { enable = true },
  matchup = { enable = true },
  indent = { enable = true },
  context_commentstring = { enable = true },
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = false,
    },
  },
}
