-- Fichier : lecture.lua
local function doubler(prix)
  return prix * 2
end

local function offrirBonus(joueur)
  joueur.argent = joueur.argent + 100
end

local function avecBonus(joueur)
  return { nom = joueur.nom, argent = joueur.argent + 100 }
end

local sam = { nom = "Sam", argent = 500 }
print(doubler(50))
print(doubler(50))
offrirBonus(sam)
print(sam.argent)
local kim = avecBonus(sam)
print(kim.argent)
print(sam.argent)
offrirBonus(sam)
print(sam.argent)
