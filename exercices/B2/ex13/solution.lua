-- Fichier : plaque.lua
local prenom = "samuel"
local numero = 7

local lettres = string.upper(string.sub(prenom, 1, 3))   -- SAM
local chiffres = string.format("%03d", numero)           -- 007 : 3 chiffres, complétés par des 0
local cle = #prenom                                      -- 6 : nombre de lettres du prénom

print(lettres .. "-" .. chiffres .. "-" .. cle)
