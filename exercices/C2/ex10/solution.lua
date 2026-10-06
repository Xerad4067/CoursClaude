-- Fichier : colocation.lua
-- Programme écrit par quelqu'un d'autre : lis-le, ne l'exécute pas encore.
local depenses = {
  { qui = "Sam",  montant = 30 },
  { qui = "Kim",  montant = 10 },
  { qui = "Alex", montant = 20 },
  { qui = "Sam",  montant = 20 },
}

local function totalParPersonne(liste)
  local totaux = {}
  for _, d in ipairs(liste) do
    totaux[d.qui] = (totaux[d.qui] or 0) + d.montant
  end
  return totaux
end

local function noms(totaux)
  local liste = {}
  for nom in pairs(totaux) do
    table.insert(liste, nom)
  end
  table.sort(liste)
  return liste
end

local totaux = totalParPersonne(depenses)
local somme = 0
for _, nom in ipairs(noms(totaux)) do
  somme = somme + totaux[nom]
end
local part = somme // 3

for _, nom in ipairs(noms(totaux)) do
  local solde = totaux[nom] - part
  if solde > 0 then
    print(nom .. " doit recevoir " .. solde .. " €")
  elseif solde < 0 then
    print(nom .. " doit payer " .. -solde .. " €")
  else
    print(nom .. " est à l'équilibre")
  end
end
