-- Fichier : mesures.lua
local ville = "Port-Lune"
local habitants = 48250

print(ville .. " : " .. #ville .. " caractères")                       -- # mesure un texte
print(habitants .. " : " .. #tostring(habitants) .. " chiffres")       -- tostring transforme le nombre en texte, puis # le mesure
