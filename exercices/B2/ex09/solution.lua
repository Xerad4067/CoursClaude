-- Fichier : course.lua
local duree = 135              -- durée de la course, en minutes
local heures = duree // 60     -- nombre d'heures complètes
local minutes = duree % 60     -- minutes qui restent
print(heures .. " h " .. minutes .. " min")
