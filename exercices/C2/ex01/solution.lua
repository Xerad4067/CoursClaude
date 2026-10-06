-- Fichier : taxe.lua
local prix = 120
local taxes = 20          -- 20 % de taxe
local total = prix + prix * taxes // 100     -- « taxes » : le nom doit être écrit pareil partout
print("Total à payer : " .. total .. " €")
