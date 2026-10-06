-- Fichier : nom-depot.lua
local function nomDepot(titre)
  -- ...ton code ici : minuscules, sans accents, tirets entre les mots...
  return titre
end

local titres = {
  "Mini Boutique en Lua",
  "Mon inventaire (v2)",
  "Café du Parc",
  "Éclairage de la grotte",
  "  Serveur  RP !! ",
}
for _, titre in ipairs(titres) do
  print(nomDepot(titre))
end
