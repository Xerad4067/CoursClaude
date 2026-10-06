-- Fichier : poste.lua
-- Règle : entre au poste de police un policier OU le maire, à condition de ne pas être suspendu.
local estPolicier = true
local estMaire = false
local estSuspendu = true
-- and passe avant or : les parenthèses forcent « (policier ou maire) » d'abord.
print((estPolicier or estMaire) and not estSuspendu)   -- policier suspendu

estSuspendu = false
print((estPolicier or estMaire) and not estSuspendu)   -- policier en service

estPolicier = false
estMaire = true
print((estPolicier or estMaire) and not estSuspendu)   -- maire en service

estMaire = false
print((estPolicier or estMaire) and not estSuspendu)   -- simple civil
