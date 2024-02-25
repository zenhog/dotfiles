return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup {}
    --    char = '│',
    --    char = '┊',
    --    --char_blankline = '',
    --    show_current_context = true,
    --    show_current_context_start = false,
    --    show_current_context_start_on_current_line = false,
    --    show_first_indent_level = true,
    --    use_treesitter = true,
    --    indent = {
    --      highlight = highlight,
    --    },
    --    scope = {
    --      enabled = true,
    --    },
    --  }
    end,
  },
}
