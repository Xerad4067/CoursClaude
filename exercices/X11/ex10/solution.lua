-- Fichier : gestionnaire.lua
local function acheter(produit, quantite)
  if quantite == 0 then
    error("stock épuisé : " .. produit, 0)
  end
  return quantite * 2
end

-- Le gestionnaire reçoit le message d'erreur et renvoie ce que xpcall rendra à la place.
local function gestionnaire(message)
  return "[ERREUR] " .. message
end

print(xpcall(acheter, gestionnaire, "pain", 0))   -- les arguments de acheter viennent après le gestionnaire
print(xpcall(acheter, gestionnaire, "eau", 3))
