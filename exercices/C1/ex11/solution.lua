-- Fichier : billets.lua
-- Le distributeur ne donne que des billets de 50, 20 et 10 €.
-- Entrée : montant (entier). Sortie : le détail des billets, ou un refus avec la raison.
--
-- Décomposition :
--   1. vérifier le montant (positif ET multiple de 10)
--   2. pour chaque billet, du plus grand au plus petit :
--        combien de fois il rentre dans ce qui reste ? (division entière)
--        que reste-t-il à donner ? (reste de la division)
--   3. assembler le texte
local BILLETS = { 50, 20, 10 }               -- du plus grand au plus petit : l'ordre compte

local function repartir(montant)
  if montant <= 0 then
    return nil, "montant à zéro ou négatif"
  end
  if montant % 10 ~= 0 then
    return nil, "pas un multiple de 10"
  end
  local reste = montant
  local morceaux = {}
  for _, valeur in ipairs(BILLETS) do
    local nombre = reste // valeur             -- combien de billets de cette valeur
    if nombre > 0 then
      table.insert(morceaux, nombre .. " x " .. valeur .. " €")
    end
    reste = reste % valeur                     -- ce qu'il reste à distribuer
  end
  return table.concat(morceaux, ", ")
end

for _, montant in ipairs({ 130, 80, 40, 45, 0 }) do
  local detail, raison = repartir(montant)
  if detail then
    print(montant .. " € : " .. detail)
  else
    print(montant .. " € : refusé (" .. raison .. ")")
  end
end
