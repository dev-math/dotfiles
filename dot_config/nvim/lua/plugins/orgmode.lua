return {
  "nvim-orgmode/orgmode",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", lazy = true },
    "akinsho/org-bullets.nvim",
  },
  event = "VeryLazy",
  config = function()
    -- Load treesitter grammar for org
    require("orgmode").setup_ts_grammar()
    -- Setup orgmode
    require("orgmode").setup({
      org_agenda_files = "~/Syncthing/notes/**/*",
      org_default_notes_file = "~/Syncthing/notes/refile.org",
      org_deadline_warning_days = 5,
      org_agenda_start_on_weekday = 7,
      org_highlight_latex_and_related = "native",
      notifications = { enabled = true },
    })
    -- replaces the asterisks in org syntax with unicode characters.
    require('org-bullets').setup()
  end
}
