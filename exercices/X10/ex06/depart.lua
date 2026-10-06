-- Fichier : position.lua
local Position = {}
Position.__index = Position

function Position.nouvelle(x, y)
  return setmetatable({ x = x, y = y }, Position)
end
