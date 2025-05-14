return {
  {
    "folke/persistence.nvim",
    keys = function()
      return {
        {
          "<space><space>",
          function()
            require("persistence").load()
          end,
          desc = "Restore Session",
        },
        {
          "<space>q",
          function()
            require("persistence").stop()
          end,
          desc = "Don't Save Current Session",
        },
        {
          "<leader>s",
          function()
            require("persistence").select()
          end,
          desc = "Select Session",
        },
      }
    end,
  },
}
