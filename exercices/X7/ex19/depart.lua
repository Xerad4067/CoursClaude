-- Fichier : moderateur.lua · code de départ
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

-- À toi : censurer(texte), la table commandes (give, msg, aide, help), puis la boucle sur les messages
