-- Fichier : puissance.lua
local function puissance(base, exposant)
  return base * puissance(base, exposant - 1)
end

print("2 puissance 10 = " .. puissance(2, 10))
print("3 puissance 4 = " .. puissance(3, 4))
