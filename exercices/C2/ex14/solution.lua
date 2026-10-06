-- Fichier : banque.lua
-- Une petite banque pour serveur roleplay, avec un journal des opérations.

local journal = {}      -- les lignes du journal, dans l'ordre
local numero = 0        -- numéro de la prochaine ligne

-- Ajoute une ligne au journal : [numéro] NIVEAU message
local function log(niveau, message)
  numero = numero + 1
  table.insert(journal, string.format("[%03d] %-6s %s", numero, niveau, message))
end

local comptes = {}      -- nom du titulaire -> { solde = ... }

-- Renvoie le compte du titulaire, ou lève une erreur s'il n'existe pas.
local function trouverCompte(titulaire)
  local compte = comptes[titulaire]
  if compte == nil then
    error("compte inconnu : " .. titulaire, 0)
  end
  return compte
end

local function ouvrirCompte(titulaire, solde)
  comptes[titulaire] = { solde = solde }
  log("INFO", "Compte ouvert : " .. titulaire .. " (" .. solde .. " €)")
end

local function deposer(titulaire, montant)
  local compte = trouverCompte(titulaire)
  compte.solde = compte.solde + montant              -- « montant », pas « montants »
  log("INFO", "Dépôt : " .. titulaire .. " +" .. montant .. " € (solde " .. compte.solde .. " €)")
end

-- Renvoie true si le retrait a eu lieu, false s'il est refusé.
local function retirer(titulaire, montant)
  local compte = trouverCompte(titulaire)
  if montant > compte.solde then                     -- « then » ajouté ; > et non >= : retirer tout le solde est permis
    log("WARN", "Retrait refusé : " .. titulaire .. " -" .. montant .. " € (solde " .. compte.solde .. " €)")
    return false
  end
  compte.solde = compte.solde - montant
  log("INFO", "Retrait : " .. titulaire .. " -" .. montant .. " € (solde " .. compte.solde .. " €)")
  return true                                        -- le return qui manquait
end

-- Un virement ne doit jamais perdre d'argent : on vérifie TOUT avant de bouger quoi que ce soit.
local function virer(source, destination, montant)
  trouverCompte(source)
  trouverCompte(destination)
  if retirer(source, montant) then
    deposer(destination, montant)
    log("INFO", "Virement : " .. source .. " -> " .. destination .. " " .. montant .. " €")
  end
end

-- Exécute une opération sans jamais arrêter le serveur : une erreur est écrite dans le journal.
local function operation(f, ...)
  local ok, erreur = pcall(f, ...)
  if not ok then
    log("ERREUR", erreur)
  end
end

ouvrirCompte("Sam", 200)
ouvrirCompte("Kim", 50)
operation(deposer, "Sam", 100)
operation(retirer, "Kim", 50)
operation(retirer, "Kim", 10)
operation(virer, "Sam", "Kim", 120)
operation(virer, "Sam", "Zoe", 10)
operation(retirer, "Max", 5)

print("=== Journal ===")
for _, ligne in ipairs(journal) do
  print(ligne)
end

print("=== Soldes finaux ===")
local noms = {}
for nom in pairs(comptes) do
  table.insert(noms, nom)
end
table.sort(noms)
for _, nom in ipairs(noms) do
  print(nom .. " : " .. comptes[nom].solde .. " €")
end
