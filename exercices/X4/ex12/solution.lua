-- Fichier : places.lua
local function compterVides(...)
  local args = table.pack(...)     -- args.n = nombre d'arguments, même si certains valent nil
  local vides = 0
  for i = 1, args.n do
    if args[i] == nil then
      vides = vides + 1
    end
  end
  return vides, args.n
end

local vides, total = compterVides("Sam", nil, "Alex", nil, "Kim")
print("Bus 1 : " .. vides .. " place(s) vide(s) sur " .. total)
vides, total = compterVides("Sam", "Kim")
print("Bus 2 : " .. vides .. " place(s) vide(s) sur " .. total)
vides, total = compterVides(nil, nil)
print("Bus 3 : " .. vides .. " place(s) vide(s) sur " .. total)
