-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "o" }, "U", function()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()
  if node then
    vim.api.nvim_feedkeys("v", "n", false) -- Enter visual mode
    ts_utils.update_selection(0, node)
  end
end, { desc = "Select current Tree-sitter node" })

local map = {
  m = { "i", "n", "c", "o", "t", "v", "x", "s" },
  f = function(modes)
    return function(key, map, desc, opts)
      local opts = opts or {}
      opts.desc = desc
      vim.keymap.set(modes, key, map, opts)
    end
  end,
}

for _, mode in ipairs(map.m) do
  map[mode] = map.f(mode)
end

vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.del({ "n" }, "gri")
vim.keymap.del({ "n" }, "grn")
vim.keymap.del({ "n" }, "grr")

map.a = map.f(map.m)
map.nv = map.f({ "n", "v" })
map.nx = map.f({ "n", "x" })
map.ni = map.f({ "n", "i" })
map.niv = map.f({ "n", "i", "v" })
map.nix = map.f({ "n", "i", "x" })
map.nic = map.f({ "n", "i", "c" })

map.nix("<C-s>", "<Cmd>w<CR>", "Save")
map.nix("<C-q>", "<Cmd>q!<CR>", "Quit")

map.nix("<C-x><C-s>", "<Cmd>wa<CR>", "Save All")
map.nix("<C-x><C-q>", "<Cmd>qa!<CR>", "Quit All")

map.i("<C-p>", "<C-\\><C-o><C-u>", "Half PgUp")
map.i("<C-n>", "<C-\\><C-o><C-d>", "Half PgDn")

map.i("<C-k>", "<Up>")
map.i("<C-j>", "<Down>")

map.nv("<C-k>", "<cmd>Treewalker Up<cr>", "Treewalk Up", { silent = true })
map.nv("<C-j>", "<cmd>Treewalker Down<cr>", "Treewalk Down", { silent = true })
map.nv("<C-h>", "<cmd>Treewalker Left<cr>", "Treewalk Left", { silent = true })
map.nv("<C-l>", "<cmd>Treewalker Right<cr>", "Treewalk Right", { silent = true })

map.nv("<C-x><C-k>", "<cmd>Treewalker SwapUp<cr>", "Treewalk Swap Up", { silent = true })
map.nv("<C-x><C-j>", "<cmd>Treewalker SwapDown<cr>", "Treewalk Swap Down", { silent = true })
map.nv("<C-x><C-h>", "<cmd>Treewalker SwapLeft<cr>", "Treewalk Swap Left", { silent = true })
map.nv("<C-x><C-l>", "<cmd>Treewalker SwapRight<cr>", "Treewalk Swap Right", { silent = true })

vim.api.nvim_set_keymap("x", "iu", ':lua require"treesitter-unit".select()<CR>', { noremap = true })
vim.api.nvim_set_keymap("x", "au", ':lua require"treesitter-unit".select(true)<CR>', { noremap = true })
vim.api.nvim_set_keymap("o", "iu", ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true })
vim.api.nvim_set_keymap("o", "au", ':<c-u>lua require"treesitter-unit".select(true)<CR>', { noremap = true })

map.i("<C-h>", "<Left>")
map.i("<C-l>", "<Right>")

map.i("<C-x><C-h>", "<bs>")
map.i("<C-x><C-l>", "<del>")

map.i("<C-z>", "<S-Left>")
map.i("<C-b>", "<S-Right>")

map.i("<C-x><C-z>", "<C-BSlash><C-o>B")
map.i("<C-x><C-b>", "<C-BSlash><C-o>W")

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

map.nx("k", "v:count == 0 ? 'gk' : 'k'", "Up", { expr = true })
map.nx("j", "v:count == 0 ? 'gj' : 'j'", "Down", { expr = true })

