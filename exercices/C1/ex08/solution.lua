-- Fichier : livraison.lua
-- Règle déduite des exemples (1 km -> 5 €, 2 km -> 5 €, 3 km -> 8 €, 4 km -> 11 €, 6 km -> 17 €) :
--   jusqu'à 2 km inclus : 5 € ; ensuite, 3 € de plus par kilomètre au-delà de 2 km.
local PRIX_DE_BASE = 5
local KM_INCLUS = 2
local PRIX_KM_EN_PLUS = 3

local function prixLivraison(km)
  if km <= KM_INCLUS then
    return PRIX_DE_BASE
  end
  return PRIX_DE_BASE + (km - KM_INCLUS) * PRIX_KM_EN_PLUS
end

-- Les cinq exemples de l'énoncé, puis deux prédictions vérifiées par le programme.
for _, km in ipairs({ 1, 2, 3, 4, 6, 10, 20 }) do
  print(km .. " km -> " .. prixLivraison(km) .. " €")
end
