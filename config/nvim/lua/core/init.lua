-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.termguicolors = true          -- set term gui colors (most terminals support this)

require('core.plugins')
require('core.editor')
require('core.keymaps')
require('core.autocommand')
require('core.utils')
