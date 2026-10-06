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
