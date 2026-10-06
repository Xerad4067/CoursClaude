-- Fichier : bissextile.lua
local annee = 1900

-- Divisible par 4, sauf les multiples de 100, sauf les multiples de 400.
local bissextile = (annee % 4 == 0 and annee % 100 ~= 0) or annee % 400 == 0

if bissextile then
  print(annee .. " est bissextile")
else
  print(annee .. " n'est pas bissextile")
end
