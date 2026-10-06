-- Fichier : xor.lua
-- Le portail s'ouvre si EXACTEMENT un des deux boutons est pressé (OU exclusif).
local a, b = true, true
print(a, b, (a or b) and not (a and b))

a, b = true, false
print(a, b, (a or b) and not (a and b))

a, b = false, true
print(a, b, (a or b) and not (a and b))

a, b = false, false
print(a, b, (a or b) and not (a and b))
