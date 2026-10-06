-- Fichier : paiement.lua
-- Outil : remplace « fichier.lua:12: » par « ligne 12 : » (même affichage chez tout le monde).
local function sansFichier(message)
  return (tostring(message):gsub("^.-:(%d+): ", "ligne %1 : "))
end

local function payerA(prix, argent)
  if prix > argent then
    -- À toi : lève l'erreur « Pas assez d'argent » (appel simple, sans niveau)
  end
  return argent - prix
end

local function payerB(prix, argent)
  if prix > argent then
    -- À toi : lève la même erreur, avec le niveau 0
  end
  return argent - prix
end

local _, a = pcall(payerA, 10, 5)
local _, b = pcall(payerB, 10, 5)
print(sansFichier(a))
print(b)
