local actions = require('fzf-lua').actions

local M = {}

local function open_in_new_tab(selected)
  vim.cmd('tabnew ' .. selected[1])
end

local function lsp_references_action(selected_item)
  local line = selected_item.lnum - 1
  local col = selected_item.col - 1

  local params = vim.lsp.util.make_position_params()
  params.position = { line = line, character = col }

  vim.lsp.buf_request(0, "textDocument/references", params, function(err, result, ctx, config)
    if result then
      require("fzf-lua").lsp_fzf_locations("References", result)
    end
  end)
end

local function copy_to_clipboard(selected, opts)
    local status, err = pcall(function()
        vim.fn.setreg('+', selected[1])
        vim.notify('Copied symbol "' .. selected[1] .. '" to clipboard')
    end)
    if not status then
        vim.notify('Error: ' .. tostring(err), vim.log.levels.ERROR)
    end
  return true
end

function M.setup()
  require('fzf-lua').setup({
    lsp = {
      actions = {
        ['ctrl-r'] = { copy_to_clipboard, 'copy symbol to clipboard' },
      },
    },
    actions = {
      files = {
        ['ctrl-o'] = { open_in_new_tab, 'open in new tab' },
        ['ctrl-r'] = { copy_to_clipboard, 'copy to clipboard' },
      },
    },
  })
end

return M
