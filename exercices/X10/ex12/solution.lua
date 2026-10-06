-- Fichier : klaxon.lua
local Vehicule = {}
Vehicule.__index = Vehicule

function Vehicule.nouveau(nom)
  return setmetatable({ nom = nom }, Vehicule)
end

function Vehicule:klaxonner()
  return self.nom .. " : pouet"
end

function Vehicule:demarrer()
  return self.nom .. " démarre"
end

local Camion = setmetatable({}, { __index = Vehicule })
Camion.__index = Camion

function Camion:klaxonner()                 -- redéfinition de la méthode de la mère
  return self.nom .. " : POUET POUET"
end

local taxi = Vehicule.nouveau("Taxi")
local poidsLourd = setmetatable({ nom = "Poids lourd" }, Camion)

print(taxi:klaxonner())
print(poidsLourd:klaxonner())
print(poidsLourd:demarrer())
print(Vehicule.klaxonner(poidsLourd))
