-- Fichier : epargne.lua
local Compte = {}
Compte.__index = Compte

function Compte.nouveau(titulaire, solde)
  local c = setmetatable({}, Compte)
  c.titulaire = titulaire
  c.solde = solde
  return c
end

function Compte:deposer(montant)
  self.solde = self.solde + montant
end

-- CompteEpargne est la classe fille : si une clé manque, on cherche dans Compte.
local CompteEpargne = setmetatable({}, { __index = Compte })
CompteEpargne.__index = CompteEpargne

function CompteEpargne.nouveau(titulaire, solde, taux)
  local c = setmetatable({}, CompteEpargne)
  c.titulaire = titulaire
  c.solde = solde
  c.taux = taux
  return c
end

function CompteEpargne:ajouterInterets()
  self.solde = self.solde + self.solde * self.taux // 100
end

local livret = CompteEpargne.nouveau("Sam", 1000, 5)
livret:deposer(200)                  -- méthode héritée de Compte
livret:ajouterInterets()             -- méthode propre à CompteEpargne
print(livret.solde)

local courant = Compte.nouveau("Kim", 300)
print(courant.ajouterInterets)       -- la mère ne connaît pas les méthodes de sa fille
