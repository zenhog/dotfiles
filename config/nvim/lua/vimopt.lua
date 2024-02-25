local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
vim.fn.setenv(NVIM_TUI_ENABLE_CURSOR_SHAPE, 0)

opt.mouse = '' -- Enable mouse support
opt.guicursor = { 'a:ver25' }

vim.cmd [[ autocmd OptionSet guicursor noautocmd set guicursor= ]]

opt.swapfile = false -- Don't use swapfile
opt.backup = false -- Don't use backups

opt.number = true -- Show line number
opt.numberwidth = 5
opt.relativenumber = false -- Relative line numbers

opt.textwidth = 80 -- Max text width before splitting
opt.colorcolumn = '+1' -- Line lenght marker at 80 columns
opt.linebreak = true -- Wrap on word boundary

opt.cursorline = true
opt.termguicolors = true -- Enable 24-bit RGB colors

opt.completeopt = 'menuone,noinsert,noselect'
opt.sessionoptions = 'buffers,curdir,folds,globals,tabpages,winpos,winsize'
opt.sessionoptions = 'curdir,folds,globals,tabpages,winpos,winsize'

opt.formatoptions:remove { "c", "r", "o" }

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
--opt.splitkeep = 'screen'
opt.ruler = false -- Replaced by Lualine
opt.showcmd = false -- Replaced by Lualine
opt.showmatch = false -- Highlight matching parenthesis
opt.laststatus = 3 -- Set global statusline

opt.foldenable = false -- Disable folding altogether
opt.foldmethod = 'marker' -- Enable folding (default 'foldmarker')

opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom

opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern

opt.hlsearch = false
opt.incsearch = true

opt.hidden = false
opt.joinspaces = false

opt.list = true
opt.listchars = 'tab:▶ ,trail:␣'
opt.fillchars = { vert = '│', fold = '.', eob = ' ' }

opt.scrolloff = 10
opt.winwidth = 10
opt.winminwidth = 10
opt.equalalways = false

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = false -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 700 -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append 'sI'

-- -- Disable builtin plugins
local disabled_built_ins = {
    '2html_plugin',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logipat',
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
    'matchit',
    'tar',
    'tarPlugin',
    'rrhelper',
    'spellfile_plugin',
    'vimball',
    'vimballPlugin',
    'zip',
    'zipPlugin',
    'tutor',
    'rplugin',
    'synmenu',
    'optwin',
    'compiler',
    'bugreport',
    'ftplugin',
}

--for _, plugin in pairs(disabled_built_ins) do
--    g["loaded_" .. plugin] = 1
--end
