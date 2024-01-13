-- Load treesitter grammar for org
require("orgmode").setup_ts_grammar()

-- Setup treesitter
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "org" },
	},
	ensure_installed = { "org" },
})

-- Setup orgmode
require("orgmode").setup({
	org_agenda_files = "~/Syncthing/notes/**/*",
	org_default_notes_file = "~/Syncthing/notes/refile.org",
	org_deadline_warning_days = 5,
	org_agenda_start_on_weekday = 7,
	org_highlight_latex_and_related = "native",
	notifications = { enabled = true },
})
