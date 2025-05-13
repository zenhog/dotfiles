return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    config = function()
      require("mason-tool-installer").setup({

        -- a list of all tools you want to ensure are installed upon
        -- start; they should be the names Mason uses for each tool
        ensure_installed = {
          -- LSP Servers
          --'cpptools',
          -- "deno", "json-lsp",
          -- "marksman",
          -- "eslint-lsp",
          -- "dockerfile-language-server",
          -- "docker-compose-language-service",
          -- "ansible-language-server",
          -- "helm-ls",
          -- "ruby-lsp",
          -- "tailwindcss-language-server",
          -- "terraform-ls",
          -- "tflint",
          -- "yaml-language-server",
          -- "taplo",
          -- "ruff",
          --'asm-lsp',                -- NASM/GAS/GO Assembly
          "clangd", -- C/C++/Rust
          "pyright", -- Python
          --'solargraph',             -- Ruby
          "lua-language-server", -- Lua
          "bash-language-server", -- Bash
          "terraform-ls", -- Terraform
          --'vim-language-server',    -- VimLang
          --'html-lsp',               -- HTML
          --'css-lsp',                -- CSS
          --'lemminx',                -- XML
          --'json-lsp',               -- Json
          --'yaml-language-server',   -- Yaml
          --'ltex-ls',                -- LanguageTool
          -- DAP Servers
          "codelldb", -- C/C++/Rust
          "debugpy", -- Python
          "bash-debug-adapter", -- Bash
          --'firefox-debug-adapter',  -- Firefox WebApp/Extension
          -- Linters
          --'stylua',
          --'luacheck',
          --'shellcheck',
          -- Formatters
          --'shfmt',
        },

        -- if set to true this will check each tool for updates. If updates
        -- are available the tool will be updated. This setting does not
        -- affect :MasonToolsUpdate or :MasonToolsInstall.
        -- Default: false
        auto_update = false,

        -- automatically install / update on startup. If set to false nothing
        -- will happen on startup. You can use :MasonToolsInstall or
        -- :MasonToolsUpdate to install tools and check for updates.
        -- Default: true
        run_on_start = false,

        -- set a delay (in ms) before the installation starts. This is only
        -- effective if run_on_start is set to true.
        -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
        -- Default: 0
        start_delay = 5000, -- 3 second delay

        -- Only attempt to install if 'debounce_hours' number of hours has
        -- elapsed since the last time Neovim was started. This stores a
        -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
        -- This is only relevant when you are using 'run_on_start'. It has no
        -- effect when running manually via ':MasonToolsInstall' etc....
        -- Default: nil
        debounce_hours = 5, -- at least 5 hours between attempts to install/update
      })
    end,
  },
}
