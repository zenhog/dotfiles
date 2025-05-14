local M = {
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

map.a = map.f(map.m)
map.ni = map.f({ "i", "n" })
map.nix = map.f({ "i", "n", "x" })
map.nic = map.f({ "i", "n", "c" })

return M
