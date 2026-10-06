-- Fichier : inverser.lua
-- Inverse la liste « sur place » : on échange le premier avec le dernier,
-- puis le deuxième avec l'avant-dernier, jusqu'à se rejoindre au milieu.
local function inverser(liste)
  local debut, fin = 1, #liste
  while debut < fin do
    liste[debut], liste[fin] = liste[fin], liste[debut]    -- échange de deux cases
    debut = debut + 1
    fin = fin - 1
  end
end

local file = { "Sam", "Kim", "Alex", "Noa", "Lou" }
inverser(file)
print(table.concat(file, ", "))

local taxis = { "T1", "T2", "T3", "T4" }
inverser(taxis)
print(table.concat(taxis, ", "))
