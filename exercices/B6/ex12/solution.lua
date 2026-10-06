-- Fichier : bonus.lua
local function ajouterBonus(joueur)
  joueur.argent = joueur.argent + 100        -- modifie la table reçue : c'est la même que celle de l'appelant
end

local function ajouterBonusNombre(argent)
  argent = argent + 100                      -- ne modifie que la copie locale du nombre
  return argent
end

local function remplacer(joueur)
  joueur = { nom = "Inconnu", argent = 0 }   -- joueur désigne maintenant une AUTRE table
end

local sam = { nom = "Sam", argent = 500 }
ajouterBonus(sam)
print(sam.argent)

local solde = 500
ajouterBonusNombre(solde)
print(solde)
solde = ajouterBonusNombre(solde)
print(solde)

remplacer(sam)
print(sam.nom, sam.argent)
