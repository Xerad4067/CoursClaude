-- Fichier : trace.lua
local function lireMoteur()
  error("moteur noyé", 0)
end

local function demarrer()
  lireMoteur()
end

local ok, trace = xpcall(demarrer, debug.traceback)
print(ok)
print(trace:match("^[^\n]*"))                              -- 1re ligne : le message d'origine
print(trace:find("stack traceback:", 1, true) ~= nil)      -- le rapport de pile est là
print(trace:find("lireMoteur", 1, true) ~= nil)            -- la fonction fautive y figure
