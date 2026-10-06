-- Fichier : salaires.lua
local salaires = { 1450, 1280, 1920, 1100, 1675 }

-- On part du premier élément, puis on compare avec tous les autres.
local plusBas = salaires[1]
local plusHaut = salaires[1]
for i = 2, #salaires do
  if salaires[i] < plusBas then
    plusBas = salaires[i]
  end
  if salaires[i] > plusHaut then
    plusHaut = salaires[i]
  end
end

print("Plus bas : " .. plusBas .. " €")
print("Plus haut : " .. plusHaut .. " €")
