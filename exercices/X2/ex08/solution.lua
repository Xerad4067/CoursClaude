-- Fichier : retrait.lua
local compteActif = true
local solde = 250
local montant = 300

if compteActif then
  -- Ce second if n'est examiné que si le compte est actif.
  if montant <= solde then
    solde = solde - montant
    print("Retrait accepté, il reste " .. solde .. " €")
  else
    print("Solde insuffisant : il manque " .. montant - solde .. " €")
  end
else
  print("Compte bloqué")
end
