-- Fichier : reduit.lua
local age = 30
local etudiant = false
local retraite = true

-- or : il suffit qu'UNE condition soit vraie.
if age < 12 or etudiant or retraite then
  print("Tarif réduit")
else
  print("Plein tarif")
end
