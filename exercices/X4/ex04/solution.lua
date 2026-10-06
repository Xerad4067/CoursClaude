-- Fichier : presenter.lua
local function presenter(nom, metier)
  metier = metier or "citoyen"     -- valeur par défaut quand le métier n'est pas donné
  return nom .. " est " .. metier
end

print(presenter("Sam", "taxi"))
print(presenter("Kim"))
print(presenter("Alex", "mécanicien"))
