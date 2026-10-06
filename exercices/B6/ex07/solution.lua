-- Fichier : ventes.lua
local ventes = { "pain", "eau", "pain", "lampe", "eau", "pain" }
local compte = {}
for _, produit in ipairs(ventes) do
  compte[produit] = (compte[produit] or 0) + 1   -- 0 si le produit est nouveau
end
-- pairs n'a pas d'ordre : on impose le nôtre avec une liste.
for _, produit in ipairs({ "pain", "eau", "lampe" }) do
  print(produit .. " : " .. compte[produit])
end
