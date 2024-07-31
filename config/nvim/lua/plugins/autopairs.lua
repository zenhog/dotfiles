return {
  {
    'altermo/ultimate-autopair.nvim',
    event = 'VeryLazy',
    --lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      {
        'windwp/nvim-autopairs',
        --config = function()
        --  require('nvim-autopairs').setup {
        --    check_ts = true,
        --    map_c_h = true,
        --    map_c_w = true,
        --  }
        --end
      },
    },
    config = function()
    end,
  },
  --{
  --  'abecodes/tabout.nvim',
  --  dependencies = {
  --    'windwp/nvim-autopairs',
  --  },
  --  config = function()
  --    require('tabout').setup {
  --      tabkey = '<C-y>',
  --      backwards_tabkey = '<C-x><C-y>',
  --    }
  --  end,
  --},
}
