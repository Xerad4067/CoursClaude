-- Fichier : taxe.lua
print("Taxe : " .. calculerTaxe(100))

local function calculerTaxe(prix)
  return prix * 20 // 100
end
