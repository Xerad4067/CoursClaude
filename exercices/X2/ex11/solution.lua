-- Fichier : pluriel.lua
local n = 0
local s = n > 1 and "s" or ""      -- condition and valeurSiVrai or valeurSiFaux
print(n .. " pièce" .. s)

n = 1
s = n > 1 and "s" or ""
print(n .. " pièce" .. s)

n = 3
s = n > 1 and "s" or ""
print(n .. " pièce" .. s)
