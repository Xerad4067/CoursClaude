-- Fichier : lecture.lua
local a = 5
local b = a      -- b reçoit une copie de la valeur 5
a = 10
print(a, b)
local nom = "Kim"
nom = nil        -- on vide la boîte
print(nom)
print(type(nom))
