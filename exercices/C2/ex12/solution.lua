-- Fichier : compte.lua
-- Outil fourni : enlève « fichier:ligne: » au début d'un message, pour ne garder que le texte.
local function sansPosition(message)
  return (message:gsub("^.-:%d+: ", ""))
end

local function creerCompte(titulaire, solde)
  assert(type(titulaire) == "string" and titulaire ~= "", "titulaire invalide")
  if type(solde) ~= "number" or solde < 0 then
    error("solde invalide", 2)        -- 2 : la faute est chez celui qui a appelé creerCompte
  end
  return { titulaire = titulaire, solde = solde }
end

local function retirer(compte, montant)
  assert(type(montant) == "number" and montant > 0, "montant invalide")
  if montant > compte.solde then
    error("solde insuffisant", 0)     -- 0 : message brut, sans fichier ni ligne
  end
  compte.solde = compte.solde - montant
end

-- Outil fourni : exécute une action protégée et raconte le résultat, sans jamais planter.
local function essayer(action)
  local ok, resultat = pcall(action)
  if ok then
    print("OK : " .. resultat)
  else
    print("Refusé : " .. sansPosition(resultat))
  end
end

local sam
essayer(function()
  sam = creerCompte("Sam", 100)
  return sam.titulaire .. " a " .. sam.solde .. " €"
end)
essayer(function() return creerCompte("", 50).solde end)
essayer(function() return creerCompte("Kim", -5).solde end)
essayer(function()
  retirer(sam, 30)
  return sam.titulaire .. " a " .. sam.solde .. " €"
end)
essayer(function() return retirer(sam, 500) end)
essayer(function() return retirer(sam, -10) end)
