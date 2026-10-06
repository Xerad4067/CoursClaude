-- Fichier : casino.lua
local solde = 500

io.write("Ton âge : ")
local age = tonumber(io.read())

if age == nil then
  print("Âge invalide")
elseif age < 18 then
  print("Entrée interdite aux mineurs")
else
  -- Droit d'entrée selon l'âge : 5 € jusqu'à 25 ans, 3 € à partir de 65 ans, 10 € sinon.
  local droit = 10
  if age <= 25 then
    droit = 5
  elseif age >= 65 then
    droit = 3
  end
  solde = solde - droit
  print("Droit d'entrée : " .. droit .. " €")

  io.write("Ta mise : ")
  local mise = tonumber(io.read())
  if mise == nil or mise <= 0 then
    print("Mise invalide")
  elseif mise > solde then
    print("Fonds insuffisants")
  else
    print("Bonne chance ! Il te reste " .. solde - mise .. " €")
  end
end
