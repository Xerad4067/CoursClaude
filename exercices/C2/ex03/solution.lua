-- Fichier : tableau.lua
-- Lis ce code sans l'exécuter : construis le tableau des valeurs jour après jour.
local argent = 100
local salaire = 40
for jour = 1, 4 do
  if jour % 2 == 0 then
    argent = argent + salaire          -- jour pair : le salaire tombe
  else
    argent = argent - 15               -- jour impair : on dépense 15 €
  end
  print("Jour " .. jour .. " : " .. argent .. " €")
end
print("Argent final : " .. argent .. " €")
