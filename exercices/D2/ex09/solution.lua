-- Fichier : panier.lua
-- Traduction du programme Python : le dictionnaire devient une table,
-- « in » devient « ~= nil », += devient total = total + ..., sorted() devient table.sort.
local prix = { pain = 2, eau = 1, lampe = 12 }
local panier = { "pain", "eau", "pain", "corde", "lampe" }

local total = 0
for _, article in ipairs(panier) do
  if prix[article] ~= nil then
    total = total + prix[article]
  else
    print(article .. " : inconnu")
  end
end
print("Total : " .. total .. " €")

local noms = {}
for nom in pairs(prix) do
  table.insert(noms, nom)
end
table.sort(noms)
for _, article in ipairs(noms) do
  print(article .. " coûte " .. prix[article] .. " €")
end
