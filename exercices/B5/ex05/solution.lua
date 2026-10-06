-- Fichier : portee.lua
local x = 1
local function modifier()
  local x = 2               -- une AUTRE variable x, qui cache la première
  print("dans la fonction :", x)
end
modifier()
print("dehors :", x)

local compteur = 0
local function incrementer()
  compteur = compteur + 1   -- modifie la variable créée avant la fonction
end
incrementer()
incrementer()
print("compteur :", compteur)

do
  local secret = "caché"    -- n'existe que dans ce bloc
end
print(secret)
