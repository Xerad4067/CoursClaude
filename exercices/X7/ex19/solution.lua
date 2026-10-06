-- Fichier : moderateur.lua
local messages = {
  { "Sam", "salut tout le monde" },
  { "Kim", "/give Sam 50" },
  { "Sam", "/msg Kim merci beaucoup" },
  { "Alex", "ce jeu est nul, quel idiot" },
  { "Kim", "/aide" },
  { "Sam", "/help" },
  { "Alex", "/teleport parc" },
  { "Lou", "/give Sam" },
}
local interdits = { nul = true, idiot = true }

-- Remplace chaque mot interdit par des étoiles (même longueur).
local function censurer(texte)
  return (string.gsub(texte, "%a+", function(mot)
    if interdits[string.lower(mot)] then
      return string.rep("*", #mot)
    end
    -- sans return : le mot reste tel quel
  end))
end

-- Table de commandes : nom -> fonction(auteur, reste de la ligne).
local commandes = {}

function commandes.give(auteur, reste)
  local cible, montant = string.match(reste, "^(%S+)%s+(%d+)$")
  if cible then
    print(auteur .. " donne " .. montant .. " € à " .. cible)
  else
    print("Usage : /give pseudo montant")
  end
end

function commandes.msg(auteur, reste)
  local cible, texte = string.match(reste, "^(%S+)%s+(.+)$")
  if cible then
    print("[MP] " .. auteur .. " -> " .. cible .. " : " .. texte)
  else
    print("Usage : /msg pseudo message")
  end
end

local function aide()
  print("Commandes : /give, /msg, /aide")
end
commandes.aide = aide
commandes.help = aide    -- deux noms pour la même fonction (les motifs n'ont pas de « ou »)

for _, m in ipairs(messages) do
  local auteur, texte = m[1], m[2]
  local nom, reste = string.match(texte, "^/(%S+)%s*(.*)$")
  if nom then
    local commande = commandes[string.lower(nom)]
    if commande then
      commande(auteur, reste)
    else
      print("Commande inconnue : /" .. nom)
    end
  else
    print("<" .. auteur .. "> " .. censurer(texte))
  end
end
