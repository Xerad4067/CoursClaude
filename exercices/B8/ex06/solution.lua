-- Fichier : compte-bancaire.lua
local CompteBancaire = {}
CompteBancaire.__index = CompteBancaire

function CompteBancaire.nouveau(titulaire, solde)
  local c = setmetatable({}, CompteBancaire)
  c.titulaire = titulaire
  c.solde = solde or 0
  return c
end

function CompteBancaire:deposer(montant)
  self.solde = self.solde + montant
end

function CompteBancaire:retirer(montant)
  if montant > self.solde then
    error(self.titulaire .. " : solde insuffisant", 0)
  end
  self.solde = self.solde - montant
end

function CompteBancaire:afficher()
  print(self.titulaire .. " : " .. self.solde .. " €")
end

local sam = CompteBancaire.nouveau("Sam", 100)
local kim = CompteBancaire.nouveau("Kim")
sam:deposer(50)
kim:deposer(300)
sam:afficher()
kim:afficher()
local ok, erreur = pcall(sam.retirer, sam, 500)   -- sam devient self
if not ok then
  print("Refusé -> " .. erreur)
end
sam:afficher()
