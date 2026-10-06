-- Fichier : partage.lua
local function partager(pieces, joueurs)
  if joueurs == 0 then
    error("personne à qui partager", 0)
  end
  return pieces // joueurs, pieces % joueurs     -- deux valeurs de retour
end

print(pcall(partager, 17, 5))                    -- true, puis les DEUX résultats
print(pcall(partager, 17, 0))                    -- false, puis le message
