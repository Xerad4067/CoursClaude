-- Fichier : mots.lua
local phrase = "le taxi de Sam roule vers le parc"
local nombre = 0

-- gmatch renvoie chaque morceau qui correspond au motif, l'un après l'autre
for mot in string.gmatch(phrase, "%a+") do
  nombre = nombre + 1
  print(nombre .. ". " .. mot)
end
print("Total : " .. nombre .. " mots")
