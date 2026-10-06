-- Fichier : montant.lua
local function lireMontant(texte)
  local montant = tonumber(texte)
  if montant == nil then
    return nil, "montant invalide : " .. texte    -- pas de plantage : nil + explication
  end
  if montant < 0 then
    return nil, "montant négatif : " .. texte
  end
  return montant
end

for _, saisie in ipairs({ "250", "abc", "-5" }) do
  local montant, erreur = lireMontant(saisie)
  if montant then
    print("OK : " .. montant)
  else
    print("Refusé : " .. erreur)
  end
end
