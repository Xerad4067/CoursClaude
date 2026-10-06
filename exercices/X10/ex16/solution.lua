-- Fichier : voitures.lua
local Moteur = {}
Moteur.__index = Moteur

function Moteur.nouveau(puissance)
  return setmetatable({ puissance = puissance, allume = false }, Moteur)
end

function Moteur:demarrer()
  self.allume = true
end

function Moteur:etat()
  if self.allume then
    return "tourne"
  end
  return "arrêté"
end

local Voiture = {}
Voiture.__index = Voiture

function Voiture.nouvelle(nom, puissance)
  local v = setmetatable({}, Voiture)
  v.nom = nom
  v.moteur = Moteur.nouveau(puissance)       -- une voiture A UN moteur (composition)
  return v
end

function Voiture:demarrer()
  self.moteur:demarrer()                     -- on délègue le travail au moteur
end

function Voiture:rapport()
  return self.nom .. " (" .. self.moteur.puissance .. " ch) : moteur " .. self.moteur:etat()
end

local berline = Voiture.nouvelle("Berline", 110)
local pickup = Voiture.nouvelle("Pick-up", 150)
print(berline:rapport())
berline:demarrer()
print(berline:rapport())
print(pickup:rapport())
