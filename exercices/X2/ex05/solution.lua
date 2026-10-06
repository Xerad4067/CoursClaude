-- Fichier : lecture.lua
local meteo = "pluie"
local temperature = 8

if meteo == "soleil" then
  print("Pique-nique au parc")
elseif temperature < 10 then
  print("Reste à la maison")
elseif meteo == "pluie" then
  print("Prends un parapluie")
else
  print("Balade en ville")
end
print("Fin")
