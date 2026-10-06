-- Fichier : nuit.lua
-- Entrées : heure de départ (entier de 0 à 23), prix de base de la course
-- Règle   : supplément de nuit de 3 € si le départ est entre 22 h (inclus) et 6 h (exclu)
-- Cas limites à vérifier : 21 h, 22 h, 23 h, 0 h, 5 h, 6 h (et une heure en plein jour)
local SUPPLEMENT_NUIT = 3
local DEBUT_NUIT = 22
local FIN_NUIT = 6

-- La nuit « passe minuit » : c'est le soir OU le petit matin (jamais les deux en même temps).
local function estDeNuit(heure)
  return heure >= DEBUT_NUIT or heure < FIN_NUIT
end

local function prixCourse(prixBase, heure)
  if estDeNuit(heure) then
    return prixBase + SUPPLEMENT_NUIT
  end
  return prixBase
end

for _, heure in ipairs({ 12, 21, 22, 23, 0, 5, 6 }) do
  print(string.format("départ à %2d h : %d €", heure, prixCourse(14, heure)))
end
