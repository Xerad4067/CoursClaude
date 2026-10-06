-- Fichier : facture.lua
-- Prix d'un lot de pneus : (prix unitaire + 5 € de pose) × quantité.
local function prixLot(prixUnitaire, quantite)
  return prixUnitaire + 5 * quantite
end

print("4 pneus à 40 € : " .. prixLot(40, 4) .. " €")
print("1 pneu à 40 € : " .. prixLot(40, 1) .. " €")
