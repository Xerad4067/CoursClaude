-- Fichier : inverser.lua
-- Renvoie une NOUVELLE liste avec les mêmes éléments (une vraie copie).
local function copier(liste)
  local copie = {}
  for _, element in ipairs(liste) do
    table.insert(copie, element)
  end
  return copie
end

-- Renvoie une NOUVELLE liste dans l'ordre inverse ; l'original ne bouge pas.
local function inverser(liste)
  local resultat = {}
  for i = #liste, 1, -1 do
    table.insert(resultat, liste[i])
  end
  return resultat
end

local trajet = { "Garage", "Parc", "Grotte", "Plage" }
local retour = inverser(trajet)
print("Aller : " .. table.concat(trajet, " > "))
print("Retour : " .. table.concat(retour, " > "))

local sauvegarde = copier(trajet)
table.insert(trajet, "Village")
print("Trajet : " .. #trajet .. " étapes, sauvegarde : " .. #sauvegarde .. " étapes")
