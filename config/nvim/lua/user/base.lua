local options = {
	hidden = true,
	linebreak = true,
	smarttab = true,
  backup = false,
  clipboard = "unnamedplus",
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",
  encoding = "utf-8",
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showtabline = 2,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  timeoutlen = 500,
  writebackup = false,
  shiftwidth = 2,
  tabstop = 2,
  number = true,
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
	dir = "~/.config/nvim/swap//,/tmp//,."   -- Store swap files in fixed location, not current directory
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
