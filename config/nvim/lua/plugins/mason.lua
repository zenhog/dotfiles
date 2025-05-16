return {
  {
    "mason-org/mason.nvim",
    keys = function()
      return {
        {
          "<space>m",
          "<cmd>Mason<cr>",
          desc = "Mason",
        },
      }
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
  },
}
