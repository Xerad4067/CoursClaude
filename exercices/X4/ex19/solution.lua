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

-- Compte tous les objets d'un contenant, y compris ceux des contenants qu'il renferme.
local function compter(contenant)
  local total = #contenant.objets
  for _, interieur in ipairs(contenant.contenants) do
    total = total + compter(interieur)          -- appel récursif sur chaque contenant
  end
  return total
end

-- Affiche l'arbre : 2 espaces de décalage par niveau.
local function afficher(contenant, niveau)
  local marge = string.rep("  ", niveau)
  print(marge .. contenant.nom)
  for _, objet in ipairs(contenant.objets) do
    print(marge .. "  - " .. objet)
  end
  for _, interieur in ipairs(contenant.contenants) do
    afficher(interieur, niveau + 1)
  end
end

afficher(sac, 0)
print("Total : " .. compter(sac) .. " objets")
