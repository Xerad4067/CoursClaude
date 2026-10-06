-- Fichier : majuscules.lua
local phrase = "le grand parc de la ville"
local mots = {}

for mot in string.gmatch(phrase, "%a+") do
  -- première lettre en majuscule, puis le reste du mot (du 2e caractère à la fin)
  local titre = string.upper(string.sub(mot, 1, 1)) .. string.sub(mot, 2)
  table.insert(mots, titre)
end

print(table.concat(mots, " "))
