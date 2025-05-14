local keys = {
  { "<C-a>", "<cmd>FzfLua lsp_document_symbols<CR>", desc = "FZF Symbols" },
  { "<C-x><C-a>", "<cmd>FzfLua lsp_workspace_symbols<CR>", desc = "FZF Workspace Symbols" },

  { "<C-e>", "<cmd>FzfLua lsp_document_diagnostics<CR>", desc = "FZF Diagnostics" },
  { "<C-x><C-e>", "<cmd>FzfLua lsp_workspace_diagnostics<CR>", desc = "FZF Workspace Diagnostics" },

  { "<bslash>f", LazyVim.pick("files", { root = false }), desc = "FZF Files" },
  { "<bslash>F", LazyVim.pick("files"), desc = "FZF Root Files" },

  { "<bslash>g", "<cmd>FzfLua git_status<CR>", desc = "FZF Status" },
  { "<bslash>G", "<cmd>FzfLua git_commits<CR>", desc = "FZF Commits" },

  { "<bslash><bslash>", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
  { "<bslash><slash>", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },

  { "<bslash>h", "<cmd>FzfLua help_tags<cr>", desc = "FZF Helptags" },
  { "<bslash>H", "<cmd>FzfLua highlights<cr>", desc = "FZF Highlights" },

  { "<bslash>k", "<cmd>FzfLua keymaps<cr>", desc = "FZF Keymaps" },
  { "<bslash>j", "<cmd>FzfLua jumps<cr>", desc = "FZF Jumps" },
  { "<bslash>c", LazyVim.pick("colorschemes"), desc = "FZF Colorschemes" },
}

local keymap = {
  keymap = {
    fzf = {
      ["ctrl-u"] = "preview-page-up",
      ["ctrl-d"] = "preview-page-down",
    },
    builtin = {
      ["<C-u>"] = "preview-page-up",
      ["<C-d>"] = "preview-page-down",
      ["<C-n>"] = "toggle-preview-cw",
      ["<C-p>"] = "toggle-preview-ccw",
      ["<C-Slash>"] = "toggle-fullscreen",
      ["<C-BSlash>"] = "toggle-preview-wrap",
    },
  },
}

return {
  {
    "ibhagwan/fzf-lua",
    -- config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    -- config.defaults.keymap.fzf["ctrl-p"] = "half-page-up"
    -- config.defaults.keymap.fzf["ctrl-n"] = "half-page-down"
    -- config.defaults.keymap.fzf["ctrl-x"] = "jump"
    -- config.defaults.keymap.fzf["ctrl-u"] = "preview-page-down"
    -- config.defaults.keymap.fzf["ctrl-d"] = "preview-page-up"
    init = function()
      require("fzf-lua").setup(keymap)
    end,
    keys = function()
      return keys
    end,
    -- { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
    -- { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
    -- {
    --   "<bslash>,",
    --   "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
    --   desc = "Switch Buffer",
    -- },
    -- { "<bslash>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    -- { "<bslash>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    -- { "<bslash><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    -- -- find
    -- { "<bslash>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    -- { "<bslash>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
    -- { "<bslash>g", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
    -- { "<bslash>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
    -- { "<bslash>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    -- -- git
    -- -- search
    -- { '<bslash>r"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
    -- { "<bslash>a", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
    -- { "<bslash>b", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
    -- { "<bslash>H", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    -- { "<bslash>C", "<cmd>FzfLua commands<cr>", desc = "Commands" },
    -- { "<bslash>g", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    -- { "<bslash>G", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    -- { "<bslash>l", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
    -- { "<bslash>m", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
    -- { "<bslash>M", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
    -- { "<bslash>R", "<cmd>FzfLua resume<cr>", desc = "Resume" },
    -- { "<bslash>q", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
    -- { "<bslash>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
    -- { "<bslash>sW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
    -- { "<bslash>sw", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
    -- { "<bslash>sW", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
  },
}
