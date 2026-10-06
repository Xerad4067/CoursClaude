-- Fichier : recettes.lua
local recettes = { 85, 90, 78, 92 }     -- les recettes de 4 jours

local total = 0                         -- l'accumulateur est créé AVANT la boucle
for _, montant in ipairs(recettes) do
  total = total + montant
end
local moyenne = total / #recettes

print("Total : " .. total .. " €")
print(string.format("Moyenne : %.2f €", moyenne))
