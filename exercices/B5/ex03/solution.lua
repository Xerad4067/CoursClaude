-- Fichier : pleins.lua
local function divisionEntiere(a, b)
  return a // b, a % b      -- deux valeurs de retour
end

local pleins, reste = divisionEntiere(130, 40)
print("Pleins possibles :", pleins)
print("Reste :", reste)
