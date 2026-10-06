-- Fichier : serveur.lua
local serveur = {
  nom = "RP Horizon",
  joueurs = {
    { nom = "Sam", argent = 1500 },
    { nom = "Kim", argent = 900 },
  },
}
print(serveur.joueurs[2].nom)
for _, j in ipairs(serveur.joueurs) do
  print(j.nom .. " : " .. j.argent .. " €")
end
