-- Fichier : facture.lua
local function prixTotal(prix, quantite)
  local total = prix * quantite
  return total                          -- sans cette ligne, la fonction renvoie nil
end

print("Lampes : " .. prixTotal(15, 3) .. " €")
print("Cordes : " .. prixTotal(4, 5) .. " €")
