-- Fichier : course.lua
local scores = { Sam = 42, Kim = 57, Alex = 35, Robin = 48 }

-- pairs n'a pas d'ordre : on range les noms dans une liste et on la trie.
local noms = {}
for nom in pairs(scores) do
  table.insert(noms, nom)
end
table.sort(noms)

local total = 0
local meilleur = noms[1]        -- on part du premier, puis on cherche mieux
local dernier = noms[1]
print("Scores (ordre alphabétique) :")
for _, nom in ipairs(noms) do
  print("  " .. nom .. " : " .. scores[nom])
  total = total + scores[nom]
  if scores[nom] > scores[meilleur] then
    meilleur = nom
  end
  if scores[nom] < scores[dernier] then
    dernier = nom
  end
end

print("Total : " .. total)
print(string.format("Moyenne : %.1f", total / #noms))   -- #noms : le nombre de joueurs
print("Meilleur : " .. meilleur .. " (" .. scores[meilleur] .. ")")
print("Dernier : " .. dernier .. " (" .. scores[dernier] .. ")")
