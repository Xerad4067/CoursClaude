-- Fichier : noteur-readme.lua
-- Note un README sur 6 critères observables et dit ce qui manque.

local function contient(texte, morceau)
  return string.find(texte, morceau, 1, true) ~= nil
end

-- Découpe un texte en lignes.
local function lignesDe(texte)
  local lignes = {}
  for ligne in (texte .. "\n"):gmatch("(.-)\n") do
    lignes[#lignes + 1] = ligne
  end
  return lignes
end

-- Une description = la première ligne non vide après le titre, qui n'est pas un titre, avec 20 caractères ou plus.
local function aUneDescription(texte)
  local lignes = lignesDe(texte)
  for i = 2, #lignes do
    if lignes[i] ~= "" then
      return lignes[i]:sub(1, 1) ~= "#" and (utf8.len(lignes[i]) or 0) >= 20
    end
  end
  return false
end

local criteres = {
  { nom = "un titre",                       test = function(t) return t:sub(1, 2) == "# " end },
  { nom = "une description",                test = aUneDescription },
  { nom = "une section Installation",       test = function(t) return contient(t, "\n## Installation") end },
  { nom = "une section Utilisation avec un bloc de code",
    test = function(t) return contient(t, "\n## Utilisation") and contient(t, "```") end },
  { nom = "une licence",                    test = function(t) return contient(t, "\n## Licence") end },
  { nom = "aucune adresse e-mail",          test = function(t) return t:find("%S+@%S+%.%a+") == nil end },
}

local function noter(nom, texte)
  local manque = {}
  for _, critere in ipairs(criteres) do
    if not critere.test(texte) then
      manque[#manque + 1] = critere.nom
    end
  end
  print(nom .. " : " .. (#criteres - #manque) .. "/" .. #criteres)
  for _, nomCritere in ipairs(manque) do
    print("  manque : " .. nomCritere)
  end
end

local bon = [[
# Mini boutique en texte

Une supérette jouable dans le terminal : on achète avec des commandes de chat.

## Installation

1. Installe Lua 5.4.

## Utilisation

```text
lua boutique.lua
```

## Licence

Projet sous licence MIT.
]]

local presse = [[
# boutique
ça marche pas mal
## Utilisation
lua boutique.lua
Contact : sam.durand@exemple.fr
]]

noter("README bon", bon)
noter("README pressé", presse)
