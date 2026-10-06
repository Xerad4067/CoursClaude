-- Fichier : puissance.lua
local function puissance(base, exposant)
  if exposant == 0 then
    return 1                                     -- cas de base : n'importe quoi puissance 0 vaut 1
  end
  return base * puissance(base, exposant - 1)
end

print("2 puissance 10 = " .. puissance(2, 10))
print("3 puissance 4 = " .. puissance(3, 4))
