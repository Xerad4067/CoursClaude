-- Fichier : badge.lua
local metier = "garagiste"
print(string.upper(metier))       -- GARAGISTE
print(#metier)                    -- 9 lettres
print(string.sub(metier, 1, 4))   -- du 1er au 4e caractère
print(string.rep("=", 10))        -- 10 fois "="
print(("taxi"):upper())           -- même chose que string.upper("taxi")
