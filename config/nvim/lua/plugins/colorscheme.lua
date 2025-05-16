return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  -- {
  --   "maxmx03/solarized.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   ---@type solarized.config
  --   opts = {},
  --   config = function(_, opts)
  --     vim.o.termguicolors = true
  --     vim.o.background = "light"
  --     require("solarized").setup(opts)
  --     vim.cmd.colorscheme("solarized")
  --   end,
  -- },
}
