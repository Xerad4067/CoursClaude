-- Fichier : paiement.lua
-- Outil : remplace « fichier.lua:12: » par « ligne 12 : » (même affichage chez tout le monde).
local function sansFichier(message)
  return (tostring(message):gsub("^.-:(%d+): ", "ligne %1 : "))
end

local function payerA(prix, argent)
  if prix > argent then
    error("Pas assez d'argent")          -- niveau 1 par défaut : Lua ajoute « fichier:ligne: »
  end
  return argent - prix
end

local function payerB(prix, argent)
  if prix > argent then
    error("Pas assez d'argent", 0)       -- niveau 0 : le message reste tel quel
  end
  return argent - prix
end

local _, a = pcall(payerA, 10, 5)
local _, b = pcall(payerB, 10, 5)
print(sansFichier(a))
print(b)
