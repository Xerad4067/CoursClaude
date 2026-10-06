-- Fichier : erreurs.lua
-- Outil : enlève « fichier.lua:12: » au début d'un message d'erreur.
local function sansPosition(message)
  return (tostring(message):gsub("^.-:%d+: ", ""))
end

-- Une « classe » d'erreur : on pourra la reconnaître avec getmetatable.
local ErreurAchat = {}
ErreurAchat.__index = ErreurAchat

function ErreurAchat.nouvelle(code, detail)
  return setmetatable({ code = code, detail = detail }, ErreurAchat)
end

function ErreurAchat:__tostring()
  return "[" .. self.code .. "] " .. self.detail
end

local function traiter(action)
  local ok, resultat = pcall(action)
  if ok then
    print("OK : " .. resultat)
  elseif getmetatable(resultat) == ErreurAchat then
    print("Refus d'achat : " .. tostring(resultat))   -- erreur prévue par le programme
  else
    print("Bogue : " .. sansPosition(resultat))       -- vraie erreur de programmation
  end
end

traiter(function() error(ErreurAchat.nouvelle("STOCK", "plus de lampe en stock")) end)
traiter(function() local prix; return prix * 2 end)
traiter(function() return 15 * 3 end)
