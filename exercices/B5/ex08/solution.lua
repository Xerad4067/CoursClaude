-- Fichier : paie.lua
local HEURES_NORMALES = 35
local MAJORATION = 1.25

-- Calcule : ne fait aucun affichage.
local function calculerSalaire(heures, tauxHoraire)
  local normales = math.min(heures, HEURES_NORMALES)
  local supplementaires = math.max(heures - HEURES_NORMALES, 0)
  return normales * tauxHoraire + supplementaires * tauxHoraire * MAJORATION
end

-- Affiche une ligne et renvoie le salaire pour pouvoir faire un total.
local function afficherFiche(nom, metier, heures, taux)
  local salaire = calculerSalaire(heures, taux)
  print(string.format("%s (%s) : %d h -> %.2f €", nom, metier, heures, salaire))
  return salaire
end

print("=== Fiches de paie ===")
local total = afficherFiche("Sam", "taxi", 35, 12)
  + afficherFiche("Kim", "mécanicienne", 40, 14)
  + afficherFiche("Alex", "livreur", 20, 11)
print(string.format("Total versé : %.2f €", total))
