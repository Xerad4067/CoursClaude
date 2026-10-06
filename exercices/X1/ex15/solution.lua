-- Fichier : miroir.lua
local mot = string.lower("Kayak")                  -- on passe en minuscules pour ignorer les majuscules
local estPalindrome = (mot == string.reverse(mot))   -- le mot est-il égal à son reflet ?
print("Kayak : " .. tostring(estPalindrome))        -- un booléen ne se colle pas tel quel : tostring

mot = string.lower("Taxi")
estPalindrome = (mot == string.reverse(mot))
print("Taxi : " .. tostring(estPalindrome))
