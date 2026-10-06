-- Fichier : verifier-readme.lua
-- Vérifie que les sections attendues sont présentes dans un README.
local function contient(texte, morceau)
  -- 4e argument à true : recherche de texte brut, les caractères comme ( ) . - ne sont plus « magiques »
  return string.find(texte, morceau, 1, true) ~= nil
end

local readme = [[
# Mini boutique en texte

Une supérette jouable dans le terminal.

## Installation

Installe Lua 5.4.

## Utilisation

lua boutique.lua

## Licence (MIT)

Voir le fichier LICENSE.
]]

local sections = { "# Mini boutique", "## Installation", "## Utilisation", "## Licence (MIT)" }
for _, section in ipairs(sections) do
  if contient(readme, section) then
    print("OK     " .. section)
  else
    print("MANQUE " .. section)
  end
end
