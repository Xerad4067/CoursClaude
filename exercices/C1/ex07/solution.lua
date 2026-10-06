-- Fichier : moyenne.lua
-- Prix moyen des véhicules d'une concession, arrondi vers le bas.
local function prixMoyen(prix)
  if #prix == 0 then
    return nil                          -- cas limite : liste vide, donc pas de moyenne
  end
  local somme = 0
  for _, p in ipairs(prix) do
    somme = somme + p
  end
  return somme // #prix
end

local concessions = {
  { nom = "Concession du port", prix = { 20000, 30000, 25000 } },
  { nom = "Concession vide", prix = {} },
}

for _, concession in ipairs(concessions) do
  local moyenne = prixMoyen(concession.prix)
  if moyenne == nil then
    print(concession.nom .. " : aucun véhicule en vente")
  else
    print(concession.nom .. " : prix moyen " .. moyenne .. " €")
  end
end
