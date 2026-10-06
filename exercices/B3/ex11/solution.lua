-- Fichier : lecture.lua
local points = 120
if points >= 100 then
  print("Médaille d'or")
end
if points >= 50 then
  print("Médaille d'argent")
end
if points >= 10 then
  print("Médaille de bronze")
end
print("---")
if points >= 100 then
  print("Or")
elseif points >= 50 then
  print("Argent")
elseif points >= 10 then
  print("Bronze")
end
