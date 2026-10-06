-- Fichier : stock.lua
local stock = 5

local function vendre(quantite)
  stock = stock - quantite                       -- on modifie le stock AVANT de vérifier
  if stock < 0 then
    error("rupture de stock", 0)
  end
  return stock
end

print(pcall(vendre, 2))
print(pcall(vendre, 4))
print(stock)
print(pcall(vendre, 1))
