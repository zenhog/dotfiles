return {
  {
    "jedrzejboczar/possession.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    lazy = false,
    priority = 100,
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
          "<cmd>PossessionSaveCwd!<cr>",
          desc = "SESSION Save Cwd",
        },
        {
          "<space>S",
          function()
            local input = vim.fn.input("Session name: ")
            vim.cmd("PossessionSave! " .. input)
          end,
          desc = "SESSION Save",
        },
        {
          "<bslash><cr>",
          "<cmd>PossessionPick<cr>",
          desc = "FZF Session",
        },
      }
    end,
    config = function()
      require("possession").setup({
        silent = true,
        load_silent = true,
        debug = false,
        logfile = false,
        prompt_no_cr = false,
        session_dir = string.format("%s/storage/main/data/nvim/sessions", os.getenv("HOME")),
        use_git_branch = true,
        -- on_autoload_no_session = function()
        --   vim.notify("No existing session to load.")
        -- end,
        allowed_dirs = {
          "~/.dotfiles",
          "~/workspace",
        },
        autoload = "auto_cwd",
        autosave = {
          current = true, -- or fun(name): boolean
          cwd = false, -- or fun(): boolean
          tmp = false, -- or fun(): boolean
          tmp_name = "tmp", -- or fun(): string
          on_load = true,
          on_quit = true,
        },
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
          -- delete_hidden_buffers = {
          --   hooks = {
          --     "before_load",
          --     vim.o.sessionoptions:match("buffer") and "before_save",
          --   },
          --   force = false, -- or fun(buf): boolean
          -- },
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
            enabled = false,
          },
        },
      })
    end,
  },
}
