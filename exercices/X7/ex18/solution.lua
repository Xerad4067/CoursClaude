-- Fichier : scores.lua
local joueurs = {
  { nom = "Kim", score = 15 },
  { nom = "Alexandre", score = 980 },
  { nom = "Sam", score = 1250 },
}
-- tri du plus grand score au plus petit
table.sort(joueurs, function(a, b) return a.score > b.score end)

-- 1. largeur de la colonne des noms = longueur du plus long nom
local largeurNom = 0
for _, j in ipairs(joueurs) do
  if #j.nom > largeurNom then
    largeurNom = #j.nom
  end
end

-- 2. modèle de format construit avec .. (Lua n'accepte pas %*s)
local modele = "%-" .. largeurNom .. "s | %5d"
local largeurTotale = largeurNom + 3 + 5     -- nom + " | " + score sur 5

-- 3. titre centré : on le décale de la moitié de la place restante
local titre = "SCORES"
print(string.rep(" ", (largeurTotale - #titre) // 2) .. titre)
print(string.rep("-", largeurTotale))
for _, j in ipairs(joueurs) do
  print(string.format(modele, j.nom, j.score))
end
print(string.rep("-", largeurTotale))
