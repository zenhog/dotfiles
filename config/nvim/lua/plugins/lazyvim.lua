return {
  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        autocmds = true, -- lazyvim.config.autocmds
        keymaps = false, -- lazyvim.config.keymaps
        options = true, -- lazyvim.config.options
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Disable LSP keymaps
      vim.g.lsp_auto_enable = false
    end,
  },
}
