-- Fichier : sac.lua
local Sac = {}
Sac.__index = Sac

function Sac.nouveau()
  return setmetatable({ objets = {} }, Sac)
end

function Sac:ajouter(objet)
  table.insert(self.objets, objet)
end

-- Appelée pour #sac : on renvoie le nombre d'objets rangés dans self.objets.
function Sac:__len()
  return #self.objets
end

local sac = Sac.nouveau()
sac:ajouter("pain")
sac:ajouter("eau")
sac:ajouter("lampe")
print(#sac)
sac:ajouter("corde")
print(#sac)
