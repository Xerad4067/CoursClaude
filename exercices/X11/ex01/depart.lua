-- Fichier : prime.lua
-- Outil : enlève « fichier.lua:12: » au début d'un message d'erreur.
local function sansPosition(message)
  return (tostring(message):gsub("^.-:%d+: ", ""))
end

local function calculerPrime(salaire, taux)
  return salaire * taux // 100
end
