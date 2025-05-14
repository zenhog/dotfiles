local theme = {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    require("onedarkpro").setup({
      options = {
        cursorline = true,
        terminal_colors = true,
      },
    })
    vim.cmd("colorscheme onedark_vivid")
  end,
}

theme = {}

return {
  theme,
}
