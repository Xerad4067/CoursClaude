-- Fichier : gardiens.lua
-- Renvoie une NOUVELLE liste où les k premiers éléments sont passés à la fin.
local function pivoter(liste, k)
  local n = #liste
  if n == 0 then
    return {}
  end
  k = k % n                                      -- ramène k entre 0 et n - 1
  local resultat = {}
  table.move(liste, k + 1, n, 1, resultat)       -- les éléments k+1 à n passent au début
  table.move(liste, 1, k, n - k + 1, resultat)   -- les k premiers vont à la fin
  return resultat
end

local gardiens = { "Sam", "Kim", "Alex", "Noa", "Lou" }
print(table.concat(pivoter(gardiens, 2), ", "))
print(table.concat(pivoter(gardiens, 7), ", "))
print(table.concat(pivoter(gardiens, 0), ", "))
print("Liste d'origine : " .. table.concat(gardiens, ", "))
