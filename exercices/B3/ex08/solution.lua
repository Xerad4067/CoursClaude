-- Fichier : concession.lua
local nomVehicule = "Sultan"
local prixVehicule = 15000
local argent = 12000
local age = 19
local aLePermis = true

print("=== Concession automobile ===")
print("Véhicule : " .. nomVehicule .. " (" .. prixVehicule .. " €)")
-- Les règles, dans l'ordre :
if not aLePermis then
  print("Achat refusé : il faut le permis de conduire.")
elseif age < 18 then
  print("Achat refusé : il faut avoir 18 ans.")
elseif argent < prixVehicule then
  print("Achat refusé : il te manque " .. prixVehicule - argent .. " €.")
else
  argent = argent - prixVehicule
  print("Achat validé ! Il te reste " .. argent .. " €.")
end
