-- Fichier : entree.lua
io.write("Nombre de places à réserver : ")
local places = io.read()

if places > 10 then
  print("Réservation de groupe")
else
  print("Réservation individuelle")
end
