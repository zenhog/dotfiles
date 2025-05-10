return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
        },
        git_status = {
          symbols = {
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "➜",
            untracked = "?",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        position = "left",
        width = 40,
        mappings = {
          ["<space>"] = "toggle_node",
          ["<2-LeftMouse>"] = "open",
        },
      },
    })
  end,
  keys = {
    {
      "<C-t>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree action=focus source=filesystem<cr>",
      desc = "Neotree filesystem focus",
    },
    {
      "<C-x><C-t>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree action=close source=filesystem<cr>",
      desc = "Neotree filesystem close",
    },
    {
      "<C-y>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree action=focus source=buffers<cr>",
      desc = "Neotree buffers focus",
    },
    {
      "<C-x><C-y>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree action=show source=buffers<cr>",
      desc = "Neotree buffers close",
    },
    {
      "<C-\\>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree action=focus source=document_symbols position=right<cr>",
      desc = "Neotree buffers focus",
    },
    {
      "<C-x><C-\\>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree action=close source=document_symbols position=right<cr>",
      desc = "Neotree buffers close",
    },
    {
      "<C-g>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree action=focus source=git_status<cr>",
      desc = "Neotree gitstatus focus",
    },
    {
      "<C-x><C-g>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree action=close source=git_status<cr>",
      desc = "Neotree gitstatus close",
    },
  },
}
