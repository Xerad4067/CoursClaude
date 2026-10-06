local outils = {}

function outils.pourcentage(valeur, taux)
  return valeur * taux // 100
end

function outils.formaterArgent(montant)
  local texte = tostring(montant)
  local resultat = ""
  local compteur = 0
  for i = #texte, 1, -1 do
    resultat = string.sub(texte, i, i) .. resultat
    compteur = compteur + 1
    if compteur % 3 == 0 and i > 1 then
      resultat = " " .. resultat
    end
  end
  return resultat .. " €"
end

return outils
