return {
  {
    "folke/persistence.nvim",
    enabled = false,
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
  {
    "jedrzejboczar/possession.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    keys = function()
      return {
        {
          "<space><space>",
          "<cmd>PossessionLoadCwd<cr>",
          desc = "SESSION Restore",
        },
        {
          "<space><bs>",
          "<cmd>PossessionClose<cr>",
          desc = "SESSION Close",
        },
        {
          "<space>s",
          "<cmd>PossessionSaveCwd<cr>",
          desc = "SESSION Save Cwd",
        },
        {
          "<space>S",
          "<cmd>PossessionSave<cr>",
          desc = "SESSION Save",
        },
        {
          "<bslash>s",
          "<cmd>PossessionPick<cr>",
          desc = "FZF Session",
        },
      }
    end,
    config = function()
      require("possession").setup({
        silent = false,
        load_silent = true,
        debug = false,
        logfile = false,
        prompt_no_cr = false,
        autosave = {
          current = false, -- or fun(name): boolean
          cwd = false, -- or fun(): boolean
          tmp = false, -- or fun(): boolean
          tmp_name = "tmp", -- or fun(): string
          on_load = true,
          on_quit = true,
        },
        autoload = false, -- or 'last' or 'auto_cwd' or 'last_cwd' or fun(): string
        commands = {
          save = "PossessionSave",
          load = "PossessionLoad",
          save_cwd = "PossessionSaveCwd",
          load_cwd = "PossessionLoadCwd",
          rename = "PossessionRename",
          close = "PossessionClose",
          delete = "PossessionDelete",
          show = "PossessionShow",
          pick = "PossessionPick",
          list = "PossessionList",
          list_cwd = "PossessionListCwd",
          migrate = "PossessionMigrate",
        },
        hooks = {
          before_save = function(name)
            return {}
          end,
          after_save = function(name, user_data, aborted) end,
          before_load = function(name, user_data)
            return user_data
          end,
          after_load = function(name, user_data) end,
        },
        plugins = {
          close_windows = {
            hooks = { "before_save", "before_load" },
            preserve_layout = true, -- or fun(win): boolean
            match = {
              floating = true,
              buftype = {},
              filetype = {},
              custom = false, -- or fun(win): boolean
            },
          },
          delete_hidden_buffers = {
            hooks = {
              "before_load",
              vim.o.sessionoptions:match("buffer") and "before_save",
            },
            force = false, -- or fun(buf): boolean
          },
          nvim_tree = true,
          neo_tree = true,
          symbols_outline = true,
          outline = true,
          tabby = true,
          dap = true,
          dapui = true,
          neotest = true,
          kulala = true,
          delete_buffers = false,
          stop_lsp_clients = false,
        },
        telescope = {
          previewer = {
            enabled = true,
            previewer = "pretty", -- or 'raw' or fun(opts): Previewer
            wrap_lines = true,
            include_empty_plugin_data = false,
            cwd_colors = {
              cwd = "Comment",
              tab_cwd = { "#cc241d", "#b16286", "#d79921", "#689d6a", "#d65d0e", "#458588" },
            },
          },
          list = {
            default_action = "load",
            mappings = {
              save = { n = "<c-x>", i = "<c-x>" },
              load = { n = "<c-v>", i = "<c-v>" },
              delete = { n = "<c-t>", i = "<c-t>" },
              rename = { n = "<c-r>", i = "<c-r>" },
              grep = { n = "<c-g>", i = "<c-g>" },
              find = { n = "<c-f>", i = "<c-f>" },
            },
          },
        },
      })
    end,
  },
}
