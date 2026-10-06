-- Fichier : age.lua
io.write("Ton âge : ")
local age = tonumber(io.read())       -- nil si ce n'est pas un nombre

if age == nil then                     -- on teste nil AVANT de comparer
  print("Ce n'est pas un nombre")
elseif age < 0 or age > 120 then
  print("Âge impossible")
else
  print("Âge enregistré : " .. age)
end
