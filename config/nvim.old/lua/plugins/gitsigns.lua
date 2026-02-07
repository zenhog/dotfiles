return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      integrations = {
        telescope = nil,
        diffview = true,
        fzf_lua = true,
      },
    }
  end,
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    -- test
    config = function()
      require('neogit').setup {
      }
    end,
  },
}
