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
