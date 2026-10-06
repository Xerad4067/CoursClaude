-- tester.lua : vérifie automatiquement les solutions des exercices.
--
-- Utilisation (depuis la racine du dépôt) :   lua exercices/tester.lua
-- ou depuis le dossier exercices :            lua tester.lua
-- Pour ne tester qu'un module :               lua exercices/tester.lua B3
--
-- Pour chaque exercice (dossier exercices/<MODULE>/exNN/) :
--   * solution.lua : la solution, exécutée dans un environnement contrôlé ;
--   * attendu.txt  : ce que la solution doit afficher, au caractère près ;
--   * casse.lua    : (débogage) le code cassé, qui NE doit PAS donner le bon résultat ;
--   * config.lua   : (optionnel) entrées clavier simulées et nombres « aléatoires » imposés.

local base = (arg and arg[0] or ""):match("^(.*)[/\\][^/\\]*$") or "."
local filtre = arg and arg[1]

local function lireFichier(chemin)
  local f = io.open(chemin, "r")
  if not f then return nil end
  local contenu = f:read("a")
  f:close()
  return contenu
end

local function existe(chemin)
  local f = io.open(chemin, "r")
  if f then f:close() return true end
  return false
end

-- Normalise une sortie : fins de ligne Unix et pas de lignes vides à la fin.
local function normaliser(texte)
  return (texte:gsub("\r\n", "\n"):gsub("%s+$", ""))
end

-- Exécute un fichier Lua et renvoie (ok, sortie, erreur).
local function executer(chemin, dossier, config)
  config = config or {}
  local morceaux = {}
  local entrees = config.entrees or {}
  local iEntree = 0
  local aleatoires = config.aleatoire or {}
  local iAlea = 0

  local env = setmetatable({}, { __index = _G })
  env._G = env

  env.print = function(...)
    local n = select("#", ...)
    local t = {}
    for i = 1, n do t[i] = tostring((select(i, ...))) end
    morceaux[#morceaux + 1] = table.concat(t, "\t") .. "\n"
  end

  local fauxIo = setmetatable({}, { __index = io })
  fauxIo.write = function(...)
    for i = 1, select("#", ...) do
      morceaux[#morceaux + 1] = tostring((select(i, ...)))
    end
    return fauxIo
  end
  fauxIo.read = function(format)
    iEntree = iEntree + 1
    local valeur = entrees[iEntree]
    if valeur == nil then return nil end
    -- On affiche ce que « l'utilisateur » tape, comme dans un vrai terminal.
    if config.echo ~= false then morceaux[#morceaux + 1] = valeur .. "\n" end
    if format == "n" or format == "*n" then return tonumber(valeur) end
    return valeur
  end
  env.io = fauxIo

  local fauxMath = setmetatable({}, { __index = math })
  fauxMath.random = function(a, b)
    iAlea = iAlea + 1
    local v = aleatoires[iAlea]
    if v == nil then error("config.lua : pas assez de valeurs « aleatoire » prévues", 2) end
    return v
  end
  fauxMath.randomseed = function() end
  env.math = fauxMath

  -- require() cherche les modules dans le dossier de l'exercice, avec le même environnement.
  local charges = {}
  env.require = function(nom)
    if charges[nom] ~= nil then return charges[nom] end
    local cheminModule = dossier .. "/" .. nom:gsub("%.", "/") .. ".lua"
    local morceau, err = loadfile(cheminModule, "t", env)
    if not morceau then error("module '" .. nom .. "' introuvable : " .. tostring(err), 2) end
    local resultat = morceau(nom)
    if resultat == nil then resultat = true end
    charges[nom] = resultat
    return resultat
  end

  local morceau, errChargement = loadfile(chemin, "t", env)
  if not morceau then return false, table.concat(morceaux), errChargement end
  local ok, err = pcall(morceau)
  return ok, table.concat(morceaux), err
end

-- Affiche la première ligne qui diffère, pour aider à corriger.
local function premiereDifference(obtenu, attendu)
  local lo, la = {}, {}
  for l in (obtenu .. "\n"):gmatch("(.-)\n") do lo[#lo + 1] = l end
  for l in (attendu .. "\n"):gmatch("(.-)\n") do la[#la + 1] = l end
  for i = 1, math.max(#lo, #la) do
    if lo[i] ~= la[i] then
      return string.format("ligne %d\n      attendu : %s\n      obtenu  : %s", i, tostring(la[i]), tostring(lo[i]))
    end
  end
  return "différence invisible (espaces ?)"
end

local modules = {}
for lettre in ("ABCDEFGH"):gmatch(".") do
  for chiffre = 1, 9 do modules[#modules + 1] = lettre .. chiffre end
end

local total, reussis, cassesVerifies = 0, 0, 0
local echecs = {}

for _, module in ipairs(modules) do
  if not filtre or filtre == module then
    for n = 1, 30 do
      local nom = string.format("ex%02d", n)
      local dossier = base .. "/" .. module .. "/" .. nom
      local cheminSolution = dossier .. "/solution.lua"
      if existe(cheminSolution) then
        total = total + 1
        local id = module .. "/" .. nom
        local config = {}
        if existe(dossier .. "/config.lua") then config = dofile(dossier .. "/config.lua") end
        local attendu = lireFichier(dossier .. "/attendu.txt")
        local ok, sortie, err = executer(cheminSolution, dossier, config)
        local probleme
        if not ok then
          probleme = "erreur à l'exécution : " .. tostring(err)
        elseif attendu == nil then
          probleme = "attendu.txt manquant"
        elseif normaliser(sortie) ~= normaliser(attendu) then
          probleme = "sortie différente, " .. premiereDifference(normaliser(sortie), normaliser(attendu))
        end
        if not probleme and existe(dossier .. "/casse.lua") then
          local okC, sortieC = executer(dossier .. "/casse.lua", dossier, config)
          if okC and normaliser(sortieC) == normaliser(attendu) then
            probleme = "casse.lua donne le bon résultat : le code « cassé » n'est pas cassé"
          else
            cassesVerifies = cassesVerifies + 1
          end
        end
        if probleme then
          echecs[#echecs + 1] = id
          print("ÉCHEC " .. id .. " : " .. probleme)
        else
          reussis = reussis + 1
          print("OK    " .. id)
        end
      end
    end
  end
end

print(string.rep("-", 50))
print(string.format("Version : %s", _VERSION))
print(string.format("Exercices testés : %d · réussis : %d · échecs : %d", total, reussis, #echecs))
print(string.format("Codes « cassés » vérifiés comme vraiment cassés : %d", cassesVerifies))
if total == 0 then
  print("Aucun exercice trouvé : lance la commande depuis la racine du dépôt.")
  os.exit(1)
end
os.exit(#echecs == 0 and 0 or 1)
