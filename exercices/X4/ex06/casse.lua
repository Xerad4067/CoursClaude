-- Fichier : amende.lua
local function calculerAmende(vitesse, limite)
  return (vitesse - limite) * 5       -- 5 € par km/h au-dessus de la limite
end

print("Sam : " .. calculerAmende(80, 50) .. " €")
print("Kim : " .. calculerAmende(50, 70) .. " €")
print("Alex : " .. calculerAmende(65, 50) .. " €")
