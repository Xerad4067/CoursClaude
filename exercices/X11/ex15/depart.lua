-- Fichier : journal.lua
local stock = { lampe = 3 }

local function acheter(produit)
  if stock[produit] == nil then
    error("produit inconnu : " .. produit, 0)
  end
  stock[produit] = stock[produit] - 1
  return stock[produit]
end
