-- Fichier : taxis.lua
-- Combien de taxis faut-il pour emmener un groupe ? (lis le code, ne l'exécute pas encore)
local function nombreDeTaxis(personnes)
  local taxis = 0
  local restantes = personnes
  while restantes > 0 do
    restantes = restantes - 4        -- un taxi emmène 4 personnes
    taxis = taxis + 1
  end
  return taxis
end

for _, groupe in ipairs({ 0, 1, 4, 5, 9 }) do
  print(groupe .. " personne(s) -> " .. nombreDeTaxis(groupe) .. " taxi(s)")
end
