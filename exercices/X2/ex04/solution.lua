-- Fichier : maintenance.lua
local maintenance = false
local joueursConnectes = 12
local maxJoueurs = 32

-- not inverse un booléen ; and exige que les deux conditions soient vraies.
if not maintenance and joueursConnectes < maxJoueurs then
  print("Connexion autorisée")
else
  print("Connexion refusée")
end
