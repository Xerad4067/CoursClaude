-- Fichier : liste.lua
local inventaire = { "pain", "eau", "lampe" }
for i, objet in ipairs(inventaire) do
  print(i .. ". " .. objet)
end
