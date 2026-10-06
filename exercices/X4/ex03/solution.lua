-- Fichier : bilan.lua
-- Renvoie deux valeurs : le bénéfice, puis un booléen « est-ce rentable ? ».
local function bilan(recettes, depenses)
  local benefice = recettes - depenses
  return benefice, benefice > 0
end

local benefice, rentable = bilan(500, 380)
print("Bénéfice : " .. benefice .. " €, rentable : " .. tostring(rentable))

local perte, rentable2 = bilan(200, 260)
print("Bénéfice : " .. perte .. " €, rentable : " .. tostring(rentable2))
