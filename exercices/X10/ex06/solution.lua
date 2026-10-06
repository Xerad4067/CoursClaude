-- Fichier : position.lua
local Position = {}
Position.__index = Position

function Position.nouvelle(x, y)
  return setmetatable({ x = x, y = y }, Position)
end

-- Appelée pour a == b quand a et b sont deux tables.
function Position.__eq(a, b)
  return a.x == b.x and a.y == b.y
end

local p1 = Position.nouvelle(10, 20)
local p2 = Position.nouvelle(10, 20)
local p3 = Position.nouvelle(10, 25)

print(p1 == p2)                      -- même place : true grâce à __eq
print(p1 == p3)                      -- autre place : false
print(rawequal(p1, p2))              -- rawequal ignore __eq : ce ne sont pas la même table
