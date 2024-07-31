return {
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      }
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      require('mason-tool-installer').setup {

        -- a list of all tools you want to ensure are installed upon
        -- start; they should be the names Mason uses for each tool
        ensure_installed = {
          -- LSP Servers
          'ansible-language-server',
          'cpptools',
          'deno',
          'asm-lsp',                -- NASM/GAS/GO Assembly
          'clangd',                 -- C/C++/Rust
          'pyright',                -- Python
          'solargraph',             -- Ruby
          'lua-language-server',    -- Lua
          'bash-language-server',   -- Bash
          'vim-language-server',    -- VimLang
          'html-lsp',               -- HTML
          'css-lsp',                -- CSS
          'lemminx',                -- XML
          'json-lsp',               -- Json
          'yaml-language-server',   -- Yaml
          'ltex-ls',                -- LanguageTool
          -- DAP Servers
          'codelldb',               -- C/C++/Rust
          'debugpy',                -- Python
          'bash-debug-adapter',     -- Bash
          'firefox-debug-adapter',  -- Firefox WebApp/Extension
          -- Linters
          'stylua',
          'luacheck',
          'shellcheck',
          -- Formatters
          'shfmt',
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
        run_on_start = true,

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
      }
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      {
        'folke/neodev.nvim',
        config = function()
          require('neodev').setup {
          }
        end
      },
      {
        'neovim/nvim-lspconfig',
      },
      'hrsh7th/nvim-cmp',
    },
    config = function()
      require('mason-lspconfig').setup {}
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            --on_attach = on_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          }
        end,
        clangd,
        lua_ls = require('lspconfig').lua_ls.setup {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        pyright,
        bashls,
        solargraph,
        html,
        cssls,
        ltex,
      }

      vim.diagnostic.config {
        virtual_text = false,
        signs = true,
        underline = false,
        update_in_insert = false,
        severity_sort = true,
      }

      --local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      --for type, icon in pairs(signs) do
      --  local hl = "DiagnosticSign" .. type
      --  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      --end
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          }
          vim.diagnostic.open_float(nil, opts)
        end
})
    end
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    config = function()
      require ('mason-nvim-dap').setup {
        automatic_installation = true,
        ensure_installed = {
        },
        handlers = {},
        --{
        --  function(config)
        --    -- all sources with no handler get passed here

        --    -- Keep original functionality
        --    require('mason-nvim-dap').default_setup(config)
        --  end,
        --},
      }
    end,
  },

--'jay-babu/mason-null-ls.nvim',
--'jose-elias-alvarez/null-ls.nvim',
}
