-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "<C-_>", '<cmd>lua require("flash").jump()<cr>', { desc = "Flash jump" })
vim.keymap.set("i", "<C-d><C-_>", '<cmd>lua require("flash").delete()<cr>', { desc = "Flash delete" })

-- Half-page scrolling in insert mode
vim.keymap.set("i", "<C-n>", "<cmd>normal! <C-d><cr>", { desc = "Scroll half page down" })
vim.keymap.set("i", "<C-p>", "<cmd>normal! <C-u><cr>", { desc = "Scroll half page up" })

vim.keymap.set("i", "<C-t>", "<cmd>Neotree action=show toggle<cr>", { desc = "Toggle Neotree symbols" })

vim.keymap.set("i", "<C-s>", "<cmd>w<cr>", { desc = "Save Buffer" })
vim.keymap.set("i", "<C-q>", "<cmd>q<cr>", { desc = "Kill window" })

vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Down line" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Up line" })
vim.keymap.set("i", "<C-h>", "<BS>", { desc = "Delete 1 char left" })
vim.keymap.set("i", "<C-l>", "<Del>", { desc = "Delete 1 char right" })

vim.keymap.set("i", "<C-x><C-j>", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
vim.keymap.set("i", "<C-x><C-k>", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev hunk" })

vim.keymap.set("i", "<C-x><C-h>", "<Left>", { desc = "1 char left" })
vim.keymap.set("i", "<C-x><C-l>", "<Right>", { desc = "1 char right" })

-- Indentation
vim.keymap.set("i", "<C-x><C-a>", "<cmd>normal <<<cr>", { desc = "Indent left" })
vim.keymap.set("i", "<C-x><C-e>", "<cmd>normal >><cr>", { desc = "Indent right" })

-- Deletion
vim.keymap.set("i", "<C-w>", "<C-o>db", { desc = "Delete backward word" })
vim.keymap.set("i", "<C-x><C-w>", "<C-o>dB", { desc = "Delete backward Word" })
vim.keymap.set("i", "<C-f>", "<C-o>dw", { desc = "Delete forward word" })
vim.keymap.set("i", "<C-x><C-f>", "<C-o>dW", { desc = "Delete forward Word" })

-- Delete operations that handle edge cases
vim.keymap.set("i", "<C-d><C-a>", "<cmd>normal! v0d<cr>", { desc = "Delete till beginning of line" })
vim.keymap.set("i", "<C-d><C-e>", "<cmd>normal! v$d<cr>", { desc = "Delete till end of line" })

vim.keymap.set("i", "<C-d><C-d>", "<C-o>d", { desc = "Delete operator" })

-- Navigation
vim.keymap.set("i", "<C-a>", "<Home>", { desc = "Beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "End of line" })
