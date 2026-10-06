-- Fichier : acces.lua
local argent = 800
local aLePermis = true
local estAdmin = false
local estModo = true

if argent >= 500 and aLePermis then
  print("Location acceptée")
end
if estAdmin or estModo then
  print("Accès au panneau de modération")
end
if not estAdmin then
  print("Pas d'accès aux commandes admin")
end
