-- Fichier : scores.lua · code de départ
local joueurs = {
  { nom = "Kim", score = 15 },
  { nom = "Alexandre", score = 980 },
  { nom = "Sam", score = 1250 },
}
-- tri du plus grand score au plus petit
table.sort(joueurs, function(a, b) return a.score > b.score end)

-- À toi : largeur du plus long nom, modèle de format, titre centré, lignes
