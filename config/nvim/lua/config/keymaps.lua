-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = {
  m = { "i", "n", "c", "o", "t", "v", "x", "s" },
  f = function(modes)
    return function(key, map, desc)
      vim.keymap.set(modes, key, map, { desc = desc })
    end
  end,
}

for _, mode in ipairs(map.m) do
  map[mode] = map.f(mode)
end

map.ni = map.f({ "i", "n" })
map.nix = map.f({ "i", "n", "x" })
map.nic = map.f({ "i", "n", "c" })

vim.keymap.set("i", "<C-_>", '<cmd>lua require("flash").jump()<cr>', { desc = "Flash jump" })
vim.keymap.set("i", "<C-d><C-_>", '<cmd>lua require("flash").delete()<cr>', { desc = "Flash delete" })

map.ni("<C-s>", "<Cmd>w<CR>", "Save")
map.ni("<C-q>", "<Cmd>q<CR>", "Quit")

map.i("<C-p>", "<C-\\><C-o><C-u>", "Half PgUp")
map.i("<C-n>", "<C-\\><C-o><C-d>", "Half PgDn")

map.i("<C-k>", "<Up>")
map.i("<C-j>", "<Down>")

map.i("<C-h>", "<BS>")
map.i("<C-l>", "<Del>")

map.i("<C-x><C-h>", "<Left>")
map.i("<C-x><C-l>", "<Right>")

map.i("<C-d><C-h>", "<S-Left>")
map.i("<C-d><C-l>", "<S-Right>")

map.i("<Esc>", "<C-c>")
map.i("<C-u>", "<C-o>u")
map.i("<C-x><C-v>", "<C-v>")

map.i("<C-d><C-d>", "<C-BSlash><C-o>d")
map.i("<C-x><C-x>", "<C-BSlash><C-o><C-r>")

map.i("<C-a>", "<Home>")
map.i("<C-e>", "<End>")

map.i("<C-x><C-a>", "<C-d>", "Indent left")
map.i("<C-x><C-e>", "<C-t>", "Indent right")

map.i("<C-d><C-a>", "<C-BSlash><C-o>d0")
map.i("<C-d><C-e>", "<C-BSlash><C-o>d$")

map.i("<C-w>", "<C-BSlash><C-o>db")
map.i("<C-f>", "<C-BSlash><C-o>dw")

map.i("<C-d><C-w>", "<C-BSlash><C-o>dB")
map.i("<C-d><C-f>", "<C-BSlash><C-o>dW")

map.i("<C-x><C-w>", "<C-BSlash><C-o>B")
map.i("<C-x><C-f>", "<C-BSlash><C-o>W")
