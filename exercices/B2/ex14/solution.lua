-- Fichier : titre.lua
local largeur = 30
local titre = "Garage de Kim"
local marge = (largeur - #titre) // 2      -- espaces à mettre avant le titre

print(string.rep("=", largeur))
print(string.rep(" ", marge) .. titre)
print(string.rep("=", largeur))
