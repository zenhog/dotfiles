-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

vim.g.lazyvim_picker = "fzf"
vim.g.lazyvim_cmp = "blink.cmp"
vim.g.autoformat = true
vim.g.trouble_lualine = true

vim.g.snacks_animate = true

local opt = vim.opt

opt.laststatus = 3
opt.timeout = false
opt.ttimeout = false
opt.ttimeoutlen = 0

opt.completeopt = "menuone,noinsert,noselect"
opt.sessionoptions = "curdir,buffers,folds,globals,tabpages,winpos,winsize," .. "options,localoptions,help,blank"

opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
  "skiprtp",
  "folds",
}

opt.formatoptions:remove({ "c", "r", "o" })
