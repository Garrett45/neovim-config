-- This file is for normal vim settings 
vim.opt.number = true -- add in line numbers
vim.opt.relativenumber = true -- make numbers relative to make jumps easier

vim.opt.splitbelow = true -- horizonatal splits will split below rather than above
vim.opt.splitright = true -- vertical splits will split to the right rather than to the left

vim.opt.wrap = false -- no text wrapping

vim.opt.expandtab = true -- Tabs become spaces
vim.opt.tabstop = 4 -- Only 4 spaces inserted per tab
vim.opt.shiftwidth = 0 -- indent and dedent uses this variable. setting it to 0 has it fallback to tabstop

vim.opt.clipboard = "unnamedplus" -- use system keyboard for putting

vim.opt.scrolloff = 999 -- keep cursor in the middle of the screen

vim.opt.virtualedit = "block" -- now visual block can target any part of the window

vim.opt.inccommand = "split" -- comamnds that change things will show changes in a split rather than in the same split
vim.opt.ignorecase = true -- make commands case insensitive
vim.opt.termguicolors = true -- give us the full color range

vim.opt.foldlevel = 99 -- all folds should be open by default
vim.o.incsearch = true -- turn on search to work like old incsearch plugin
