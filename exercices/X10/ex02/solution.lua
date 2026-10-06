-- Fichier : joueur.lua
local Joueur = {}
Joueur.__index = Joueur              -- « si une clé manque dans l'objet, cherche dans Joueur »

function Joueur.nouveau(nom, argent)
  local j = setmetatable({}, Joueur)
  j.nom = nom
  j.argent = argent or 100           -- 100 € si on ne donne pas de somme
  return j
end

function Joueur:gagner(somme)
  self.argent = self.argent + somme
end

local sam = Joueur.nouveau("Sam", 500)
local kim = Joueur.nouveau("Kim")
sam:gagner(50)                       -- seul Sam change
print(sam.nom .. " : " .. sam.argent)
print(kim.nom .. " : " .. kim.argent)
