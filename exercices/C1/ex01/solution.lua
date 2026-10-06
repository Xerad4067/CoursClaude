-- Fichier : parking.lua
-- Les quatre questions :
--   Entrée  : heures (un nombre entier)
--   Sortie  : le prix à payer, en euros (un nombre entier)
--   Règles  : 1re heure = 2 €, puis 1 € par heure, plafond de 8 € par jour,
--             0 heure (ou moins) = le client est reparti sans se garer = 0 €
local PRIX_PREMIERE_HEURE = 2
local PRIX_HEURE_SUIVANTE = 1
local PLAFOND = 8

local function prixParking(heures)
  if heures <= 0 then
    return 0                                -- cas limite : rien à payer
  end
  local prix = PRIX_PREMIERE_HEURE + (heures - 1) * PRIX_HEURE_SUIVANTE
  return math.min(prix, PLAFOND)            -- jamais plus que le plafond
end

-- Les cas choisis AVANT d'écrire le code (réponses calculées à la main) :
-- 0 h -> 0 €, 1 h -> 2 €, 3 h -> 4 €, 7 h -> 8 €, 12 h -> 8 € (plafond)
for _, heures in ipairs({ 0, 1, 3, 7, 12 }) do
  print(heures .. " h -> " .. prixParking(heures) .. " €")
end
