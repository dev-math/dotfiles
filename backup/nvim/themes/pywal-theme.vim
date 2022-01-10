syntax on
colorscheme wal

" We don't need to see things like -- INSERT -- anymore
set noshowmode

lua << EOF
require'lualine'.setup{
	options = { theme = "pywal" }
}
EOF
