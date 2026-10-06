-- Fichier : facture.lua
local function prixTotal(prix, quantite)
  local total = prix * quantite         -- on calcule... mais on ne renvoie rien
end

print("Lampes : " .. prixTotal(15, 3) .. " €")
print("Cordes : " .. prixTotal(4, 5) .. " €")
