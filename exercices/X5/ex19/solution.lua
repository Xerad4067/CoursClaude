-- Fichier : planning.lua
-- Fusionne deux listes DÉJÀ triées en une seule liste triée.
local function fusionner(a, b)
  local resultat = {}
  local i, j = 1, 1                              -- une « position de lecture » par liste
  while i <= #a and j <= #b do
    if a[i] <= b[j] then
      table.insert(resultat, a[i])
      i = i + 1
    else
      table.insert(resultat, b[j])
      j = j + 1
    end
  end
  while i <= #a do                               -- il reste des éléments dans a
    table.insert(resultat, a[i])
    i = i + 1
  end
  while j <= #b do                               -- il reste des éléments dans b
    table.insert(resultat, b[j])
    j = j + 1
  end
  return resultat
end

print("Planning complet : " .. table.concat(fusionner({ 15, 40, 55, 90 }, { 10, 40, 70 }), ", "))
print("Un seul taxi : " .. table.concat(fusionner({ 5, 8 }, {}), ", "))
