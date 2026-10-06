-- Fichier : codepostal.lua
local saisies = { "75001", "7500", "750011", "75O01", "ab123", "13006" }

for _, saisie in ipairs(saisies) do
  -- ^ début, 5 chiffres exactement, $ fin : sans ces ancres, « 750011 » passerait
  if string.match(saisie, "^%d%d%d%d%d$") then
    print(saisie .. " : valide")
  else
    print(saisie .. " : refusé")
  end
end
