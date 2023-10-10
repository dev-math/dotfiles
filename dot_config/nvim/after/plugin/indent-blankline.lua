local ok, indent_blankline = pcall(require, "ibl")
if not ok then
  return
end

indent_blankline.setup {
  indent = {
    char = "┊"
  },
  exclude = {
    filetypes = {
      "help",
      "alpha",
      "terminal",
      "dashboard",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
    },
    buftypes = { "terminal" },
  }
}
