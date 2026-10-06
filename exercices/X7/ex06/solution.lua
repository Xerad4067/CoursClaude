-- Fichier : tableau.lua
local joueurs = {
  { nom = "Sam", argent = 1500 },
  { nom = "Kim", argent = 900 },
  { nom = "Alex", argent = 12000 },
}

for _, j in ipairs(joueurs) do
  -- %-8s : texte aligné à gauche sur 8 caractères ; %6d : entier aligné à droite sur 6
  print(string.format("%-8s|%6d €", j.nom, j.argent))
end
