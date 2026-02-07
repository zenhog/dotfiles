return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup {
        indent = {
          char = '│',
          tab_char = '│',
          highlight = { 'Normal' },
          smart_indent_cap = true,
    --    show_first_indent_level = true,
        },
        whitespace = {
          highlight = { 'Normal' },
        },
        scope = {
          enabled = true,
          char = '┊',
          highlight = { 'Normal', },
          show_start = false,
          show_end = false,
        },
      }
      local hooks = require "ibl.hooks"
      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_space_indent_level
      )
      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_tab_indent_level
      )
    end,
  },
}
