-- Fichier : salaire-jour.lua
local function salaireJour(heures, tauxHoraire)
  return heures * tauxHoraire   -- on renvoie, on n'affiche pas
end

print(salaireJour(7, 12))
print(salaireJour(4, 15))
