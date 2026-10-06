-- Fichier : generer-readme.lua
local function genererReadme(projet)
  local lignes = {}
  -- ...ton code ici : ajoute les lignes une par une dans `lignes`...
  return table.concat(lignes, "\n")
end

local boutique = {
  titre = "Mini boutique en texte",
  description = "Une supérette jouable dans le terminal : on achète avec des commandes de chat.",
  installation = {
    "Installe Lua 5.4.",
    "Clone le dépôt avec `git clone`.",
  },
  commande = "lua boutique.lua",
  licence = "MIT",
}

print(genererReadme(boutique))
