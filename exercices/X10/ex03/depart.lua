-- Fichier : maison.lua
local Maison = {}
Maison.__index = Maison

function Maison.nouvelle(proprietaire, pieces)
  local m = setmetatable({}, Maison)
  m.proprietaire = proprietaire
  m.pieces = pieces
  return m
end
