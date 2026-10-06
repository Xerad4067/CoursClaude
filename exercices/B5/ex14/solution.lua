-- Fichier : guichet.lua
-- Renvoie le nouveau solde, ou bien nil ET la raison du refus.
local function acheter(solde, prix, stock)
  if stock <= 0 then
    return nil, "rupture de stock"
  end
  if prix > solde then
    return nil, "il te manque " .. (prix - solde) .. " €"
  end
  return solde - prix
end

-- Tente un achat, affiche le verdict et renvoie le solde (modifié ou non).
local function tenter(produit, solde, prix, stock)
  local nouveauSolde, raison = acheter(solde, prix, stock)
  if nouveauSolde == nil then
    print(produit .. " : refusé (" .. raison .. ")")
    return solde
  end
  print(produit .. " : acheté, il reste " .. nouveauSolde .. " €")
  return nouveauSolde
end

local solde = 100
solde = tenter("casque", solde, 60, 5)
solde = tenter("moto", solde, 900, 2)
solde = tenter("lampe", solde, 15, 0)
solde = tenter("corde", solde, 25, 10)
print("Solde final : " .. solde .. " €")
