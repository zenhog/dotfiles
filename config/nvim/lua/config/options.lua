-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.theme_dark = "catppuccin-mocha"
vim.g.theme_dark = "tokyonight-night"
vim.g.theme_light = "gruvbox"

local theme = vim.fn.systemlist("cat $HOME/.colorscheme")[1]

if theme == "" or not theme then
  theme = "dark"
end

-- this needs to be put in a utils.lua and be required from plugin config
-- vim.g.theme_current = theme or "dark"
-- vim.cmd(string.format("colorscheme %s", vim.g["theme_" .. vim.g.theme_current]))
-- vim.opt.bg = theme

vim.g.mapleader = ""
vim.g.maplocalleader = " "

vim.g.mapleader = false
vim.g.maplocalleader = false

vim.g.lazyvim_picker = "fzf"
vim.g.lazyvim_cmp = "blink.cmp"
vim.g.autoformat = true
vim.g.trouble_lualine = true

vim.g.snacks_animate = false

local opt = vim.opt

-- opt.laststatus = 3
opt.timeout = false
opt.ttimeout = false
opt.ttimeoutlen = 0

opt.confirm = false

opt.completeopt = "menuone,noinsert,noselect"

opt.listchars = "tab:▶ ,trail:␣"

opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  -- "winsize",
  "winpos",
  -- "options",
  -- "blank",
  -- "localoptions",
  -- "help",
  -- "globals",
  "skiprtp",
  -- "folds",
}

opt.formatoptions:remove({ "c", "r", "o" })
