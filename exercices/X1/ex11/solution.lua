-- Fichier : podium.lua
local premier, deuxieme, troisieme = "Alex", "Kim", "Sam"

-- Lua calcule toute la partie droite AVANT de ranger les valeurs : pas besoin de variable temporaire.
premier, deuxieme, troisieme = deuxieme, troisieme, premier

print("1er : " .. premier)
print("2e : " .. deuxieme)
print("3e : " .. troisieme)
