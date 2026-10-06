-- Fichier : impot.lua
local revenu = 32000
local impot = 0

if revenu > 25000 then
  -- 10 % sur la tranche de 10 000 à 25 000 (15 000 €), puis 20 % sur ce qui dépasse 25 000.
  impot = (25000 - 10000) * 0.10 + (revenu - 25000) * 0.20
elseif revenu > 10000 then
  impot = (revenu - 10000) * 0.10
end

print(string.format("Impôt : %.2f €", impot))
