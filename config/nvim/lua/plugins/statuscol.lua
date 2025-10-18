return {
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      -- local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- configuration goes here, for example:
        setopt = true,
        relculright = true,
        segments = {
          -- {
          --   sign = {
          --     namespace = { "diagnostic/signs" },
          --     maxwidth = 2,
          --     auto = true,
          --   },
          --   click = "v:lua.ScSa"
          -- },
          -- {
          --   sign = {
          --     name    = { "GitSigns.*" },
          --     maxwidth = 1,
          --     colwidth = 1,
          --     auto = false,
          --   },
          --   click = "v:lua.ScSa"
          -- },
          { text = { "%s" }, click = "v:lua.ScSa" }, -- sign column
          { text = { "%l" }, click = "v:lua.ScLa" }, -- line number
          {
            text = { " ┃" },
            condition = { true },
            click = "v:lua.ScLa",
          },
        },
      })
    end,
  },
}
