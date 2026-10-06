-- Fichier : riches.lua
local joueurs = {
  { nom = "Sam", argent = 1500 },
  { nom = "Kim", argent = 900 },
  { nom = "Alex", argent = 2200 },
  { nom = "Noa", argent = 400 },
  { nom = "Lou", argent = 1000 },
}

-- On construit une NOUVELLE liste avec seulement les noms qui passent le test.
local riches = {}
for _, joueur in ipairs(joueurs) do
  if joueur.argent >= 1000 then
    table.insert(riches, joueur.nom)
  end
end

print("Riches : " .. table.concat(riches, ", "))
print("Nombre : " .. #riches)
