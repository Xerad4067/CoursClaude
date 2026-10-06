-- Fichier : taxi.lua
-- ===== 1. L'énoncé en clair =====
-- Entrées : distance (km, entier), courses (courses déjà faites par le client),
--           pourcent (pourboire choisi, entier de 0 à 100)
-- Sorties : un reçu (tarif, remise, pourboire, total) OU un refus avec la raison
-- Règles  : tarif = 4 € de prise en charge + 2 € par km
--           remise de fidélité : 10 % du tarif (arrondie à l'euro inférieur) dès 5 courses faites
--           pourboire : pourcentage du prix APRÈS remise (arrondi à l'euro inférieur)
--           distance à 0 ou négative, ou pourboire hors de 0..100 : course refusée
--
-- ===== 2. Les sous-problèmes =====
--   tarifDeBase(distance)           -> le tarif sans remise
--   remiseFidelite(tarif, courses)  -> la remise en euros (0 si pas fidèle)
--   calculerPourboire(prix, pct)    -> le pourboire en euros
--   calculerCourse(...)             -> assemble le tout (ou refuse)
--   afficherRecu(...)               -> écrit le reçu
--
-- ===== 3. Pseudo-code de calculerCourse =====
--   SI distance ≤ 0 ALORS RENVOYER refus « distance invalide »
--   SI pourcent < 0 OU pourcent > 100 ALORS RENVOYER refus « pourboire invalide »
--   tarif    ← tarifDeBase(distance)
--   remise   ← remiseFidelite(tarif, courses)
--   apres    ← tarif − remise
--   pourboire ← calculerPourboire(apres, pourcent)
--   RENVOYER tarif, remise, pourboire, total = apres + pourboire

-- ===== 4. Le code =====
local PRISE_EN_CHARGE = 4
local PRIX_KM = 2
local COURSES_FIDELE = 5
local REMISE_POURCENT = 10

local function tarifDeBase(distance)
  return PRISE_EN_CHARGE + PRIX_KM * distance
end

local function remiseFidelite(tarif, courses)
  if courses >= COURSES_FIDELE then
    return tarif * REMISE_POURCENT // 100      -- // : arrondi à l'euro inférieur
  end
  return 0
end

local function calculerPourboire(prix, pourcent)
  return prix * pourcent // 100
end

-- Renvoie une table (le détail de la course) ou nil + la raison du refus.
local function calculerCourse(distance, courses, pourcent)
  if distance <= 0 then
    return nil, "distance invalide"
  end
  if pourcent < 0 or pourcent > 100 then
    return nil, "pourboire invalide"
  end
  local tarif = tarifDeBase(distance)
  local remise = remiseFidelite(tarif, courses)
  local apres = tarif - remise
  local pourboire = calculerPourboire(apres, pourcent)
  return { tarif = tarif, remise = remise, pourboire = pourboire, total = apres + pourboire }
end

local function afficherRecu(cas, course, raison)
  print("=== Course de " .. cas.client .. " ===")
  if course == nil then
    print("Course refusée : " .. raison)
    return
  end
  print("Distance : " .. cas.distance .. " km")
  print("Tarif : " .. course.tarif .. " €")
  if course.remise > 0 then
    print("Remise fidélité : -" .. course.remise .. " €")
  end
  print(string.format("Pourboire (%d %%) : %d €", cas.pourcent, course.pourboire))
  print("Total : " .. course.total .. " €")
end

-- ===== 5. Les cas de test, écrits AVANT le code (réponses calculées à la main) =====
local CAS = {
  { client = "Sam",  distance = 12, courses = 7,  pourcent = 15,  attendu = 29 },
  { client = "Kim",  distance = 5,  courses = 0,  pourcent = 0,   attendu = 14 },
  { client = "Alex", distance = 1,  courses = 5,  pourcent = 100, attendu = 12 },   -- 5 courses pile : fidèle, mais remise de 0
  { client = "Kim",  distance = 20, courses = 4,  pourcent = 10,  attendu = 48 },
  { client = "Sam",  distance = 0,  courses = 3,  pourcent = 10,  refus = "distance invalide" },
  { client = "Alex", distance = 8,  courses = 10, pourcent = 150, refus = "pourboire invalide" },
}

local reussis = 0
for _, cas in ipairs(CAS) do
  local course, raison = calculerCourse(cas.distance, cas.courses, cas.pourcent)
  afficherRecu(cas, course, raison)
  local bon
  if cas.refus then
    bon = (course == nil and raison == cas.refus)
  else
    bon = (course ~= nil and course.total == cas.attendu)
  end
  if bon then
    reussis = reussis + 1
  else
    print("ÉCHEC pour " .. cas.client .. " (" .. cas.distance .. " km)")
  end
end
print("Tests : " .. reussis .. "/" .. #CAS .. " réussis")
