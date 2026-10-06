-- Fichier : pourboires.lua
local function additionner(...)
  local valeurs = { ... }          -- les arguments reçus sont rangés dans une liste
  local total = 0
  for _, v in ipairs(valeurs) do
    total = total + v
  end
  return total
end

print("Pourboires du soir : " .. additionner(5, 10, 2) .. " €")
print("Pourboires du matin : " .. additionner() .. " €")
print("Pourboire unique : " .. additionner(40) .. " €")
