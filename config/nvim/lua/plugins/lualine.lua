local function session_name()
  return require("possession.session").get_session_name() or ""
end

local function lspname()
  local icon = "LSP:"
  local icon = " "
  local msg = icon
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return icon .. " " .. client.name
    end
  end
  return msg
end

local function location()
  local curcol = vim.fn.col(".")
  local curline = vim.fn.line(".")
  local lastline = vim.fn.line("$")
  local percentage = curline * 100 / lastline
  percentage = tonumber(string.format("%.f", percentage))
  local format = "%d/%d:%d-%d%%"
  format = string.format(format, curline, lastline, curcol, percentage)
  return curline .. "/" .. lastline .. ":" .. curcol .. "[" .. percentage .. "%%]"
end

local function tabs()
  local sep = " ∙ "
  local tabnr = vim.fn.tabpagenr()
  local tablist = vim.fn.gettabinfo()
  local output = ""

  if #tablist == 1 then
    return ""
  end

  for _, v in ipairs(tablist) do
    if v.tabnr == tabnr then
      output = output .. "%#lualine_custom_active#" .. v.tabnr
    else
      output = output .. "%#lualine_custom_inactive#" .. v.tabnr
    end
    if v.tabnr ~= #tablist then
      output = output .. "%#lualine_custom_inactive#" .. sep
    end
  end
  return output
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = LazyVim.config.icons

    vim.o.laststatus = vim.g.lualine_laststatus
    vim.api.nvim_set_hl(0, "lualine_custom_active", {
      fg = "cyan",
      bold = true,
    })
    vim.api.nvim_set_hl(0, "lualine_custom_inactive", {})

    local opts = {
      options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        component_separators = { left = "", right = "" },
        component_separators = { left = " ", right = " " },
        section_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
      },
      tabline = {
        lualine_a = {
          "mode",
          lspname,
          {
            require("mcphub.extensions.lualine"),
          },
        },
        lualine_b = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return { fg = Snacks.util.color("Special") }
            end,
          },
        },
        lualine_c = {
          { LazyVim.lualine.pretty_path() },
        },
        lualine_z = {
          tabs,
          -- "tabs",
          session_name,
        },
      },
      sections = {
        -- lualine_a = { "mode" },
        lualine_b = { "branch" },

        lualine_c = {
          LazyVim.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          Snacks.profiler.status(),
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function()
              return package.loaded["noice"] and require(
                "noice"
              ).api.status.command.has()
            end,
            color = function() return { fg = Snacks.util.color("Statement") } end,
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
          -- stylua: ignore
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          -- { "progress", separator = " ", padding = { left = 1, right = 0 } },
          --{ "location", padding = { left = 0, right = 1 } },
          location,
        },
        lualine_z = {},
        -- lualine_z = {
        --   tabs,
        --   session_name,
        -- },
        -- lualine_z = {
        --   function()
        --     return " " .. os.date("%R")
        --   end,
        -- },
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    }

    -- do not add trouble symbols if aerial is enabled
    -- And allow it to be overriden for some buffer types (see autocmds)
    if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      table.insert(opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
    end

    return opts
  end,
}
