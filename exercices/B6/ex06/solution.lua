-- Fichier : file.lua
local file = { "Kim", "Alex", "Sam" }
table.sort(file)                          -- ordre alphabétique
print("File : " .. table.concat(file, ", "))
local premier = table.remove(file, 1)     -- retire et renvoie le premier
print("Servi : " .. premier)
print("Reste : " .. table.concat(file, ", "))
