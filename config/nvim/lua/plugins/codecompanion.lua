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
      -- extensions = {
      --   mcphub = {
      --     callback = "mcphub.extensions.codecompanion",
      --     opts = {
      --       show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
      --       make_vars = true, -- make chat #variables from MCP server resources
      --       make_slash_commands = true, -- make /slash_commands from MCP server prompts
      --     },
      --   },
      -- },
      strategies = {
        inline = {
          adapter = "deepqwen",
        },
        chat = {
          adapter = "deepqwen",
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
                provider = "fzf_lua",
                contains_code = true,
              },
            },
          },
        },
      },
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              api_key = "cmd:pass show iz/www/llm/openrouter.ai/0/apikey",
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
        deepqwen = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              api_key = "cmd:pass show iz/www/llm/openrouter.ai/0/apikey",
              url = "https://openrouter.ai/api",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "deepseek/deepseek-r1-0528-qwen3-8b:free",
              },
            },
          })
        end,
      },
      default_adapter = "deepqwen",
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
      prompt_library = {
        ["Translate"] = {
          strategy = "chat",
          description = "Write documentation for me",
          opts = {
            index = 11,
            is_slash_cmd = true,
            auto_submit = false,
            short_name = "trans",
          },
          prompts = {
            {
              role = "system",
              content = [[
                You are a multi-language translator.
                The input is of the form 'FR:EN Ceci est un texte en Français!'
                The first word represents the source and the destination
                language codes separated by a colon. If absent, you are to
                guess the source language and translate it into English, unless
                the source language is English, in which case, you translate to
                French.
                It is essential that your response only contains the
                translation of the input and nothing else (with the exception
                of the country codes specification which is to be ignored in
                the translation).
                Here are a few examples of a translation interaction:

                Input: FR:EN Ceci est un texte en Français!
                Output: This is a text written in French!

                Input: Default behaviour is ignorance
                Output: Le comportement par défaut est l'ignorance
              ]],
            },
            {
              role = "user",
              content = "Here is a simple text to translate to get you going",
            },
          },
        },
        ["Docusaurus"] = {
          strategy = "chat",
          description = "Write documentation for me",
          opts = {
            index = 11,
            is_slash_cmd = false,
            auto_submit = false,
            short_name = "docs",
          },
          references = {
            {
              type = "file",
              path = {
                "doc/.vitepress/config.mjs",
                "lua/codecompanion/config.lua",
                "README.md",
              },
            },
          },
          prompts = {
            {
              role = "user",
              content = [[I'm rewriting the documentation for my plugin CodeCompanion.nvim, as I'm moving to a vitepress website. Can you help me rewrite it?
    
    I'm sharing my vitepress config file so you have the context of how the documentation website is structured in the `sidebar` section of that file.
    
    I'm also sharing my `config.lua` file which I'm mapping to the `configuration` section of the sidebar.
    ]],
            },
          },
        },
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  -- TODO
  -- keys for
  --    ai-cursor prompts
  --    /gentests
  --    /dockerize
  --    /
  --    /explain
  --    /translate
  --    /english
  --    /french
  --    /spanish
  --    /arabic
  --    /lookup
  --      definition
  --      synonyms/antonyms
  --      examples
  --      phonetics
  --      part of speech
  --      translations
  keys = {
    {
      "<C-X><C-F>",
      mode = { "n", "v" },
      "<cmd>CodeCompanionActions<cr>",
      desc = "CodeCompanion Actions",
    },
    {
      "<C-F>",
      mode = { "n", "v" },
      "<cmd>CodeCompanionChat Toggle<cr>",
      desc = "CodeCompanion Toggle",
    },
  },
}
