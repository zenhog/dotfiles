return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            require('neo-tree').setup {
                sources = {
                    "filesystem",
                    "buffers",
                    "git_status",
                    "document_symbols",
                },
            }
        end,
        keys = {
            {
                "<C-y>",
                mode = { "n" },
                '<Cmd>Neotree toggle<CR>',
                desc = 'Neotree toggle',
            },
        },
    },
}
