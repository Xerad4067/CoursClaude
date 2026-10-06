-- Fichier : joueur.lua
local Joueur = {}
Joueur.__index = Joueur  -- « si une clé manque, cherche dans Joueur »

function Joueur.nouveau(nom, argent)  -- l'équivalent de __init__
  local j = setmetatable({}, Joueur)
  j.nom = nom
  j.argent = argent
  return j
end

function Joueur:gagner(montant)  -- le : ajoute self, comme le self de Python
  self.argent = self.argent + montant
end

function Joueur:depenser(montant)
  if montant > self.argent then
    print("Refusé : pas assez d'argent")
  else
    self.argent = self.argent - montant
    print(self.nom .. " dépense " .. montant .. " €")
  end
end

function Joueur:decrire()
  return self.nom .. " possède " .. self.argent .. " €"
end

local sam = Joueur.nouveau("Sam", 1500)
sam:gagner(100)
sam:depenser(5000)
sam:depenser(200)
print(sam:decrire())
