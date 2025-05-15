local actions = require("fzf-lua.actions")

local custom_actions = {
  references = function(selected, opts)
    if not selected or #selected == 0 then
      return
    end
    local symbol = selected[1]

    print(vim.inspect(symbol))

    -- Ensure we have proper LSP symbol data
    if not symbol.selectionRange or not symbol.selectionRange.start then
      vim.notify("Invalid symbol data", vim.log.levels.ERROR)
      return
    end

    -- Get the current buffer and position
    local bufnr = vim.api.nvim_get_current_buf()
    local pos = {
      line = symbol.selectionRange.start.line,
      character = symbol.selectionRange.start.character,
    }

    -- Trigger LSP references
    require("fzf-lua").lsp_references({
      jump_to_single_result = true,
      no_auto_resize = true,
      winopts = {
        height = 0.4,
        width = 0.6,
        row = 0.4,
        col = 0.4,
      },
    }, { bufnr = bufnr, pos = pos })
  end,
}

local keys = {
  {
    "<C-a>",
    "<cmd>FzfLua lsp_document_symbols<CR>",
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
}

local lsp_config = {
  lsp = {
    actions = {
      ["ctrl-o"] = custom_actions.references,
    },
    symbols = {
      symbol_hl = function(s)
        return "TroubleIcon" .. s
      end,
      symbol_fmt = function(s)
        return s:lower() .. "\t"
      end,
      child_prefix = false,
    },
    code_actions = {
      previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
    },
  },
}

local config = {
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
  lsp_config,
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
