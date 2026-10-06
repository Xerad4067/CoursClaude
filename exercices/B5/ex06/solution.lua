-- Fichier : remise.lua
local function appliquerRemise(prix, pourcentage)
  pourcentage = pourcentage or 10   -- valeur par défaut
  return prix - prix * pourcentage // 100
end

print(appliquerRemise(200))
print(appliquerRemise(200, 25))
