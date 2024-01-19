set = vim.opt

set.number = true
set.mouse = ''
set.ignorecase = true
set.hlsearch = false
set.wrap = true
set.breakindent = true
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.termguicolors = true

vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
