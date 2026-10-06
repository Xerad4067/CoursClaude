-- Fichier : voyages.lua
local caisses = 47
local parVoyage = 10

local ratio = caisses / parVoyage            -- 4.7 : la division / donne un décimal
print("Voyages complets : " .. math.floor(ratio))       -- arrondi vers le bas : 4
print("Voyages nécessaires : " .. math.ceil(ratio))     -- arrondi vers le haut : 5
