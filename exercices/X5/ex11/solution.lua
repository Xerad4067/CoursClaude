-- Fichier : classement.lua
local joueurs = {
  { nom = "Sam", score = 120 },
  { nom = "Kim", score = 340 },
  { nom = "Alex", score = 215 },
  { nom = "Noa", score = 90 },
}

-- La fonction de comparaison répond : « a doit-il passer avant b ? »
table.sort(joueurs, function(a, b)
  return a.score > b.score
end)

for rang, joueur in ipairs(joueurs) do
  print(rang .. ". " .. joueur.nom .. " (" .. joueur.score .. " points)")
end
