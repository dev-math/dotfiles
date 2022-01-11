" Imports "{{{
lua << EOF
require "keymaps"
require "plugins"
EOF
source $HOME/.config/nvim/themes/dracula-theme.vim
" source $HOME/.config/nvim/themes/pywal-theme.vim
"}}}

" Base "{{{
set hidden                              " Required to keep multiple buffers open multiple buffers
set linebreak
set nobackup                            
set nowritebackup                       
set clipboard=unnamedplus               " Copy paste between vim and everything else
set conceallevel=0                      " So that I can see `` in markdown files
set fileencoding=utf-8                  " The encoding written to file
set encoding=utf-8                      " The encoding displayed
set ignorecase
set mouse=a                             " Enable your mouse
set pumheight=10                        " Makes popup menu smaller
set showtabline=2                       " Always show tabs
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set noswapfile
set timeoutlen=100
set undofile
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set smartindent                         " Makes indenting smart
set expandtab                           " Converts tabs to spaces
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set tabstop=2                           " Insert 2 spaces for a tab
set number                              " Line numbers
set signcolumn=yes                      " always show the sign column, otherwise it would shift the text each time
set dir=~/.config/nvim/swap//,/tmp//    " Store swap files in fixed location, not current directory
set formatoptions-=cro                  " Stop newline continution of comments
au BufEnter * set fo-=c fo-=r fo-=o
" set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
" set cursorline                          " Enable highlighting of the current line
" set autoindent                          " Good auto indent
"}}}

" HTML indent {{{
" autocmd FileType html command! Format execute 'normal gg=G'
"}}}

" Need: https://github.com/bash-lsp/bash-language-server
" https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html

" vim: set foldmethod=marker foldlevel=0:
