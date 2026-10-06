-- Fichier : prime.lua
-- Outil : enlève « fichier.lua:12: » au début d'un message d'erreur.
local function sansPosition(message)
  return (tostring(message):gsub("^.-:%d+: ", ""))
end

local function calculerPrime(salaire, taux)
  return salaire * taux // 100
end

local ok, message = pcall(calculerPrime, 1500)   -- taux oublié : il vaut nil
print(ok)
print(sansPosition(message))
