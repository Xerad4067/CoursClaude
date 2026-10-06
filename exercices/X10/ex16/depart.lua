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
