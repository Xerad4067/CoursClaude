-- Fichier : radar.lua
local lecture = "87"           -- le radar fournit un TEXTE
local limite = 50

local exces = tonumber(lecture) - limite   -- on convertit en nombre avant de calculer
print("Excès de vitesse : " .. exces .. " km/h")
