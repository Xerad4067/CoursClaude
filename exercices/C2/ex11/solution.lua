-- Fichier : journal.lua
local DEBUG = false          -- passe à true pour voir les lignes de niveau DEBUG
local numero = 0             -- numéro de la prochaine ligne du journal

-- Écrit une ligne : [numéro] NIVEAU message
local function log(niveau, message)
  if niveau == "DEBUG" and not DEBUG then
    return                   -- les lignes DEBUG sont coupées d'un seul endroit
  end
  numero = numero + 1
  print(string.format("[%03d] %-5s %s", numero, niveau, message))
end

-- Un petit scénario : payer trois employés avec la caisse du bar.
local caisse = 100
local salaires = {
  { nom = "Sam", montant = 50 },
  { nom = "Kim", montant = 40 },
  { nom = "Alex", montant = 30 },
}

log("INFO", "Début de la paie (caisse : " .. caisse .. " €)")
for _, employe in ipairs(salaires) do
  log("DEBUG", "examen de " .. employe.nom .. " : salaire " .. employe.montant .. " €, caisse " .. caisse .. " €")
  if employe.montant <= caisse then
    caisse = caisse - employe.montant
    log("INFO", employe.nom .. " payé : " .. employe.montant .. " €")
  else
    log("WARN", "Caisse insuffisante pour " .. employe.nom .. " (reste " .. caisse .. " €, salaire " .. employe.montant .. " €)")
  end
end
log("INFO", "Fin de la paie (caisse : " .. caisse .. " €)")
