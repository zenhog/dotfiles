return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "gK", false }
      keys[#keys + 1] = { "<C-k>", false, mode = "i" }
      keys[#keys + 1] = { "<A-n>", false }
      keys[#keys + 1] = { "<A-p>", false }
      keys[#keys + 1] = { "gr", false }
      keys[#keys + 1] = { "gd", false }
      keys[#keys + 1] = { "gD", false }
      keys[#keys + 1] = { "gI", false }
      keys[#keys + 1] = { "gy", false }
      keys[#keys + 1] = { "<leader>ca", false, mode = { "n", "v" } }
      keys[#keys + 1] = { "<leader>cc", false, mode = { "n", "v" } }
      keys[#keys + 1] = { "<leader>cC", false }
      keys[#keys + 1] = { "<leader>cR", false }
      keys[#keys + 1] = { "<leader>cr", false }
      keys[#keys + 1] = { "<leader>cA", false }
      keys[#keys + 1] = { "<leader>cl", false }
      keys[#keys + 1] = { "]]", false }
      keys[#keys + 1] = { "[[", false }
    end,
  },
}
