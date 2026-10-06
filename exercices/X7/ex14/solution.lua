-- Fichier : pseudos.lua
-- Renvoie true si le pseudo est valide, sinon false et la raison du refus.
local function verifierPseudo(pseudo)
  if #pseudo < 3 or #pseudo > 12 then
    return false, "longueur incorrecte"
  end
  if not string.match(pseudo, "^%a") then
    return false, "doit commencer par une lettre"
  end
  if not string.match(pseudo, "^[%w_]+$") then   -- lettres, chiffres ou _ uniquement
    return false, "caractère interdit"
  end
  return true
end

local pseudos = { "Sam_42", "Al", "Kim le taxi", "9lives", "Super_Long_Pseudo", "x-ray", "Alex_RP" }
for _, pseudo in ipairs(pseudos) do
  local ok, raison = verifierPseudo(pseudo)
  if ok then
    print(pseudo .. " : valide")
  else
    print(pseudo .. " : refusé (" .. raison .. ")")
  end
end
