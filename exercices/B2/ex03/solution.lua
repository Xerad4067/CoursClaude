-- Fichier : conversions.lua
local saisie = "250"                 -- du texte (comme ce qu'on tape au clavier)
local montant = tonumber(saisie)     -- devient le nombre 250
print(montant + 50)
print(tonumber("abc"))               -- impossible : nil
print(tostring(42) .. "!")
print(#"Nanos")                      -- longueur : 5
