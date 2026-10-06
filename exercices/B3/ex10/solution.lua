-- Fichier : distributeur.lua
local stock = 4       -- boissons restantes
local prix = 3
local argent = 5      -- pièces insérées

if stock > 0 then
  -- Il reste des boissons : on regarde maintenant l'argent.
  if argent >= prix then
    print("Boisson servie")
    print("Monnaie rendue : " .. argent - prix .. " €")
  else
    print("Il manque " .. prix - argent .. " €")
  end
else
  print("Distributeur vide")
end
