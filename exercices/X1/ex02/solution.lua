-- Fichier : terrain.lua
local cote = 12                -- côté du terrain, en mètres
local aire = cote ^ 2          -- ^ élève à la puissance 2 ; le résultat est toujours un décimal
print("Aire : " .. aire)       -- 144.0 : le « .0 » vient de ce décimal
