-- Fichier : mention.lua
local note = 13.5
local mention

-- Du plus restrictif au plus large : le premier cas vrai gagne.
if note >= 16 then
  mention = "Très bien"
elseif note >= 14 then
  mention = "Bien"
elseif note >= 12 then
  mention = "Assez bien"
elseif note >= 10 then
  mention = "Passable"
else
  mention = "Insuffisant"
end

print("Note " .. note .. " : " .. mention)
