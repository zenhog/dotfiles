return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.g.neo_tree_remove_legacy_commands = 1
        end,
        keys = {
            {
                "<C-y>",
                mode = { "n" },
                '<Cmd>NeoTreeFocus<CR>',
                desc = 'Neotree Focus',
            },
        },
    },
}
