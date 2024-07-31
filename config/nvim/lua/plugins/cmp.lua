return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-buffer',
    --'saadparwaiz1/cmp_luasnip',
    --{
    --  'L3MON4D3/LuaSnip',
    --  version = '2.*',
    --  build = 'make install_jsregexp',
    --  config = function()

    --  end,
    --},
    {
      'dcampos/nvim-snippy',
      dependencies = {
        'honza/vim-snippets',
      },
      config = function()
        require('snippy').setup {
          mappings = {
            s = {
              ['<C-k>'] = 'previous',
              ['<C-j>'] = 'next',
            },
          },
        }
      end
    },
    'dcampos/cmp-snippy',
  },
  event = {
    "InsertEnter",
   -- "CmdlineEnter",
  },
  config = function()
    local cmp = require('cmp')
    local snippy = require('snippy')

    local feedkey = function(key, mode)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end

    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

    local mapmodes = { 'i', 'c' }

    local mapkeys = {
      ['<C-e>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), mapmodes),
      ['<C-q>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.abort()
        else
          cmp.complete()
        end
      end, mapmodes),
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), mapmodes),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), mapmodes),
      ['<C-j>'] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
          end
        end,
        i = function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif snippy.can_jump(1) then
            --snippy.next()
            feedkey('<Plug>(snippy-next)', '')
          else
            --vim.api.nvim_feedkeys(t('<Down>'), 'i', true)
            feedkey('<Down>', '')
          end
        end
      }),
      ['<C-k>'] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
          end
        end,
        i = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          elseif snippy.can_jump(-1) then
            feedkey('<Plug>(snippy-previous)', '')
          else
            feedkey('<Up>', '')
            --fallback()
          end
        end
      }),
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          require('snippy').expand_snippet(args.body)
        end
      },
      formatting = {
        format = require('lspkind').cmp_format({
          mode = 'symbol',
          maxwidth = 50,
          ellipsis_char = '...',
          before = function(_, vim_item)
            return vim_item
          end
        }),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = mapkeys,
      sources = {
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'snippy' },
      }
    }

    cmp.setup.cmdline(':', {
      mapping = mapkeys,
      sources = cmp.config.sources(
        {
          { name = 'path' },
        },
        {
          { name = 'cmdline' },
        }
      )
    })

    cmp.setup.cmdline({ '/', '?' }, {
      sources = {
        { name = 'buffer' },
      },
    })
  end,
}
