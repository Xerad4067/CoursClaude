-- Fichier : accueil.lua
local role = "modo"
if role == "admin" then
  print("Bienvenue, chef : tu as tous les pouvoirs.")
elseif role == "modo" then
  print("Bienvenue, modérateur : tu peux sanctionner.")
else
  print("Bienvenue, joueur : amuse-toi bien !")
end
