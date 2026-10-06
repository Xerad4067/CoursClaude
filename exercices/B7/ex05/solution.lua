-- Fichier : closures.lua
local function creerCompteur()
  local n = 0
  return function()
    n = n + 1
    return n
  end
end
local c1 = creerCompteur()
local c2 = creerCompteur()
print(c1())
print(c1())
print(c2())
print(c1())
