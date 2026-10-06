-- Fichier : videur.lua
-- Règle : il faut avoir 18 ans ou plus ET (être VIP OU avoir une invitation).
local age = 16
local estVIP = false
local aInvitation = true

-- and passe avant or : sans parenthèses, Lua lisait (age >= 18 and estVIP) or aInvitation.
if age >= 18 and (estVIP or aInvitation) then
  print("Entrée autorisée")
else
  print("Entrée refusée")
end
