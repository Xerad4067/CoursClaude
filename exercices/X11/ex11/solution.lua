-- Fichier : assertions.lua
print(assert(10, "inutile"))
print(pcall(assert, false))
print(pcall(assert, nil, "message perso"))
print(pcall(assert, 1 == 2, "un égale deux ?"))
local ok, erreur = pcall(assert, false, { code = 7 })
print(type(erreur), erreur.code)
