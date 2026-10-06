-- Fichier : loyer.lua
local function loyerMensuel(surface, prixM2)
  local loyer = surface * prixM2
end

local loyer = loyerMensuel(40, 12)
print("Loyer : " .. loyer .. " €")
