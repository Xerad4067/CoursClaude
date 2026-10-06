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

local function ouvrirCompte(titulaire, solde)
  comptes[titulaire] = { solde = solde }
  log("INFO", "Compte ouvert : " .. titulaire .. " (" .. solde .. " €)")
end

local function deposer(titulaire, montant)
  local compte = comptes[titulaire]
  compte.solde = compte.solde + montants
  log("INFO", "Dépôt : " .. titulaire .. " +" .. montant .. " € (solde " .. compte.solde .. " €)")
end

-- Renvoie true si le retrait a eu lieu, false s'il est refusé.
local function retirer(titulaire, montant)
  local compte = comptes[titulaire]
  if montant >= compte.solde
    log("WARN", "Retrait refusé : " .. titulaire .. " -" .. montant .. " € (solde " .. compte.solde .. " €)")
    return false
  end
  compte.solde = compte.solde - montant
  log("INFO", "Retrait : " .. titulaire .. " -" .. montant .. " € (solde " .. compte.solde .. " €)")
end

local function virer(source, destination, montant)
  if retirer(source, montant) then
    deposer(destination, montant)
    log("INFO", "Virement : " .. source .. " -> " .. destination .. " " .. montant .. " €")
  end
end

ouvrirCompte("Sam", 200)
ouvrirCompte("Kim", 50)
deposer("Sam", 100)
retirer("Kim", 50)
retirer("Kim", 10)
virer("Sam", "Kim", 120)
virer("Sam", "Zoe", 10)
retirer("Max", 5)

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
