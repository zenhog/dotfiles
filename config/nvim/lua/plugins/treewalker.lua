return {
  "aaronik/treewalker.nvim",
  lazy = false,

  opts = {
    highlight = true,
    highlight_duration = 250,
    highlight_group = "CursorLine",
  },
  keys = {
    {
      "<C-k>",
      mode = { "n", "v" },
      "<cmd>Treewalker Up<cr>",
      desc = "Treewalker Up",
    },
    {
      "<C-j>",
      mode = { "n", "v" },
      "<cmd>Treewalker Down<cr>",
      desc = "Treewalker Down",
    },
    {
      "<C-h>",
      mode = { "n", "v" },
      "<cmd>Treewalker Left<cr>",
      desc = "Treewalker Left",
    },
    {
      "<C-l>",
      mode = { "n", "v" },
      "<cmd>Treewalker Right<cr>",
      desc = "Treewalker Right",
    },
    {
      "<C-x><C-k>",
      mode = { "n", "v" },
      "<cmd>Treewalker SwapUp<cr>",
      desc = "Treewalker Swap Up",
    },
    {
      "<C-x><C-j>",
      mode = { "n", "v" },
      "<cmd>Treewalker SwapDown<cr>",
      desc = "Treewalker Swap Down",
    },
    {
      "<C-x><C-h>",
      mode = { "n", "v" },
      "<cmd>Treewalker SwapLeft<cr>",
      desc = "Treewalker Swap Left",
    },
    {
      "<C-x><C-l>",
      mode = { "n", "v" },
      "<cmd>Treewalker SwapRight<cr>",
      desc = "Treewalker Swap Right",
    },
  },
}
