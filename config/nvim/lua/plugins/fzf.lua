return {
  'ibhagwan/fzf-lua',
  lazy = false,
  config = function()
    require('fzf-lua').setup {
      keymap = {
        builtin = {
          -- neovim `:tmap` mappings for the fzf win
          ["<C-BSlash>"] = "toggle-help",
          ["<C-f>"]    = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<C-o>"]    = "toggle-preview-wrap",
          ["<C-g>"]    = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<C-x>"]    = "toggle-preview-ccw",
          ["<C-d>"]    = "preview-page-down",
          ["<C-u>"]    = "preview-page-up",
        },
        --fzf = {
        --  -- fzf '--bind=' options
        --  ["ctrl-a"]      = "beginning-of-line",
        --  ["ctrl-e"]      = "end-of-line",
        --  -- Only valid with fzf previewers (bat/cat/git/etc)
        --  ["ctrl-o"]          = "toggle-preview-wrap",
        --  ["ctrl-g"]          = "toggle-preview",
        --  ["ctrl-u"]  = "preview-page-down",
        --  ["ctrl-d"]    = "preview-page-up",
        --},
      },
      winopts = {
        preview = {
          layout = {
            'flex',
          },
        },
      },
      fzf_opts = {
        -- options are sent as `<left>=<right>`
        -- set to `false` to remove a flag
        -- set to '' for a non-value flag
        -- for raw args use `fzf_args` instead
        ["--ansi"]        = "",
        ["--info"]        = "inline-right",
        ["--height"]      = "100%",
        ["--layout"]      = "reverse",
        ["--border"]      = "none",
      },
    }
    require('fzf-lua').register_ui_select()
  end,
  keys = {
    {
      '<C-Space>',
      mode = { "n" },
      function() require('fzf-lua').buffers() end,
      desc = 'FZF: Buffers',
    },
    {
      '<C-x><C-Space>',
      mode = { "n" },
      function() require('fzf-lua').tabs() end,
      desc = 'FZF: Tabs',
    },
    {
      '<C-e>',
      mode = { 'n' },
      function() require('fzf-lua').lsp_document_diagnostics() end,
      desc = 'FZF: LSP Document Diagnostics',
    },
    {
      '<C-x><C-e>',
      mode = { 'n' },
      function() require('fzf-lua').lsp_workspace_diagnostics() end,
      desc = 'FZF: LSP Workspace Diagnostics',
    },
    {
      '<C-a>',
      mode = { 'n' },
      function() require('fzf-lua').lsp_document_symbols() end,
      desc = 'FZF: LSP Document Symbols',
    },
    {
      '<C-x><C-a>',
      mode = { 'n' },
      function() require('fzf-lua').lsp_workspace_symbols() end,
      desc = 'FZF: LSP Workspace Symbols',
    },
    {
      "<Bslash>h",
      mode = { "n" },
      function() require('fzf-lua').help_tags() end,
      desc = 'FZF: Help Tags',
    },
    {
      "<Bslash>c",
      mode = { "n" },
      function() require('fzf-lua').commands() end,
      desc = 'FZF: Commands',
    },
    {
      "<Bslash>j",
      mode = { "n" },
      function() require('fzf-lua').jumplist() end,
      desc = 'FZF: Jumplist',
    },
    {
      "<Bslash>m",
      mode = { "n" },
      function() require('fzf-lua').keymaps() end,
      desc = 'FZF: Keymaps',
    },
    {
      '<BSlash>f',
      mode = { "n" },
      function() require('fzf-lua').files() end,
      desc = 'FZF: Files',
    },
    {
      '<BSlash>g',
      mode = { "n" },
      function() require('fzf-lua').live_grep() end,
      desc = 'FZF: Live Grep',
    },
    {
      '<BSlash>x',
      mode = { "n" },
      function() require('fzf-lua').lsp_references() end,
      desc = 'FZF: LSP References',
    },
    {
      '<BSlash>i',
      mode = { "n" },
      function() require('fzf-lua').incoming_calls() end,
      desc = 'FZF: LSP Incoming Calls',
    },
    {
      '<BSlash>o',
      mode = { "n" },
      function() require('fzf-lua').outgoing_calls() end,
      desc = 'FZF: LSP Outgoing Calls',
    },
  },
}
