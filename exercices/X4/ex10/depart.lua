-- Fichier : tarifs.lua
local function plein(prix)
  return prix
end

local function etudiant(prix)
  return prix * 70 // 100
end

local function enfant(prix)
  return prix // 2
end

-- Écris ici afficherTarif(nom, prix, regle), puis les trois appels.
