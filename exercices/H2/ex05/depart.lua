-- Fichier : diagnostiquer-issue.lua
local rubriques = {
  "## Étapes pour reproduire",
  "## Résultat attendu",
  "## Résultat obtenu",
  "## Version et environnement",
}

local function rubriquesManquantes(texte)
  local manquantes = {}
  -- ...ton code ici : ajoute dans `manquantes` chaque titre absent du texte...
  return manquantes
end

local issues = {
  {
    titre = "Le prix négatif est accepté à la caisse",
    texte = [[
## Étapes pour reproduire
1. Lancer lua boutique.lua
2. Taper /acheter pain -2

## Résultat attendu
Un refus : la quantité doit être positive.

## Résultat obtenu
Le solde de Sam augmente de 4 €.

## Version et environnement
Lua 5.4.6, Windows 11, commit 3f2a1c9.
]],
  },
  {
    titre = "ça marche pas",
    texte = "Le script plante.",
  },
  {
    titre = "L'inventaire n'est pas trié",
    texte = [[
## Étapes pour reproduire
Ajouter eau puis pain, puis afficher.

## Résultat obtenu
eau avant pain.
]],
  },
}

for _, issue in ipairs(issues) do
  local manquantes = rubriquesManquantes(issue.texte)
  if #manquantes == 0 then
    print(issue.titre .. " : complète")
  else
    print(issue.titre .. " : incomplète, manque " .. table.concat(manquantes, " ; "))
  end
end
