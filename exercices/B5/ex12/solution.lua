-- Fichier : globale.lua
local function soin()
  vie = 100                   -- pas de local : c'est une variable GLOBALE
  return vie
end

local function degats()
  local vie = 10              -- avec local : une variable à part, qui disparaît à la fin
  return vie
end

print(vie)                    -- avant tout appel
print(soin())
print(vie)                    -- après soin()
print(degats())
print(vie)                    -- après degats()
