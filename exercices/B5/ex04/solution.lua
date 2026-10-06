-- Fichier : taxe.lua
-- La fonction est définie AVANT d'être appelée.
local function calculerTaxe(prix)
  return prix * 20 // 100
end

print("Taxe : " .. calculerTaxe(100))
