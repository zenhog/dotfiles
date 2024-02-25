local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

vim.loader.enable()

require('lazy').setup {
  lockfile = vim.fn.stdpath('data') .. '/lazy-lock.json',
  spec = {
    {
      import = 'plugins',
    },
  },
  checker ={
    enabled = true,
  },
}

require('vimopt')
require('autocmd')
