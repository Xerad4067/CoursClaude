-- Fichier : podium.lua
-- Score final = score - 10 points par pénalité.
local joueurs = {
  { nom = "Sam", score = 215, penalites = 1 },
  { nom = "Kim", score = 340, penalites = 0 },
  { nom = "Alex", score = 215, penalites = 1 },
  { nom = "Noa", score = 340, penalites = 3 },
  { nom = "Lou", score = 90, penalites = 5 },
  { nom = "Max", score = 120, penalites = 2 },
}

-- 1) Transformer + 2) filtrer : on garde les joueurs dont le score final est d'au moins 50.
local classes = {}
for _, joueur in ipairs(joueurs) do
  local final = joueur.score - 10 * joueur.penalites
  if final >= 50 then
    table.insert(classes, { nom = joueur.nom, final = final })
  else
    print("Disqualifié : " .. joueur.nom)
  end
end

-- 3) Trier : meilleur score final d'abord, ordre alphabétique en cas d'égalité.
table.sort(classes, function(a, b)
  if a.final ~= b.final then
    return a.final > b.final
  end
  return a.nom < b.nom
end)

-- 4) Afficher le podium : les trois premiers seulement.
for rang = 1, math.min(3, #classes) do
  print(rang .. ". " .. classes[rang].nom .. " : " .. classes[rang].final .. " points")
end
