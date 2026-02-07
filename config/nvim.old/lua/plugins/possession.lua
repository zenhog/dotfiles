return {
  {
    'olimorris/persisted.nvim',
    config = function()
      require('persisted').setup {
        autoload = true,
        use_git_branch = true,
      }
      require('telescope').load_extension('persisted')
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    keys = {
      {
        "<C-x><C-q>",
        mode = { "n" },
        "<Cmd>wa<CR><Cmd>SessionSave<CR><Cmd>qa<CR>",
        desc = "Save current session",
      },
      {
        "<C-x><CR>",
        mode = { "n" },
        "<Cmd>SessionToggle<CR>",
        desc = "Toggle session",
      },
      {
        "<C-x><C-l>",
        mode = { "n" },
        "<Cmd>Telescope persisted<CR>",
        desc = "List sessions in Telescope",
      },
    },
    lazy = false,
    priority = 100,
  },
}
