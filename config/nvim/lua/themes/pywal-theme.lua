vim.cmd [[
syntax on
colorscheme wal

" We don't need to see things like -- INSERT -- anymore
set noshowmode
]]

require'lualine'.setup{
	options = { theme = "pywal" }
}
