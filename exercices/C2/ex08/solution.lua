-- Fichier : atelier.lua
-- L'atelier de réparation prépare le rapport du parc de véhicules.

-- Étape 1 : la liste de départ.
local function creerParc()
  return {
    { nom = "Sultan",   etat = "ok",    valeur = 45000 },
    { nom = "Taxi",     etat = "panne", valeur = 18000 },
    { nom = "Camion",   etat = "panne", valeur = 60000 },
    { nom = "Scooter",  etat = "ok",    valeur = 3000 },
    { nom = "Bus",      etat = "panne", valeur = 70000 },
    { nom = "Tracteur", etat = "ok",    valeur = 25000 },
  }
end

-- Étape 2 : les véhicules en panne partent à la casse.
local function retirerEnPanne(parc)
  for i = #parc, 1, -1 do                  -- on parcourt à l'envers : retirer ne décale pas les cases à venir
    if parc[i].etat == "panne" then
      table.remove(parc, i)
    end
  end
end

-- Étape 3 : du plus précieux au moins précieux.
local function trierParValeur(parc)
  table.sort(parc, function(a, b) return a.valeur > b.valeur end)
end

-- Étape 4 : la valeur totale du parc.
local function valeurTotale(parc)
  local total = 0
  for _, vehicule in ipairs(parc) do
    total = total + vehicule.valeur
  end
  return total
end

-- Étape 5 : le rapport.
local parc = creerParc()
retirerEnPanne(parc)
trierParValeur(parc)

local morceaux = {}
for _, vehicule in ipairs(parc) do
  table.insert(morceaux, vehicule.nom .. " (" .. vehicule.valeur .. " €)")
end
print("Parc après tri : " .. table.concat(morceaux, ", "))
print("Valeur totale : " .. valeurTotale(parc) .. " €")
