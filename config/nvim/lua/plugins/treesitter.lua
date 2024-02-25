return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    dependencies = {
      {
        'RRethy/nvim-treesitter-endwise',
      },
      {
        'windwp/nvim-ts-autotag',
      },
      {
        'RRethy/nvim-treesitter-textsubjects',
      },
      --{
      --  'haringsrob/nvim_context_vt',
      --  config = function()
      --    require('nvim_context_vt').setup {

      --    }
      --  end
      --},
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "python",
          "ruby",
          "bash",
          "json",
          "yaml",
          "html",
          "scss",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = false,
        },
        indent = {
          enable = true,
        },
        endwise = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        textsubjects = {
          enable = true,
          prev_selection = '<BS>',
          keymaps = {
            ['<CR>'] = 'textsubjects-smart',
            --['H'] = 'textsubjects-container-outer',
            --['L'] = 'textsubjects-container-inner',
          },
        },
      }
    end,
  },
  {
    'chrisgrieser/nvim-various-textobjs',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    --lazy = true,
    config = function()
        require("various-textobjs").setup {
          useDefaultKeymaps = true,
        }
    end,
  },
  {
    'ziontee113/syntax-tree-surfer',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('syntax-tree-surfer').setup {

      }
    end,
    keys = {
      --{
      --  '<CR>',
      --  mode = { 'n' },
      --  '<Cmd>STSSelectMasterNode<CR>',
      --  desc = 'Select master node',
      --},
      {
        '<CR>',
        mode = { 'n' },
        '<Cmd>STSSelectCurrentNode<CR>',
        desc = 'Select current node',
      },
      {
        'J',
        mode = { 'x' },
        '<Cmd>STSSelectNextSiblingNode<CR>',
        desc = 'Select next node',
      },
      {
        'K',
        mode = { 'x' },
        '<Cmd>STSSelectPrevSiblingNode<CR>',
        desc = 'Select prev node',
      },
      {
        'U',
        mode = { 'x' },
        '<Cmd>STSSwapPrevVisual<CR>',
        desc = 'Swap prev node',
      },
      {
        'D',
        mode = { 'x' },
        '<Cmd>STSSwapNextVisual<CR>',
        desc = 'Swap next node',
      },
      {
        'H',
        mode = { 'x' },
        '<Cmd>STSSelectParentNode<CR>',
        desc = 'Select parent node',
      },
      {
        'L',
        mode = { 'x' },
        '<Cmd>STSSelectChildNode<CR>',
        desc = 'Select child node',
      },
      {
        '<Space>',
        mode = { 'x' },
        '<Cmd>STSSwapOrHoldVisual<CR>',
        desc = 'Swap or Hold Node',
      },
    },
  },
}
