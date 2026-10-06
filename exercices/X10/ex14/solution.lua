-- Fichier : tarifs.lua
local function lectureSeule(donnees)
  return setmetatable({}, {
    __index = donnees,                       -- la lecture va chercher dans la vraie table
    __newindex = function(_, cle)            -- toute écriture est refusée
      error("modification interdite : " .. cle, 0)
    end,
  })
end

local tarifs = lectureSeule({ base = 3, prixKm = 2 })

print(tarifs.base)
local ok, message = pcall(function() tarifs.base = 99 end)
print(ok, message)
print(tarifs.base)
