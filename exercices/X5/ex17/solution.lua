-- Fichier : tournoi.lua
local joueurs = {
  { nom = "Sam", score = 215 },
  { nom = "Kim", score = 340 },
  { nom = "Alex", score = 215 },
  { nom = "Noa", score = 340 },
  { nom = "Lou", score = 90 },
}

table.sort(joueurs, function(a, b)
  if a.score ~= b.score then
    return a.score > b.score           -- 1er critère : le meilleur score d'abord
  end
  return a.nom < b.nom                 -- 2e critère (égalité) : ordre alphabétique
end)

for rang, joueur in ipairs(joueurs) do
  print(rang .. ". " .. joueur.nom .. " - " .. joueur.score)
end
