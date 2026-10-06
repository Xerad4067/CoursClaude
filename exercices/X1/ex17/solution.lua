-- Fichier : chrono.lua
local total = 7384                 -- durée du tour, en secondes

local heures = total // 3600       -- 3600 secondes par heure
local reste = total % 3600         -- ce qui reste après les heures complètes
local minutes = reste // 60
local secondes = reste % 60

print(string.format("%02d:%02d:%02d", heures, minutes, secondes))
