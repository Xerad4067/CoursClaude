-- Fichier : doublons.lua
local function sansDoublons(liste)
  local vus = {}                  -- mémoire : les valeurs déjà rencontrées
  local resultat = {}
  for _, valeur in ipairs(liste) do
    if not vus[valeur] then
      vus[valeur] = true
      table.insert(resultat, valeur)
    end
  end
  return resultat
end

local plaques = { "AB", "CD", "AB", "EF", "CD", "AB", "GH" }
print("Avant : " .. table.concat(plaques, ", "))
print("Après : " .. table.concat(sansDoublons(plaques), ", "))
