-- Fichier : sacs.lua
local sac = {
  nom = "Sac à dos",
  objets = { "pain", "eau" },
  contenants = {
    { nom = "Trousse", objets = { "bandage", "pince" }, contenants = {} },
    {
      nom = "Caisse à outils",
      objets = { "clé", "marteau", "tournevis" },
      contenants = {
        { nom = "Boîte de vis", objets = { "vis", "écrou" }, contenants = {} },
      },
    },
  },
}

-- Écris ici compter(contenant) et afficher(contenant, niveau),
-- puis affiche le sac et le total.
