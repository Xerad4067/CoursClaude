-- Fichier : vehicule.lua
local plaque = "AB-123-CD"    -- du texte
local places = 5              -- un nombre
local estElectrique = false   -- un booléen
local proprietaire            -- pas de « = » : la boîte reste vide, donc nil

print("plaque", type(plaque))
print("places", type(places))
print("estElectrique", type(estElectrique))
print("proprietaire", type(proprietaire))
