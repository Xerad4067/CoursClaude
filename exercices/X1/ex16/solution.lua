-- Fichier : distance.lua
local x1, y1 = 10, 20      -- premier joueur
local x2, y2 = 25, 60      -- second joueur

local dx = x2 - x1         -- écart horizontal : 15
local dy = y2 - y1         -- écart vertical : 40
local distance = math.sqrt(dx ^ 2 + dy ^ 2)   -- Pythagore : racine de 15² + 40²

print(string.format("Distance : %.2f m", distance))
