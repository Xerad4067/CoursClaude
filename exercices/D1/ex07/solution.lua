-- Fichier : garage.lua
-- Traduction du programme Python : pas d'indentation significative mais then ... end,
-- elif devient elseif, != devient ~=, True devient true, len() devient #, f-string devient ..
local vehicules = 3
local places = 14
local age = 17
local permis = false

if age >= 18 and permis then
  print("Kim peut conduire")
elseif age >= 16 and not permis then
  print("Kim peut passer le permis")
else
  print("Kim doit attendre")
end

if vehicules ~= 0 then
  print(places // vehicules .. " places par véhicule, reste " .. places % vehicules)
end

local nom = "Kim"
print(nom .. " a " .. #nom .. " lettres")
