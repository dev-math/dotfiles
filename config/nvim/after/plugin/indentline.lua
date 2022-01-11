require("indent_blankline").setup {
   indentLine_enabled = 1,
   char = "▏",
   filetype_exclude = {
      "help",
      "alpha",
      "terminal",
      "dashboard",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "nvchad_cheatsheet",
   },
   buftype_exclude = { "terminal" },
   show_trailing_blankline_indent = false,
   show_first_indent_level = false,
}
