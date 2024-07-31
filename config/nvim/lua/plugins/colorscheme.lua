return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
    end,
    dependencies = {
      {
        "Tsuzat/NeoSolarized.nvim",
        lazy = false,
        priority = 1000,
        config = function()
          require('NeoSolarized').setup({
            style = 'light',
            transparent = false,
            enable_italics = true,
            terminal_colors = true,
          })

          local theme = vim.fn.systemlist('cat $HOME/.colorscheme')[1]

          if theme == '' or not theme then
            theme = 'dark'
          end

          vim.g.theme_current = theme

          vim.g.theme_dark = 'tokyonight-night'
          vim.g.theme_light = 'NeoSolarized'

          vim.cmd('colorscheme ' .. vim.g['theme_' .. vim.g.theme_current])
          vim.opt.bg = theme
        end,
      },
    },
}
