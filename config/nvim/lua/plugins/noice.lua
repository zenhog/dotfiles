return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    messages = {
      enabled = true,
      view = "mini",
      view_error = "mini",
      view_warn = "mini",
      view_history = "mini",
      view_search = "mini",
    },
    popupmenu = {
      enabled = true,
    },
    notify = {
      enabled = true,
      view = "mini",
    },
    redirect = {
      view = "mini",
      filter = {
        event = "msg_show",
      },
    },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
    },
    -- status = {
    --   ruler = true,
    --   message = true,
    --   command = false,
    --   mode = true,
    --   search = true,
    -- },
  },
    -- stylua: ignore
  keys = function()
    return {
      -- { "<leader>sn", "", desc = "+noice"},
      -- { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      -- { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      -- { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      -- { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<space>n", function() require("noice").cmd("dismiss") end, desc = "Noice Dismiss" },
      { "<bslash>n", function() require("noice").cmd("fzf") end, desc = "Noice Messages" },
      -- { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
      -- { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    }
  end,
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end
    require("noice").setup(opts)
  end,
}
