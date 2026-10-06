-- Fichier : amende.lua
local function calculerAmende(vitesse, limite)
  return (vitesse - limite) * 5       -- 5 € par km/h au-dessus de la limite
end

-- L'ordre des arguments compte : d'abord la vitesse, ensuite la limite.
print("Sam : " .. calculerAmende(80, 50) .. " €")
print("Kim : " .. calculerAmende(70, 50) .. " €")
print("Alex : " .. calculerAmende(65, 50) .. " €")
