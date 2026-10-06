-- Fichier : lecture.lua
local function descendre(niveau)
  if niveau == 0 then
    print("Fond de la grotte !")
    return
  end
  print("Je descends au niveau " .. niveau)
  descendre(niveau - 1)
  print("Je remonte du niveau " .. niveau)
end

descendre(3)
