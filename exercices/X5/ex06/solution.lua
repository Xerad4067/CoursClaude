-- Fichier : inventaire.lua
local inventaire = { "pain" }
-- insert n'est pas une méthode de la liste : c'est une fonction de la bibliothèque table.
table.insert(inventaire, "eau")
table.insert(inventaire, "lampe")
print(table.concat(inventaire, ", "))
