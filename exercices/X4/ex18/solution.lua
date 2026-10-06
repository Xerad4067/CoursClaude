-- Fichier : caisses.lua
local coups = 0

-- Déplace n caisses du piquet « depart » vers « arrivee », en s'aidant du piquet « aide ».
local function deplacer(n, depart, arrivee, aide)
  if n == 0 then
    return                                    -- rien à déplacer
  end
  deplacer(n - 1, depart, aide, arrivee)      -- 1) dégager les n-1 caisses du dessus
  coups = coups + 1
  print("Caisse " .. n .. " : " .. depart .. " -> " .. arrivee)
  deplacer(n - 1, aide, arrivee, depart)      -- 2) les remettre par-dessus
end

deplacer(3, "A", "C", "B")
print("Total : " .. coups .. " déplacements")
