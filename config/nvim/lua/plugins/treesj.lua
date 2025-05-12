return {
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
    keys = {
      {
        "<C-b>",
        mode = { "n", "i" },
        function()
          require("treesj").toggle()
        end,
        desc = "Toggle TreeSJ",
      },
    },
  },
}
