-- Fichier : contenu.lua
local contenu = 1500
print(contenu, type(contenu))       -- un nombre
contenu = "mille cinq cents"        -- on remplace le contenu par du texte
print(contenu, type(contenu))
contenu = true                      -- puis par un booléen
print(contenu, type(contenu))
contenu = nil                       -- puis on vide la boîte
print(contenu, type(contenu))
