-- Fichier : fiche.lua
local joueur = { nom = "Sam", argent = 1500, metier = "taxi" }
print(joueur.nom)
joueur.argent = joueur.argent + 100
print(joueur["argent"])     -- même chose que joueur.argent
joueur.permis = true        -- nouvelle clé
print(joueur.permis)
joueur.metier = nil         -- suppression de la clé
print(joueur.metier)
