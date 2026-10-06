-- Fichier : paie.lua
local employe = { nom = "Sam", metier = "taxi", heures = 40 }

local TAUX_PAR_METIER = { taxi = 12, livreur = 11, mecanicien = 14 }

local function tauxHoraire(metier)
  return TAUX_PAR_METIER[metier:lower()]
end

local function calculerSalaire(emp)
  local taux = tauxHoraire(emp.metier)      -- le champ s'appelle « metier », pas « job »
  return emp.heures * taux
end

local function afficherPaie(emp)
  print(emp.nom .. " touche " .. calculerSalaire(emp) .. " €")
end

afficherPaie(employe)
