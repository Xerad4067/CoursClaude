-- Fichier : grotte.lua
local r1, r2, r3, r4 = -3, 4, -8, 2     -- quatre relevés de température

local plusBasse = math.min(r1, r2, r3, r4)    -- math.min et math.max acceptent plusieurs valeurs
local plusHaute = math.max(r1, r2, r3, r4)

print("Plus basse : " .. plusBasse)
print("Plus haute : " .. plusHaute)
print("Amplitude : " .. plusHaute - plusBasse)
print("Distance à zéro de la plus basse : " .. math.abs(plusBasse))
