-- Fichier : inventaire.lua
local inventaire = { "pain" }
inventaire:insert("eau")
inventaire:insert("lampe")
print(table.concat(inventaire, ", "))
