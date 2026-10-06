local banque = {}

function banque.retirer(compte, montant)
  if type(montant) ~= "number" or montant <= 0 then
    error({ code = "MONTANT", detail = tostring(montant) })
  end
  if montant > compte.solde then
    error({ code = "SOLDE", manque = montant - compte.solde })
  end
  compte.solde = compte.solde - montant
  return compte.solde
end

return banque
