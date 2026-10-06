-- Fichier : nettoyage.lua
local garage = { "Sultan", "Epave", "Epave", "Taxi", "Epave" }
-- On parcourt de la FIN vers le début : retirer un élément ne décale que ceux qu'on a déjà vus.
for i = #garage, 1, -1 do
  if garage[i] == "Epave" then
    table.remove(garage, i)
  end
end
print(table.concat(garage, ", "))
