-- Fichier : taxibus.lua
for i = 1, 15 do
  if i % 3 == 0 and i % 5 == 0 then   -- le cas le plus restrictif d'abord
    print("TaxiBus")
  elseif i % 3 == 0 then
    print("Taxi")
  elseif i % 5 == 0 then
    print("Bus")
  else
    print(i)
  end
end
