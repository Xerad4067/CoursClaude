-- Fichier : commande.lua
local message = "/donner Sam 250"
local cmd, cible, montant = string.match(message, "^/(%a+) (%a+) (%d+)$")
print(cmd, cible, montant)
print(string.find("Bienvenue au garage", "garage"))   -- position de début et de fin
print(string.gsub("bonjour", "o", "0"))               -- texte modifié et nombre de remplacements
