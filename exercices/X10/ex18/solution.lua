-- Fichier : concession.lua
local Vehicule = {}
Vehicule.__index = Vehicule

function Vehicule.nouveau(nom, prix)
  if prix <= 0 then
    error("prix invalide pour " .. nom, 0)
  end
  return setmetatable({ nom = nom, prix = prix }, Vehicule)
end

function Vehicule:__tostring()
  return self.nom .. " (" .. self.prix .. " €)"
end

function Vehicule.__lt(a, b)
  return a.prix < b.prix
end

-- Camion hérite de Vehicule : les métaméthodes ne s'héritent pas, on les recopie ou on les redéfinit.
local Camion = setmetatable({}, { __index = Vehicule })
Camion.__index = Camion
Camion.__lt = Vehicule.__lt

function Camion.nouveau(nom, prix, charge)
  local c = Vehicule.nouveau(nom, prix)
  c.charge = charge
  return setmetatable(c, Camion)
end

function Camion:__tostring()
  return self.nom .. " (" .. self.prix .. " €, charge " .. self.charge .. " t)"
end

local Concession = {}
Concession.__index = Concession

function Concession.nouvelle(nom)
  return setmetatable({ nom = nom, stock = {} }, Concession)
end

function Concession:ajouter(vehicule)
  table.insert(self.stock, vehicule)
end

function Concession:__len()
  return #self.stock
end

function Concession:plusCher()
  local meilleur = self.stock[1]
  for _, v in ipairs(self.stock) do
    if meilleur < v then
      meilleur = v
    end
  end
  return meilleur
end

local concession = Concession.nouvelle("Concession du Parc")
local commandes = {
  { Vehicule.nouveau, "Berline", 22000 },
  { Camion.nouveau, "Citerne", 45000, 12 },
  { Vehicule.nouveau, "Scooter", 3000 },
  { Vehicule.nouveau, "Épave", 0 },
  { Camion.nouveau, "Pick-up", 30000, 2 },
}

print("=== " .. concession.nom .. " ===")
for _, c in ipairs(commandes) do
  local ok, resultat = pcall(c[1], c[2], c[3], c[4])
  if ok then
    concession:ajouter(resultat)
  else
    print("Refusé : " .. resultat)
  end
end

table.sort(concession.stock)
print(#concession .. " véhicules")
for _, v in ipairs(concession.stock) do
  print(tostring(v))
end
print("Le plus cher : " .. tostring(concession:plusCher()))
