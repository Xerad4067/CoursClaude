-- Fichier : lecture.lua
local a = { 10, 9, 100, 1 }
table.sort(a)
print(table.concat(a, " "))

local b = { "10", "9", "100", "1" }
table.sort(b)
print(table.concat(b, " "))

local c = { "banane", "Pomme", "abricot", "Cerise" }
table.sort(c)
print(table.concat(c, " "))
