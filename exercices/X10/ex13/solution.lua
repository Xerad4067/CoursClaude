-- Fichier : camion.lua
local Vehicule = {}
Vehicule.__index = Vehicule

function Vehicule.nouveau(nom, vitesse)
  local v = setmetatable({}, Vehicule)
  v.nom = nom
  v.vitesse = vitesse
  return v
end

function Vehicule:decrire()
  return self.nom .. " roule à " .. self.vitesse .. " km/h"
end

local Camion = setmetatable({}, { __index = Vehicule })
Camion.__index = Camion

function Camion.nouveau(nom, vitesse, charge)
  local c = Vehicule.nouveau(nom, vitesse)   -- la mère fabrique la base de l'objet
  c.charge = charge
  return setmetatable(c, Camion)             -- puis on le « change de classe »
end

function Camion:decrire()
  return Vehicule.decrire(self) .. ", charge " .. self.charge .. " t"
end

local taxi = Vehicule.nouveau("Taxi", 120)
local citerne = Camion.nouveau("Citerne", 80, 12)
print(taxi:decrire())
print(citerne:decrire())
