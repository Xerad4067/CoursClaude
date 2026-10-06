-- Fichier : cloture.lua
local function perimetre(largeur, longueur)
  return 2 * (largeur + longueur)       -- on renvoie le résultat, on ne l'affiche pas
end

local PRIX_PAR_METRE = 8                -- une constante : écrite en MAJUSCULES

local petit = perimetre(12, 7)
print("Périmètre du petit parc : " .. petit .. " m")
print("Coût de la clôture : " .. petit * PRIX_PAR_METRE .. " €")

local grand = perimetre(20, 15)         -- même fonction, autres arguments
print("Périmètre du grand parc : " .. grand .. " m")
print("Coût de la clôture : " .. grand * PRIX_PAR_METRE .. " €")
