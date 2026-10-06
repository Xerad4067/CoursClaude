-- Fichier : plaque.lua
local function plaqueValide(texte)
  -- %- : un vrai tiret (le - tout seul est un quantificateur, comme * ou +)
  return string.match(texte, "^%u%u%-%d%d%d%-%u%u$") ~= nil
end

for _, plaque in ipairs({ "AB-123-CD", "ZZ-999-AA", "ab-123-cd", "AB-12-CD" }) do
  if plaqueValide(plaque) then
    print(plaque .. " : valide")
  else
    print(plaque .. " : refusée")
  end
end
