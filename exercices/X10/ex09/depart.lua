-- Fichier : sac.lua
local Sac = {}
Sac.__index = Sac

function Sac.nouveau()
  return setmetatable({ objets = {} }, Sac)
end

function Sac:ajouter(objet)
  table.insert(self.objets, objet)
end
