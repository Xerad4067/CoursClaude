-- Fichier : age.lua
local saisie = "17"            -- ce que le joueur a tapé : du texte
local age = tonumber(saisie)   -- on convertit en nombre AVANT de comparer
print("Mineur ?", age < 18)
