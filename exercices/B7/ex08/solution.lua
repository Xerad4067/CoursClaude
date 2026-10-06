-- Fichier : main.lua (dans le même dossier que metiers.lua)
local metiers = require("metiers")

print("=== Annuaire des métiers ===")
for _, fiche in ipairs(metiers.lister()) do
  print(string.format("%s : %d €/h, véhicule %s", fiche.nom, fiche.salaireHoraire, fiche.vehicule))
end

for _, recherche in ipairs({ "taxi", "pilote" }) do
  local fiche = metiers.trouver(recherche)
  if fiche then
    print("Trouvé : " .. fiche.nom .. " (" .. fiche.vehicule .. ")")
  else
    print("Métier inconnu : " .. recherche)
  end
end
