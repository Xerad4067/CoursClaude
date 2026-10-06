-- Fichier : horaires.lua
-- Le magasin est ouvert de 9 h (inclus) à 18 h (exclu).
local heure = 7
local etat = (heure >= 9 and heure < 18) and "ouvert" or "fermé"
print("Il est " .. heure .. " h : le magasin est " .. etat)

heure = 14
etat = (heure >= 9 and heure < 18) and "ouvert" or "fermé"
print("Il est " .. heure .. " h : le magasin est " .. etat)

heure = 20
etat = (heure >= 9 and heure < 18) and "ouvert" or "fermé"
print("Il est " .. heure .. " h : le magasin est " .. etat)
