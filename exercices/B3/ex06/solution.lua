-- Fichier : tarif.lua
local age = 70
local tarif
if age < 12 then
  tarif = "gratuit"
elseif age < 26 then
  tarif = "2 €"
elseif age >= 65 then
  tarif = "1 €"
else
  tarif = "3 €"
end
print("Tarif : " .. tarif)
