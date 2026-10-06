-- Fichier : generer-readme.lua
-- Fabrique le texte d'un README à partir d'une table qui décrit le projet.

local function genererReadme(projet)
  local lignes = {}
  local function ajouter(texte)
    lignes[#lignes + 1] = texte
  end

  ajouter("# " .. projet.titre)
  ajouter("")
  ajouter(projet.description)
  ajouter("")
  ajouter("## Installation")
  ajouter("")
  for i, etape in ipairs(projet.installation) do
    ajouter(i .. ". " .. etape)
  end
  ajouter("")
  ajouter("## Utilisation")
  ajouter("")
  ajouter("```text")
  ajouter(projet.commande)
  ajouter("```")
  ajouter("")
  ajouter("## Licence")
  ajouter("")
  ajouter("Projet sous licence " .. projet.licence .. ".")

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
