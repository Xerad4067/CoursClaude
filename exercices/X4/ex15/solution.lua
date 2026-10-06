-- Fichier : livraisons.lua
-- Nombre d'ordres de livraison possibles pour n colis : n! = n × (n-1) × … × 1
local function factorielle(n)
  if n <= 1 then
    return 1                          -- cas de base : on s'arrête ici
  end
  return n * factorielle(n - 1)       -- cas récursif : un problème plus petit
end

print("3 colis : " .. factorielle(3) .. " ordres possibles")
print("5 colis : " .. factorielle(5) .. " ordres possibles")
print("10 colis : " .. factorielle(10) .. " ordres possibles")
print("0 colis : " .. factorielle(0) .. " ordre possible")
