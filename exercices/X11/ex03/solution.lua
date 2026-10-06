-- Fichier : age.lua
local function lireAge(texte)
  local age = assert(tonumber(texte), "âge invalide : " .. texte)   -- refuse nil et false
  return age
end

print(pcall(lireAge, "25"))
print(pcall(lireAge, "abc"))
