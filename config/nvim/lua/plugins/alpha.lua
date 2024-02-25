return {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local query = require('possession.query')
        local utils = require('possession.utils')

        local workspaces = {
            {
                'Workspace A',
                'a',
                {
                    '/root/directory/a',
                    '/other/root/directory/',
                },
            },
            {
                'Workspace B',
                'b',
                '/root/directory/b',
            },
        }

        local create_button = function(sc, txt, keybind, keybind_opts)
            local leader = "SPC"
            local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")
            local if_nil = vim.F.if_nil
            local fnamemodify = vim.fn.fnamemodify
            local filereadable = vim.fn.filereadable

            local opts = {
                position = 'left',
                shortcut = '[' .. sc .. '] ',
                cursor = 1,
                width = 50,
                align_shortcut = 'left',
                hl_shortcut = {
                    { 'Operator', 0, 1 },
                    { 'Number', 1, #sc + 1 },
                    { 'Operator', #sc + 1, #sc + 2 },
                },
                shrink_margin = false,
            }
            if keybind then
                keybind_opts = if_nil(keybind_opts, {
                    noremap = true,
                    silent = true,
                    nowait = true,
                })
                opts.keymap = {
                    'n',
                    sc_,
                    keybind,
                    {
                        noremap = false,
                        silent = true,
                        nowait = true,
                    },
                }
            end

            local function on_press()
                -- local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
                local key = vim.api.nvim_replace_termcodes(sc .. '<Ignore>', true, false, true)
                vim.api.nvim_feedkeys(key, 't', false)
            end

            return {
                type = 'button',
                val = txt,
                on_press = on_press,
                opts = opts,
            }
        end

        local get_layout = function()
           return query.alpha_workspace_layout(workspaces, create_button)
        end

        local sessions = {
            type = 'group',
            val = utils.throttle(get_layout, 5000),
        }

        local startify = require'alpha.themes.startify'
        local padding = {
            type = 'padding',
            val = 1,
        }

        startify.section.top_buttons.val = {
            startify.button( "e", "  New" , ":ene <BAR> startinsert <CR>"),
            startify.button( "q", "󰅚  Quit" , ":qa<CR>"),
            startify.button( "l", "󰒲  Lazy" , ":Lazy<CR>"),
            startify.button( "m", "󰹖  Mason" , ":Mason<CR>"),
            startify.button( "f", "󰹖  Files" , ":Mason<CR>"),
            startify.button( "o", "󰹖  Old Files" , ":Mason<CR>"),
            startify.button( "s", "󰹖  Sessions" , ":Mason<CR>"),
            startify.button( "w", "󰹖  Whichkey" , ":Mason<CR>"),
            startify.button( "t", "󰹖  Neotree" , ":NeoTreeShow<CR>"),
        }

        require('alpha').setup {
            layout = {
                startify.section.top_buttons,
                sessions,
                startify.section.mru_cwd,
                startify.section.mru,
            },
        }
    end,
}
