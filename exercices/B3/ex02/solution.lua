-- Fichier : sante.lua
local sante = 35
local etat                -- déclarée avant le if pour être utilisable après
if sante >= 70 then
  etat = "En forme"
elseif sante >= 30 then
  etat = "Blessé"
else
  etat = "Critique"
end
print("Santé " .. sante .. " : " .. etat)
