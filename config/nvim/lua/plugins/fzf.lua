local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = LazyVim.config.get_kind_filter(ctx.bufnr) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

local keys = {
    {
      "<bslash>ss",
      function()
        require("fzf-lua").lsp_document_symbols({
          regex_filter = symbols_filter,
        })
      end,
      desc = "Goto Symbol",
    },
  {
    "<C-a>",
    "<cmd>FzfLua lsp_document_symbols query=Function<CR>",
    desc = "FZF Symbols",
  },
  {
    "<C-x><C-a>",
    "<cmd>FzfLua lsp_workspace_symbols<CR>",
    desc = "FZF Workspace Symbols",
  },
  {
    "<C-e>",
    "<cmd>FzfLua lsp_document_diagnostics<CR>",
    desc = "FZF Diagnostics",
  },
  {
    "<C-x><C-e>",
    "<cmd>FzfLua lsp_workspace_diagnostics<CR>",
    desc = "FZF Workspace Diagnostics",
  },
  {
    "<bslash><bslash>",
    "<cmd>FzfLua<cr>",
    desc = "FZF",
  },
  {
    "<bslash>f",
    LazyVim.pick("files", { root = false }),
    desc = "FZF Files - cwd",
  },
  {
    "<bslash>F",
    LazyVim.pick("files"),
    desc = "FZF Files - root",
  },
  {
    "<bslash>C",
    "<cmd>FzfLua command_history<cr>",
    desc = "FZF Command History",
  },
  {
    "<bslash>C",
    "<cmd>FzfLua command_history<cr>",
    desc = "FZF Command History",
  },
  {
    "<bslash>i",
    "<cmd>FzfLua git_files<cr>",
    desc = "FZF Git Files",
  },
  {
    "<bslash>I",
    LazyVim.pick.config_files(),
    desc = "FZF Files - config",
  },
  {
    "<bslash>b",
    "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
    desc = "FZF Buffers",
  },
  {
    "<bslash>g",
    "<cmd>FzfLua git_status<CR>",
    desc = "FZF Git Status",
  },
  {
    "<bslash>G",
    "<cmd>FzfLua git_commits<CR>",
    desc = "FZF Git Commits",
  },
  {
    "<bslash>r",
    LazyVim.pick("live_grep", { root = false }),
    desc = "FZF Live RG - cwd",
  },
  {
    "<bslash>R",
    LazyVim.pick("live_grep"),
    desc = "FZF Live RG - root",
  },
  {
    "<bslash>h",
    "<cmd>FzfLua help_tags<cr>",
    desc = "FZF Helptags",
  },
  {
    "<bslash>H",
    "<cmd>FzfLua highlights<cr>",
    desc = "FZF Highlights",
  },
  {
    "<bslash>k",
    "<cmd>FzfLua keymaps<cr>",
    desc = "FZF Keymaps",
  },
  {
    "<bslash>j",
    "<cmd>FzfLua jumps<cr>",
    desc = "FZF Jumps",
  },
  {
    "<bslash>m",
    LazyVim.pick("colorschemes"),
    desc = "FZF Colorschemes",
  },
  {
    "gr",
    "<cmd>FzfLua lsp_references<cr>",
    desc = "FZF LSP References",
  },
  {
    "gd",
    "<cmd>FzfLua lsp_declarations<cr>",
    desc = "FZF LSP Declarations",
  },
  {
    "gD",
    "<cmd>FzfLua lsp_definitions<cr>",
    desc = "FZF LSP Definitions",
  },
  {
    "gI",
    "<cmd>FzfLua lsp_incoming_calls<cr>",
    desc = "FZF LSP Incoming Calls",
  },
  {
    "gO",
    "<cmd>FzfLua lsp_outgoing_calls<cr>",
    desc = "FZF LSP Outgoing Calls",
  },
}

local config = {
  defaults = {
    keymap = {
      fzf = {
        ["ctrl-u"] = "preview-page-up",
        ["ctrl-d"] = "preview-page-down",
      },
    },
  },
  keymap = {
    fzf = {
      ["ctrl-u"] = "preview-page-up",
      ["ctrl-d"] = "preview-page-down",
      -- config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      -- config.defaults.keymap.fzf["ctrl-p"] = "half-page-up"
      -- config.defaults.keymap.fzf["ctrl-n"] = "half-page-down"
      -- config.defaults.keymap.fzf["ctrl-x"] = "jump"
      -- config.defaults.keymap.fzf["ctrl-u"] = "preview-page-down"
      -- config.defaults.keymap.fzf["ctrl-d"] = "preview-page-up"
    },
    builtin = {
      -- ["<C-u>"] = "preview-page-up",
      -- ["<C-d>"] = "preview-page-down",
      --["<C-n>"] = "toggle-preview-cw",
      --["<C-p>"] = "toggle-preview-ccw",
      --["<C-Slash>"] = "toggle-fullscreen",
      --["<C-BSlash>"] = "toggle-preview-wrap",
    },
  },
  preview = {
    default = "builtin", -- override the default previewer?
    -- default uses the 'builtin' previewer
    border = "rounded", -- preview border: accepts both `nvim_open_win`
    -- and fzf values (e.g. "border-top", "none")
    -- native fzf previewers (bat/cat/git/etc)
    -- can also be set to `fun(winopts, metadata)`
    wrap = false, -- preview line wrap (fzf's 'wrap|nowrap')
    hidden = false, -- start preview hidden
    vertical = "down:45%", -- up|down:size
    horizontal = "right:60%", -- right|left:size
    layout = "flex", -- horizontal|vertical|flex
    flip_columns = 100, -- #cols to switch to horizontal on flex
    -- Only used with the builtin previewer:
    title = true, -- preview border title (file/buf)?
    title_pos = "center", -- left|center|right, title alignment
    scrollbar = "float", -- `false` or string:'float|border'
    -- float:  in-window floating border
    -- border: in-border "block" marker
    scrolloff = -1, -- float scrollbar offset from right
    -- applies only when scrollbar = 'float'
    delay = 20, -- delay(ms) displaying the preview
    -- prevents lag on fast scrolling
    -- winopts = { -- builtin previewer window options
    --   number = true,
    --   relativenumber = false,
    --   cursorline = true,
    --   cursorlineopt = "both",
    --   cursorcolumn = false,
    --   signcolumn = "no",
    --   list = false,
    --   foldenable = false,
    --   foldmethod = "manual",
    -- },
  },
  -- lsp = {
  --   symbols = {
  --     symbol_hl = function(s)
  --       return "TroubleIcon" .. s
  --     end,
  --     symbol_fmt = function(s)
  --       return s:lower() .. "\t"
  --     end,
  --     child_prefix = false,
  --   },
  --   code_actions = {
  --     previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
  --   },
  -- },
}

return {
  {
    "ibhagwan/fzf-lua",
    config = function()
      require("fzf-lua").setup(config)
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
