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
