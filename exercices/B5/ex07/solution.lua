-- Fichier : formater.lua
local function formaterArgent(montant)
  local texte = tostring(montant)
  local resultat = ""
  local compteur = 0
  -- On parcourt les chiffres de droite à gauche.
  for i = #texte, 1, -1 do
    resultat = string.sub(texte, i, i) .. resultat
    compteur = compteur + 1
    if compteur % 3 == 0 and i > 1 then
      resultat = " " .. resultat     -- une espace tous les 3 chiffres
    end
  end
  return resultat .. " €"
end

print(formaterArgent(42))
print(formaterArgent(1650))
print(formaterArgent(1500000))
