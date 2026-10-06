-- Fichier : main.lua (dans le même dossier que outils.lua)
local outils = require("outils")

local prix = 24000
local remise = outils.pourcentage(prix, 15)
print("Prix : " .. outils.formaterArgent(prix))
print("Remise de 15 % : " .. outils.formaterArgent(remise))
print("À payer : " .. outils.formaterArgent(prix - remise))
