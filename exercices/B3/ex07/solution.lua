-- Fichier : depot.lua
-- 1) Valeur par défaut avec or
local saisie = "abc"
local montant = tonumber(saisie) or 0
print(montant)

-- 2) Validation complète : on teste nil AVANT de comparer
local saisie2 = "120"
local montant2 = tonumber(saisie2)
if montant2 == nil then
  print("Saisie invalide")
elseif montant2 <= 0 then
  print("Le montant doit être positif")
else
  print("Dépôt de " .. montant2 .. " €")
end
