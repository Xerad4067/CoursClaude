-- Fichier : unpack.lua
local prix = { 12, 7, 25, 18 }
-- table.unpack transforme la liste en arguments séparés : math.max(12, 7, 25, 18)
print("Course la plus chère : " .. math.max(table.unpack(prix)) .. " €")

local trajet = { "Gare", "Parc", 4 }
-- Ici, la liste fournit les trois valeurs attendues par string.format.
print(string.format("%s -> %s (%d km)", table.unpack(trajet)))
