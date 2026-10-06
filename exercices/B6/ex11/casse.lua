-- Fichier : nettoyage.lua
local garage = { "Sultan", "Epave", "Epave", "Taxi", "Epave" }
for i, vehicule in ipairs(garage) do
  if vehicule == "Epave" then
    table.remove(garage, i)      -- on retire pendant qu'on parcourt dans l'ordre...
  end
end
print(table.concat(garage, ", "))
