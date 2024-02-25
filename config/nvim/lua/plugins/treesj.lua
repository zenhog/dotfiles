return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
    })
  end,
  keys = {
    {
      "<C-g>",
      mode = { "n" },
      function() require('treesj').toggle() end,
      desc = "Toggle TreeSJ",
    },
    {
      "<C-g>",
      mode = { "i" },
      function() require('treesj').toggle() end,
      desc = "Toggle TreeSJ",
    },
  },
}
