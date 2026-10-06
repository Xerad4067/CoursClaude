-- Fichier : vip.lua
local nbVip = 0                      -- le compteur, créé AVANT la boucle
for place = 1, 100 do
  if place % 7 == 0 then             -- reste 0 : la place est un multiple de 7
    nbVip = nbVip + 1                -- on compte une place VIP de plus
  end
end
print("Places VIP : " .. nbVip)
