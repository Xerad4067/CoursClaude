-- Fichier : placement.lua
local capital = 1000        -- argent placé au départ
local annees = 0            -- compteur d'années

-- On ne sait pas combien d'années il faudra : c'est un travail pour while.
while capital <= 2000 do
  capital = capital * 1.10  -- +10 % : on multiplie par 1,10
  annees = annees + 1
end

print(string.format("Après %d ans : %.2f €", annees, capital))
