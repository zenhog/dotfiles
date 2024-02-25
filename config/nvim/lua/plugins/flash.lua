return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  config = function()
    require('flash').setup({
      search = {
        mode = "search",
      },
    })
    vim.o.ignorecase = true
    vim.o.smartcase = true
  end,
  keys = {
    {
      "",
      mode = { "i", "n", "x", "o" },
      function()
        -- default options: exact mode, multi window, all directions, with a backdrop
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "",
      mode = { "i", "n", "x", "o" },
      function()
        -- default options: exact mode, multi window, all directions, with a backdrop
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "?",
      mode = { "n", "o", "x" },
      function()
        -- show labeled treesitter nodes around the cursor
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        -- jump to a remote location to execute the operator
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "n", "o", "x" },
      function()
        -- show labeled treesitter nodes around the search matches
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    }
  },
}
