-- Fichier : vehicule.lua
local joueurs = {
  { nom = "Sam", vehicule = { modele = "Sultan", vitesse = 160 } },
  { nom = "Kim", vehicule = { modele = "Scooter", vitesse = 45 } },
  { nom = "Alex" },                       -- Alex n'a pas de véhicule
}

for _, joueur in ipairs(joueurs) do
  if joueur.vehicule ~= nil then          -- on vérifie AVANT de lire un champ de la sous-table
    print(joueur.nom .. " conduit un " .. joueur.vehicule.modele)
  else
    print(joueur.nom .. " va à pied")
  end
end
