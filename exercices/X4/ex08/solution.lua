-- Fichier : caisse.lua
local function compterArticles(...)
  return select("#", ...)          -- nombre d'arguments reçus, les nil compris
end

print("Panier A : " .. compterArticles("pain", "eau", "lampe") .. " article(s)")
print("Panier B : " .. compterArticles() .. " article(s)")
print("Panier C : " .. compterArticles("pain", nil, "lampe", nil) .. " article(s)")
