return {
  "olimorris/codecompanion.nvim",
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionActions",
    "CodeCompanionChat Toggle",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "openrouter",
          slash_commands = {
            ["file"] = {
              -- Location to the slash command in CodeCompanion
              callback = "strategies.chat.slash_commands.file",
              description = "Select a file using Telescope",
              opts = {
                provider = "fzf_lua",
                contains_code = true,
              },
            },
            ["buffer"] = {
              -- Location to the slash command in CodeCompanion
              callback = "strategies.chat.slash_commands.buffer",
              description = "Select a file using Telescope",
              opts = {
                provider = "telescope",
                contains_code = true,
              },
            },
          },
        },
      },
      adapters = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              api_key = "cmd:pass show www/ai/openrouter.ai/apikey",
              url = "https://openrouter.ai/api",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "deepseek/deepseek-chat-v3-0324:free",
              },
            },
          })
        end,
        gemini = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              api_key = "cmd:pass show www/ai/openrouter.ai/apikey",
              url = "https://openrouter.ai/api",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "google/gemini-2.5-pro-exp-03-25:free",
              },
            },
          })
        end,
        llama = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              api_key = "cmd:pass show www/ai/openrouter.ai/apikey",
              url = "https://openrouter.ai/api",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "meta-llama/llama-4-maverick:free",
              },
            },
          })
        end,
      },
      default_adapter = "openrouter",
      window = {
        layout = "float", -- float|vertical|horizontal|buffer
        position = nil, -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
        width = 0.50,
        relative = "editor",
        opts = {
          breakindent = true,
          cursorcolumn = false,
          cursorline = false,
          foldcolumn = "0",
          linebreak = true,
          list = false,
          numberwidth = 1,
          signcolumn = "no",
          spell = false,
          wrap = true,
        },
      },

      display = {
        chat = {
          intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
          show_header_separator = false,
          separator = "─", -- The separator between the different messages in the chat buffer
          show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
          show_settings = true, -- Show LLM settings at the top of the chat buffer?
          show_token_count = true, -- Show the token count for each response?
          start_in_insert_mode = false, -- Open the chat buffer in insert mode?
        },
        action_palette = {
          width = 0.5,
          height = 0.5,
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "default", -- default|telescope|mini_pick
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<C-f>",
      mode = { "n", "v" },
      "<cmd>CodeCompanionActions<cr>",
      desc = "CodeCompanion: Actions",
    },
    {
      "<C-x><C-f>",
      mode = { "n", "v" },
      "<cmd>CodeCompanionChat Toggle<cr>",
      desc = "CodeCompanion: Toggle",
    },
  },
}