map.n("K", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", "Move Up")
map.n("J", "<cmd>execute 'move .+' . v:count1<cr>==", "Move Down")

-- -- Move Lines
-- map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
-- map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
-- map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
-- map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
-- map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
-- map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
--
-- -- Move to window using the <ctrl> hjkl keys
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
--
-- -- Resize window using <ctrl> arrow keys
-- map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
-- map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
-- map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
-- map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map.n("H", "<cmd>tabprev<cr>", "Prev Tab")
map.n("L", "<cmd>tabnext<cr>", "Next Tab")

map.n("[b", "<cmd>bprev<cr>", "Prev Buffer")
map.n("]b", "<cmd>bnext<cr>", "Next Buffer")

-- map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- map("n", "<leader>bd", function()
--   Snacks.bufdelete()
-- end, { desc = "Delete Buffer" })

-- map("n", "<leader>bo", function()
--   Snacks.bufdelete.other()
-- end, { desc = "Delete Other Buffers" })

-- map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- -- Clear search and stop snippet on escape
-- map({ "i", "n", "s" }, "<esc>", function()
--   vim.cmd("noh")
--   LazyVim.cmp.actions.snippet_stop()
--   return "<esc>"
-- end, { expr = true, desc = "Escape and Clear hlsearch" })

-- -- Clear search, diff update and redraw
-- -- taken from runtime/lua/_editor.lua
-- map(
--   "n",
--   "<leader>ur",
--   "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
--   { desc = "Redraw / Clear hlsearch / Diff Update" }
-- )

-- -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
-- map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
-- map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
-- map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
-- map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
-- map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- -- Add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")

-- --keywordprg
-- map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- -- better indenting
-- map("v", "<", "<gv")
-- map("v", ">", ">gv")

-- -- commenting
-- map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
-- map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

map.n("<space>l", "<cmd>Lazy<cr>", "Lazy")
map.n("<space>x", "<cmd>LazyExtras<cr>", "Lazy")

map.n("<space><cr>", "<cmd>tabnew<cr>", "NewFile")

map.n("[q", vim.cmd.cprev, "Prev Quickfix")
map.n("]q", vim.cmd.cnext, "Next Quickfix")

map.nv("<space>t", function()
  LazyVim.format({ force = true })
end, "Format")

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

-- map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

map.n("]d", diagnostic_goto(true), "Next Diagnostic")
map.n("[d", diagnostic_goto(false), "Prev Diagnostic")

map.n("]e", diagnostic_goto(true, "ERROR"), "Next Error")
map.n("[e", diagnostic_goto(false, "ERROR"), "Prev Error")

map.n("]w", diagnostic_goto(true, "WARN"), "Next Warning")
map.n("[w", diagnostic_goto(false, "WARN"), "Prev Warning")
--
-- -- stylua: ignore start
--
-- -- toggle options
-- LazyVim.format.snacks_toggle():map("<leader>uf")
-- LazyVim.format.snacks_toggle(true):map("<leader>uF")
-- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
-- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
-- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
-- Snacks.toggle.diagnostics():map("<leader>ud")
-- Snacks.toggle.line_number():map("<leader>ul")
-- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
-- Snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<leader>uA")
-- Snacks.toggle.treesitter():map("<leader>uT")
-- Snacks.toggle.option("background", { off = "light", on = "dark" , name = "Dark Background" }):map("<leader>ub")
-- Snacks.toggle.dim():map("<leader>uD")
-- Snacks.toggle.animate():map("<leader>ua")
-- Snacks.toggle.indent():map("<leader>ug")
-- Snacks.toggle.scroll():map("<leader>uS")
-- Snacks.toggle.profiler():map("<leader>dpp")
-- Snacks.toggle.profiler_highlights():map("<leader>dph")
--
-- if vim.lsp.inlay_hint then
--   Snacks.toggle.inlay_hints():map("<leader>uh")
-- end
-- -- highlights under cursor
-- map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
-- map("n", "<leader>uI", function() vim.treesitter.inspect_tree() vim.api.nvim_input("I") end, { desc = "Inspect Tree" })
--
-- -- LazyVim Changelog
-- map("n", "<leader>L", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })
--
-- -- floating terminal
-- map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
-- map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- map("n", "<c-/>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- map("n", "<c-_>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })
--
-- -- Terminal Mappings
-- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
--
-- -- windows
-- map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
-- map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
-- map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
-- Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
-- Snacks.toggle.zen():map("<leader>uz")
--
-- -- tabs
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
--
-- -- native snippets. only needed on < 0.11, as 0.11 creates these by default
-- if vim.fn.has("nvim-0.11") == 0 then
--   map("s", "<Tab>", function()
--     return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
--   end, { expr = true, desc = "Jump Next" })
--   map({ "i", "s" }, "<S-Tab>", function()
--     return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
--   end, { expr = true, desc = "Jump Previous" })
-- end
