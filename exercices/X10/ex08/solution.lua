-- Fichier : duree.lua
local Duree = {}
Duree.__index = Duree

function Duree.nouvelle(heures, minutes)
  local d = setmetatable({}, Duree)
  d.minutes = heures * 60 + minutes   -- tout est gardé en minutes
  return d
end

function Duree:__tostring()
  return string.format("%dh%02d", self.minutes // 60, self.minutes % 60)
end

-- Appelée pour a + b : elle doit RENVOYER un nouvel objet, sans modifier a ni b.
function Duree.__add(a, b)
  local total = a.minutes + b.minutes
  return Duree.nouvelle(total // 60, total % 60)
end

local trajet = Duree.nouvelle(1, 45)
local livraison = Duree.nouvelle(0, 50)
print(trajet)
print(livraison)
print(trajet + livraison)
