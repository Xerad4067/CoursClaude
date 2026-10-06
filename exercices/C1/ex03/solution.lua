-- Fichier : peage.lua
-- Pseudo-code :
--   ENTRÉE : vehicule (un texte)
--   SI vehicule vaut « moto » ALORS prix ← 1
--   SINON SI vehicule vaut « voiture » ALORS prix ← 3
--   SINON SI vehicule vaut « camion » ALORS prix ← 8
--   SINON prix ← rien (véhicule inconnu)
--   FIN SI
--   SORTIE : prix
local function prixPeage(vehicule)
  local prix
  if vehicule == "moto" then
    prix = 1
  elseif vehicule == "voiture" then
    prix = 3
  elseif vehicule == "camion" then
    prix = 8
  else
    prix = nil                              -- « rien » en pseudo-code = nil en Lua
  end
  return prix
end

for _, vehicule in ipairs({ "moto", "voiture", "camion", "vélo" }) do
  local prix = prixPeage(vehicule)
  if prix == nil then
    print(vehicule .. " : véhicule inconnu")
  else
    print(vehicule .. " : " .. prix .. " €")
  end
end
