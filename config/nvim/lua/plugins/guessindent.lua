return {
  {
    'NMAC427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {
        auto_cmd = false,
        override_editorconfig = false,
        filetype_exclude = {
          'netrw',
          'tutor',
        },
        buftype_exclude = {
          'help',
          'nofile',
          'terminal',
          'prompt',
        },
      }
    end,
  },
}
