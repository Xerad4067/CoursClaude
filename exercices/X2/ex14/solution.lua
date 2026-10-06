-- Fichier : entree.lua
io.write("Nombre de places à réserver : ")
local places = tonumber(io.read())    -- io.read() renvoie du TEXTE : on le convertit en nombre

if places > 10 then
  print("Réservation de groupe")
else
  print("Réservation individuelle")
end
