-- Fichier : butin.lua
local butin = 120
local nbJoueurs = 0

-- and s'arrête dès que la gauche est fausse : la division par zéro n'est jamais calculée.
if nbJoueurs > 0 and butin // nbJoueurs >= 50 then
  print("Chacun reçoit au moins 50 €")
else
  print("Partage impossible ou trop petit")
end

nbJoueurs = 2
if nbJoueurs > 0 and butin // nbJoueurs >= 50 then
  print("Chacun reçoit au moins 50 €")
else
  print("Partage impossible ou trop petit")
end
