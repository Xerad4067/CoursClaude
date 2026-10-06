-- Fichier : sac.lua
local inventaire = { "pain", "eau", "lampe" }
print(inventaire[1])               -- la première case est la numéro 1
print(#inventaire)                 -- nombre d'éléments
table.insert(inventaire, "corde")  -- ajout à la fin
print(inventaire[#inventaire])     -- le dernier élément
