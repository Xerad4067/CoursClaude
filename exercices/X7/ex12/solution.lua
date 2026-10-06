-- Fichier : slug.lua
local titre = "Garage de   Sam"

-- on passe en minuscules, puis chaque groupe d'espaces devient un seul tiret
local slug, nombre = string.gsub(string.lower(titre), "%s+", "-")
print(slug)
print(nombre .. " remplacements")
