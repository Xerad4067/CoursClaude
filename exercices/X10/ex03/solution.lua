-- Fichier : maison.lua
local Maison = {}
Maison.__index = Maison

function Maison.nouvelle(proprietaire, pieces)
  local m = setmetatable({}, Maison)
  m.proprietaire = proprietaire
  m.pieces = pieces
  return m
end

-- Appelée par print() et tostring() pour fabriquer le texte de l'objet.
function Maison:__tostring()
  return "Maison de " .. self.proprietaire .. " (" .. self.pieces .. " pièces)"
end

local maison = Maison.nouvelle("Sam", 4)
print(maison)
print("Visite : " .. tostring(maison))   -- avec .., il faut passer par tostring
