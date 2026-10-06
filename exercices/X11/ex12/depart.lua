-- Fichier : tests.lua
local function prixAvecRemise(prix, pourcent)
  return prix - prix * pourcent // 100
end
