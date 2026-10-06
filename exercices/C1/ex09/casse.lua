-- Fichier : parc.lua
local vehicules = {
  { nom = "Sultan",  prix = 45000 },
  { nom = "Taxi",    prix = 18000 },
  { nom = "Camion",  prix = 60000 },
  { nom = "Scooter", prix = 3000 },
}

-- Renvoie le véhicule le plus cher de la liste.
local function plusCher(liste)
  local meilleur = liste[1]                   -- on part du premier véhicule
  for i = 2, #liste do
    if liste[i].prix < meilleur.prix then
      meilleur = liste[i]
    end
  end
  return meilleur
end

-- Additionne le prix de TOUS les véhicules de la liste.
local function valeurTotale(liste)
  local total = 0
  for i = 1, #liste - 1 do
    total = total + liste[i].prix
  end
  return total
end

local cher = plusCher(vehicules)
print("Le plus cher : " .. cher.nom .. " (" .. cher.prix .. " €)")
print("Valeur totale du parc : " .. valeurTotale(vehicules) .. " €")
