-- Fichier : actions.lua
local function appliquerATous(liste, action)
  for _, element in ipairs(liste) do
    action(element)           -- on appelle la fonction reçue en paramètre
  end
end

appliquerATous({ "Sam", "Kim" }, function(nom)
  print("Salaire versé à " .. nom)
end)

local joueurs = { { nom = "Sam", argent = 1500 }, { nom = "Kim", argent = 2200 }, { nom = "Alex", argent = 300 } }
table.sort(joueurs, function(a, b) return a.argent > b.argent end)
appliquerATous(joueurs, function(j) print(j.nom, j.argent) end)
