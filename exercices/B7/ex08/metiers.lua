local metiers = {}

-- Données privées du module : invisibles depuis main.lua.
local liste = {
  { nom = "taxi", salaireHoraire = 12, vehicule = "Taxi" },
  { nom = "mecanicien", salaireHoraire = 14, vehicule = "Dépanneuse" },
  { nom = "livreur", salaireHoraire = 11, vehicule = "Camionnette" },
}

function metiers.lister()
  return liste
end

function metiers.trouver(nom)
  for _, fiche in ipairs(liste) do
    if fiche.nom == nom then
      return fiche
    end
  end
  return nil
end

return metiers
