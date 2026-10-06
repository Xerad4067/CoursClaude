-- Fichier : vehicule.lua
local joueurs = {
  { nom = "Sam", vehicule = { modele = "Sultan", vitesse = 160 } },
  { nom = "Kim", vehicule = { modele = "Scooter", vitesse = 45 } },
  { nom = "Alex" },                       -- Alex n'a pas de véhicule
}

for _, joueur in ipairs(joueurs) do
  print(joueur.nom .. " conduit un " .. joueur.vehicule.modele)
end
