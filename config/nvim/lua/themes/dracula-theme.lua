vim.cmd [[
syntax on
colorscheme dracula

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
endif

" We don't need to see things like -- INSERT -- anymore
set noshowmode

if system('pgrep -x picom > /dev/null && echo 1 || echo 0') == 1
	highlight Normal guibg=NONE
else
	highlight Normal guibg=#282A36
endif
]]

require'lualine'.setup{
	options = { theme = "dracula" }
}
