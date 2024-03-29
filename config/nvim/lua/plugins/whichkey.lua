return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    keys = {
      {
        "<C-j>",
        mode = { "i" },
        "<Down>",
        desc = "Line Down",
      },
      {
        "<C-k>",
        mode = { "i" },
        "<Up>",
        desc = "Line Up",
      },
      {
        "<C-a>",
        mode = { "i" },
        "<Home>",
        desc = "Goto First Char in Line",
      },
      {
        "<C-e>",
        mode = { "i" },
        "<End>",
        desc = "Goto Last Char in Line",
      },
      {
        "<C-x><C-a>",
        mode = { "i" },
        "<C-d>",
        desc = "Indent Left",
      },
      {
        "<C-x><C-e>",
        mode = { "i" },
        "<C-t>",
        desc = "Indent Right",
      },
      {
        "<C-u>",
        mode = { "i" },
        "<HalfPageUp>",
        desc = "HalfPageUp",
      },
      {
        "<C-x><C-w>",
        mode = { "i", "c" },
        "<C-o>dB",
        desc = "Backward Kill Word",
      },
      {
        "<C-f>",
        mode = { "i", "c" },
        "<C-o>dw",
        desc = "Forward Kill word",
      },
      {
        "<C-x><C-f>",
        mode = { "i", "c" },
        "<C-o>dW",
        desc = "Forward Kill Word",
      },
      {
        "<C-b>",
        mode = { "i", "c" },
        "<S-Right>",
        desc = "Forward word",
      },
      {
        "<C-x><C-b>",
        mode = { "i", "c" },
        "<C-o>W",
        desc = "Forward Word",
      },
      {
        "<C-z>",
        mode = { "i", "c" },
        "<S-Left>",
        desc = "Backward word",
      },
      {
        "<C-x><C-z>",
        mode = { "i", "c" },
        "<C-o>B",
        desc = "Backward Word",
      },
      {
        "<C-x><C-w>",
        mode = { "i", "c" },
        "<C-o>dB",
        desc = "Backward Kill Word",
      },
      {
        "<C-d>",
        mode = { "i" },
        "<HalfPageDown>",
        desc = "HalfPageDown",
      },
      {
        "<C-x><C-u>",
        mode = { "i" },
        "<PageUp>",
        desc = "PageUp",
      },
      {
        "<C-x><C-d>",
        mode = { "i" },
        "<PageDown>",
        desc = "PageDown",
      },
      {
        "<C-x><C-h>",
        mode = { "i" },
        "<Left>",
        desc = "Backward Char",
      },
      {
        "<C-x><C-l>",
        mode = { "i" },
        "<Right>",
        desc = "Forward Char",
      },
      {
        "<C-h>",
        mode = { "i" },
        "<Bs>",
        desc = "Backward Delete Char",
      },
      {
        "<C-l>",
        mode = { "i" },
        "<Del>",
        desc = "Backward Delete Char",
      },
      {
        "J",
        mode = { "n" },
        '<Cmd>m .+1<CR>==',
        desc = "Move Line Down",
      },
      {
        "K",
        mode = { "n" },
        '<Cmd>m .-2<CR>==',
        desc = "Move Line Up",
      },
      --{
      --  "J",
      --  mode = { "v" },
      --  "<Cmd>'>+1<CR>gv=gv",
      --  desc = "Move Line Down",
      --},
      --{
      --  "K",
      --  mode = { "v" },
      --  "<Cmd>'<-2<CR>gv=gv",
      --  desc = "Move Line Up",
      --},
      {
        '<C-j>',
        mode = { "n" },
        'J',
        desc = 'Join Down',
      },
      {
        "gd",
        mode = { "n", "x" },
        '"+d',
        desc = "Delete into Clipboard",
      },
      {
        "gy",
        mode = { "n", "x" },
        '"+y',
        desc = "Copy into Clipboard",
      },
      {
        "gP",
        mode = { "n" },
        'O<Esc>"+p',
        desc = "Paste Clipboard on Prev Line",
      },
      {
        "gp",
        mode = { "n" },
        'o<Esc>"+p',
        desc = "Paste Clipboard on Next Line",
      },
      {
        "<C-q>",
        mode = { "n" },
        'ZQ',
        desc = 'Quit without saving',
      },
      {
        "<C-s>",
        mode = { "n" },
        '<Cmd>w<CR>',
        desc = 'Save current window',
      },
      {
        "<C-x><C-d>",
        mode = { "n" },
        '<C-f>',
        desc = 'Page down',
      },
      {
        "<C-x><C-u>",
        mode = { "n" },
        '<C-b>',
        desc = 'Page up',
      },
      {
        "<C-p>",
        mode = { "n" },
        '<Cmd>tabprev<CR>',
        desc = 'Prev Tab',
      },
      {
        "<C-n>",
        mode = { "n" },
        '<Cmd>tabnext<CR>',
        desc = 'Next Tab',
      },
      {
        "<C-t>",
        mode = { "n" },
        '<Cmd>tabnew<CR>',
        desc = 'New Tab',
      },
      {
        "<Bslash>1",
        mode = { "n" },
        function() vim.api.nvim_set_current_tabpage(1) end,
        desc = 'Goto Tab 1',
      },
      {
        "<Bslash>2",
        mode = { "n" },
        function() vim.api.nvim_set_current_tabpage(2) end,
        desc = 'Goto Tab 2',
      },
      {
        "<Bslash>3",
        mode = { "n" },
        function() vim.api.nvim_set_current_tabpage(3) end,
        desc = 'Goto Tab 3',
      },
      {
        "<Bslash>4",
        mode = { "n" },
        function() vim.api.nvim_set_current_tabpage(4) end,
        desc = 'Goto Tab 4',
      },
      {
        "<Bslash>5",
        mode = { "n" },
        function() vim.api.nvim_set_current_tabpage(5) end,
        desc = 'Goto Tab 5',
      },
      {
        "<Bslash>6",
        mode = { "n" },
        function() vim.api.nvim_set_current_tabpage(6) end,
        desc = 'Goto Tab 6',
      },
      {
        "<Bslash>7",
        mode = { "n" },
        function() vim.api.nvim_set_current_tabpage(7) end,
        desc = 'Goto Tab 7',
      },
      {
        "<Bslash>8",
        mode = { "n" },
        function() vim.api.nvim_set_current_tabpage(8) end,
        desc = 'Goto Tab 8',
      },
      {
        "<Bslash>9",
        mode = { "n" },
        function() vim.api.nvim_set_current_tabpage(9) end,
        desc = 'Goto Tab 9',
      },
    },
    config = true,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  }
}
