-- Fichier : pseudo.lua
local pseudo = "SamTaxi42"
print(string.sub(pseudo, 1, 3))   -- du 1er au 3e caractère
print(string.sub(pseudo, 4, 7))   -- du 4e au 7e caractère
print(string.sub(pseudo, -2))     -- indice négatif : on compte depuis la fin, jusqu'à la fin
