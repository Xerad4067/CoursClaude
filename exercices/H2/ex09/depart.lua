-- Fichier : issues-fermees.lua
local MOTS_CLES = {
  close = true, closes = true, closed = true,
  fix = true, fixes = true, fixed = true,
  resolve = true, resolves = true, resolved = true,
}

local function issuesFermees(description)
  local numeros = {}
  -- ...ton code ici : trouve chaque « mot-clé #nombre » et garde les nombres...
  return numeros
end

local descriptions = {
  "Closes #12",
  "Corrige le prix négatif. Fixes: #7",
  "Resolves #10, resolves #123",
  "Voir aussi #5 pour le contexte",
  "Closes #3 et #4",
  "Ajoute le préfixe : prefixes #9 dans les noms",
}

for _, description in ipairs(descriptions) do
  local numeros = issuesFermees(description)
  if #numeros == 0 then
    print(description .. " -> ne ferme rien")
  else
    print(description .. " -> ferme " .. table.concat(numeros, ", "))
  end
end
