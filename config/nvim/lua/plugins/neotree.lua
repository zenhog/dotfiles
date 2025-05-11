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
        "diagnostics",
      }, -- These are the defaults
      diagnostics = {
        auto_preview = { -- May also be set to `true` or `false`
          enabled = false, -- Whether to automatically enable preview mode
          preview_config = {}, -- Config table to pass to auto preview (for example `{ use_float = true }`)
          event = "neo_tree_buffer_enter", -- The event to enable auto preview upon (for example `"neo_tree_window_after_open"`)
        },
        bind_to_cwd = true,
        diag_sort_function = "severity", -- "severity" means diagnostic items are sorted by severity in addition to their positions.
        -- "position" means diagnostic items are sorted strictly by their positions.
        -- May also be a function.
        follow_current_file = { -- May also be set to `true` or `false`
          enabled = true, -- This will find and focus the file in the active buffer every time
          always_focus_file = false, -- Focus the followed file, even when focus is currently on a diagnostic item belonging to that file
          expand_followed = true, -- Ensure the node of the followed file is expanded
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          leave_files_open = false, -- `false` closes auto expanded files, such as with `:Neotree reveal`
        },
        group_dirs_and_files = true, -- when true, empty folders and files will be grouped together
        group_empty_dirs = true, -- when true, empty directories will be grouped together
        show_unloaded = true, -- show diagnostics from unloaded buffers
        refresh = {
          delay = 100, -- Time (in ms) to wait before updating diagnostics. Might resolve some issues with Neovim hanging.
          event = "vim_diagnostic_changed", -- Event to use for updating diagnostics (for example `"neo_tree_buffer_enter"`)
          -- Set to `false` or `"none"` to disable automatic refreshing
          max_items = 10000, -- The maximum number of diagnostic items to attempt processing
          -- Set to `false` for no maximum
        },
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
      "<cmd>Neotree filesystem<cr>",
      desc = "NeoTree: Filesystem",
    },
    {
      "<C-y>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree buffers<cr>",
      desc = "NeoTree: Buffers",
    },
    {
      "<C-g>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree git_status<cr>",
      desc = "NeoTree: Git",
    },
    {
      "<C-x><C-t>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree document_symbols<cr>",
      desc = "NeoTree: Symbols",
    },
    {
      "<C-x><C-y>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree diagnostics<cr>",
      desc = "NeoTree: Diagnostics",
    },
    {
      "<C-x><C-g>",
      mode = { "n", "v", "i", "c" },
      "<cmd>Neotree close<cr>",
      desc = "NeoTree: Close",
    },
  },
}
