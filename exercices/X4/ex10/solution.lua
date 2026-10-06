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

-- regle est une fonction : on l'appelle comme n'importe quelle autre.
local function afficherTarif(nom, prix, regle)
  print(nom .. " : " .. regle(prix) .. " €")
end

-- On donne le NOM de la fonction, sans parenthèses : on ne l'appelle pas encore.
afficherTarif("Plein tarif", 20, plein)
afficherTarif("Étudiant", 20, etudiant)
afficherTarif("Enfant", 20, enfant)
