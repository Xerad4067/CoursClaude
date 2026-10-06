-- Fichier : distributeur.lua
-- Pseudo-code remis dans le bon ordre :
--   ENTRÉE : solde, montant
--   SI montant est plus grand que solde ALORS
--       AFFICHER « Refusé : solde insuffisant »
--   SINON
--       nouveauSolde ← solde − montant
--       AFFICHER « Retrait de » montant « € : nouveau solde » nouveauSolde « € »
--   FIN SI
local function retirer(solde, montant)
  if montant > solde then
    print("Refusé : solde insuffisant")
    return solde                            -- rien ne change
  else
    local nouveauSolde = solde - montant
    print("Retrait de " .. montant .. " € : nouveau solde " .. nouveauSolde .. " €")
    return nouveauSolde
  end
end

local solde = 100
solde = retirer(solde, 30)
solde = retirer(solde, 100)    -- trop gros : refusé
solde = retirer(solde, 70)     -- cas limite : exactement le solde, accepté
