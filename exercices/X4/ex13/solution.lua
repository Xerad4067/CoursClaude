-- Fichier : paie.lua
-- Avec local, chaque appel a SON PROPRE total : plus de mélange entre les fonctions.
local function calculerPrime(anciennete)
  local total = anciennete * 50
  return total
end

local function calculerPaie(heures, taux, anciennete)
  local total = heures * taux
  local prime = calculerPrime(anciennete)
  total = total + prime
  return total
end

print("Paie de Sam : " .. calculerPaie(35, 12, 3) .. " €")
print("Paie de Kim : " .. calculerPaie(20, 15, 1) .. " €")
