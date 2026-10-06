-- Fichier : totaux.lua
local salaire = 0                 -- accumulateur, AVANT la boucle
for jour = 1, 7 do
  salaire = salaire + 85
end
print("Salaire de la semaine :", salaire)

local somme = 0
for i = 1, 100 do
  somme = somme + i
end
print("Somme de 1 à 100 :", somme)
