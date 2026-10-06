-- Fichier : echange.lua
local vehiculeA = "taxi"
local vehiculeB = "camion"
print("Avant :", vehiculeA, vehiculeB)
-- Affectation multiple : Lua calcule d'abord la droite (camion, taxi), puis range.
vehiculeA, vehiculeB = vehiculeB, vehiculeA
print("Après :", vehiculeA, vehiculeB)
