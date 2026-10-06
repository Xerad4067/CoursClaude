-- Fichier : coffre.lua
local coffre = { ouvert = false }

-- Ouvre le coffre, lance l'action, et REFERME TOUJOURS le coffre, même si l'action échoue.
local function avecCoffreOuvert(action)
  coffre.ouvert = true
  local ok, erreur = pcall(action)
  coffre.ouvert = false                          -- nettoyage : exécuté dans tous les cas
  if not ok then
    error(erreur, 0)                             -- on relance l'erreur pour que l'appelant la voie
  end
end

avecCoffreOuvert(function()
  print("action 1, coffre ouvert : " .. tostring(coffre.ouvert))
end)
print("après l'action 1, ouvert : " .. tostring(coffre.ouvert))

local ok, erreur = pcall(avecCoffreOuvert, function()
  print("action 2, coffre ouvert : " .. tostring(coffre.ouvert))
  error("outil cassé", 0)
end)
print(ok, erreur)
print("après l'action 2, ouvert : " .. tostring(coffre.ouvert))
