-- Fichier : vrai-faux.lua
local x = 0
if x then print("0 est vrai en Lua") end
local vide = ""
if vide then print("La chaîne vide aussi") end
local rien = nil
if not rien then print("nil est faux") end
print(nil or "valeur par défaut")
print(false and "jamais affiché")
