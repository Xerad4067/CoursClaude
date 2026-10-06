-- Fichier : annuaire.lua
local serveur = { joueurs = { { nom = "Sam" }, { nom = "Kim" } } }
print("Premier joueur : " .. serveur.joueurs[1].nom)   -- la clé est « joueurs »
