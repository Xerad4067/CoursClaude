-- Fichier : parc.lua
-- 3 créneaux horaires (les lignes) x 4 zones du parc (les colonnes) : visiteurs comptés.
local visiteurs = {
  { 2, 0, 5, 1 },
  { 4, 3, 0, 2 },
  { 1, 1, 6, 0 },
}

-- Une case par colonne, toutes à 0 au départ.
local totauxColonnes = {}
for colonne = 1, 4 do
  totauxColonnes[colonne] = 0
end

for numero, ligne in ipairs(visiteurs) do        -- boucle extérieure : les lignes
  local totalLigne = 0
  for colonne, valeur in ipairs(ligne) do        -- boucle intérieure : les cases de la ligne
    totalLigne = totalLigne + valeur
    totauxColonnes[colonne] = totauxColonnes[colonne] + valeur
  end
  print("Ligne " .. numero .. " : " .. table.concat(ligne, " ") .. " (total " .. totalLigne .. ")")
end

print("Total colonnes : " .. table.concat(totauxColonnes, " "))
