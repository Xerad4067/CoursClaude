-- Fichier : lecture.lua
local function afficherPrix(prix)
  print("Prix : " .. prix .. " €")
end

local function doublerPrix(prix)
  return prix * 2
end

afficherPrix(20)
doublerPrix(20)
local a = afficherPrix(30)
local b = doublerPrix(30)
print(a)
print(b)
print(doublerPrix(5) + 1)
