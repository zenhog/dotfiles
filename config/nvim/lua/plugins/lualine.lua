local function lspname()
  local icon = ''
  local msg = icon
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return icon .. ' ' .. client.name
    end
  end
  return msg
end

local function session()
  return require('possession.session').session_name or ''
end

local function location()
  local curcol = vim.fn.col('.')
  local curline = vim.fn.line('.')
  local lastline = vim.fn.line('$')
  local percentage = curline * 100 / lastline
  percentage = tonumber(string.format('%.f', percentage))
  local format = '%d/%d:%d-%d%%'
  format = string.format(format, curline, lastline, curcol, percentage)
  return curline .. '/' .. lastline .. ':' .. curcol .. '[' .. percentage
  .. '%%]'
end

local function formatencoding()
  local encoding = vim.bo.fileencoding
  local format = vim.bo.fileformat
  return format .. '[' .. encoding .. ']'
end

local function filetypeLSP()
  local filetype = vim.bo.filetype
  return filetype
end

local function updates()
  return require('lazy.status').updates() or ''
end

local function tabs()
  local sep = ' ∙ '
  local tabnr = vim.fn.tabpagenr()
  local tablist = vim.fn.gettabinfo()
  local output = ''

  if #tablist == 1 then
    return ''
  end

  for _, v in ipairs(tablist) do
    if v.tabnr == tabnr then
      output = output .. '%#lualine_custom_active#' .. v.tabnr
    else
      output = output .. '%#lualine_custom_inactive#' .. v.tabnr
    end
    if v.tabnr ~= #tablist then
      output = output .. '%#lualine_custom_inactive#' .. sep
    end
  end
  return output
end

local top = {
  lualine_a = {
    'mode',
    updates,
  },
  lualine_b = {
    tabs,
  },
  lualine_c = {
    'branch',
    'diff',
    {
      'windows',
      fmt = function(str)
        return '%=' .. str
      end,
    },
    'diagnostics',
  },
  lualine_x = {
    filetypeLSP,
    lspname,
    formatencoding,
  },
  lualine_y = {
    location,
  },
  lualine_z = {
    session,
  },
}
local bottom = {
  lualine_a = {
    'lsp_progress',
  },
  lualine_b = {
  },
  lualine_c = {
  },
  lualine_x = {
  },
  lualine_y = {
  },
  lualine_z = {
  },
}
return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'arkav/lualine-lsp-progress',
    },
    config = function()
      local theme = vim.fn.system('cat $HOME/.colorscheme | tr -d "\n"')
      if theme == '' or not theme then
        theme = 'dark'
      end
      vim.g.lualine_theme_dark = 'solarized_dark'
      vim.g.lualine_theme_light = 'solarized_light'
      vim.api.nvim_set_hl(0, 'lualine_custom_active', {
        fg = "cyan",
        bold = true,
      })
      vim.api.nvim_set_hl(0, 'lualine_custom_inactive', {
      })
      require('lualine').setup({
        options = {
          theme = vim.g['lualine_theme_' .. theme],
          icons_enabled = true,
          component_separators = { left = '∙', right = '∙' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = bottom,
        inactive_sections = bottom,
        tabline = top,
      })
      vim.o.laststatus = 0
    end,
  },
}
