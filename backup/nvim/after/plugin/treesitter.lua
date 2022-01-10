local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
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
	},
	highlight = {
		enable = true,
    use_languagetree = true,
  },
	autotag = { enable = true },
	matchup = { enable = true },
})
