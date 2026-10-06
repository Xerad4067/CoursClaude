-- Fichier : paie.lua
local function calculerPrime(anciennete)
  total = anciennete * 50
  return total
end

local function calculerPaie(heures, taux, anciennete)
  total = heures * taux
  local prime = calculerPrime(anciennete)
  total = total + prime
  return total
end

print("Paie de Sam : " .. calculerPaie(35, 12, 3) .. " €")
print("Paie de Kim : " .. calculerPaie(20, 15, 1) .. " €")
