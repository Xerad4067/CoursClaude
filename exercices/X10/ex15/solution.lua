-- Fichier : comptes.lua
-- Version « classe » : tout est accessible.
local CompteClasse = {}
CompteClasse.__index = CompteClasse

function CompteClasse.nouveau(solde)
  return setmetatable({ solde = solde }, CompteClasse)
end

function CompteClasse:voirSolde()
  return self.solde
end

local a = CompteClasse.nouveau(100)
a.solde = 999999                             -- triche : ça marche...
print("Classe : " .. a:voirSolde())

-- Version « closure » : le solde est une variable locale, cachée dans la fonction.
local function creerCompte(soldeInitial)
  local solde = soldeInitial
  return {
    deposer = function(montant) solde = solde + montant end,
    voirSolde = function() return solde end,
  }
end

local b = creerCompte(100)
b.solde = 999999                             -- triche : ça ajoute juste un champ inutile
print("Closure : " .. b.voirSolde())
