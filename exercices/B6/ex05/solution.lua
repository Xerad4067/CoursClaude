-- Fichier : references.lua
local a = { 1, 2, 3 }
local b = a                -- b désigne la MÊME table que a
b[1] = 100
print(a[1])
print(#a)
table.insert(a, 4)
print(#b)
local c = { 1, 2, 3 }      -- une autre table, même contenu
print(a == c)
print(table.concat(c, "-"))
