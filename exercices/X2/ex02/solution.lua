-- Fichier : moto.lua
local aLePermis = true
local argent = 250

-- La condition est elle-même une valeur (true ou false) : on peut la ranger dans une variable.
local peutLouer = aLePermis and argent >= 300
print(peutLouer)

if peutLouer then
  print("Location acceptée")
else
  print("Location refusée")
end
