-- Fichier : loyer.lua
local function loyerMensuel(surface, prixM2)
  local loyer = surface * prixM2
  return loyer                    -- sans return, la fonction renvoie nil
end

local loyer = loyerMensuel(40, 12)
print("Loyer : " .. loyer .. " €")
