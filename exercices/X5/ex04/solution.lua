-- Fichier : annonce.lua
local function annoncer(joueurs)
  if #joueurs == 0 then
    return "Aucun joueur connecté"
  end
  -- table.concat colle les éléments avec un séparateur
  return "Joueurs connectés (" .. #joueurs .. ") : " .. table.concat(joueurs, ", ")
end

print(annoncer({ "Sam", "Kim", "Alex" }))
print(annoncer({}))
print(annoncer({ "Noa" }))
