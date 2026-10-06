-- Fichier : identite.lua
local nom = "dupont"
local prenom = "ALEX"

-- Première lettre en majuscule + le reste en minuscules.
local premiere = string.upper(string.sub(prenom, 1, 1))     -- "A"
local reste = string.lower(string.sub(prenom, 2))           -- sans 3e argument : jusqu'à la fin -> "lex"
local prenomJoli = premiere .. reste

print(string.upper(nom) .. " " .. prenomJoli)
print(premiere .. "." .. string.upper(string.sub(nom, 1, 1)) .. ".")
