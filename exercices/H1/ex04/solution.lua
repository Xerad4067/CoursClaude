-- Fichier : nom-depot.lua
-- Transforme un titre de projet en nom de dépôt : minuscules, sans accents, mots séparés par des tirets.

-- string.lower ne change pas les lettres accentuées : on les remplace une par une.
local sansAccent = {
  ["à"] = "a", ["â"] = "a", ["ä"] = "a",
  ["é"] = "e", ["è"] = "e", ["ê"] = "e", ["ë"] = "e",
  ["î"] = "i", ["ï"] = "i",
  ["ô"] = "o", ["ö"] = "o",
  ["ù"] = "u", ["û"] = "u", ["ü"] = "u",
  ["ç"] = "c",
  ["À"] = "a", ["É"] = "e", ["È"] = "e", ["Ê"] = "e",
  ["Î"] = "i", ["Ô"] = "o", ["Ù"] = "u", ["Ç"] = "c",
}

local function nomDepot(titre)
  local nom = titre:lower()
  for avec, sans in pairs(sansAccent) do
    nom = nom:gsub(avec, sans)         -- gsub renvoie 2 valeurs : on garde seulement la première
  end
  nom = nom:gsub("[^%w]+", "-")        -- toute suite de caractères qui ne sont pas lettre/chiffre devient un tiret
  nom = nom:gsub("^%-+", ""):gsub("%-+$", "")  -- on retire les tirets au début et à la fin
  return nom
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
