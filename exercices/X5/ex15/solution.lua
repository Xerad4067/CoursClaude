-- Fichier : standard.lua
-- Chaque événement est une petite liste : { "arrive", "Sam" } ou { "sert" }.
local evenements = {
  { "arrive", "Sam" },
  { "arrive", "Kim" },
  { "sert" },
  { "arrive", "Alex" },
  { "sert" },
  { "sert" },
  { "sert" },
}

local file = {}                          -- file d'attente : premier arrivé, premier servi

local function etat()
  if #file == 0 then
    return "vide"
  end
  return table.concat(file, ", ")
end

for _, evenement in ipairs(evenements) do
  if evenement[1] == "arrive" then
    table.insert(file, evenement[2])     -- on se place à la fin de la file
    print(evenement[2] .. " arrive (file : " .. etat() .. ")")
  else
    local client = table.remove(file, 1) -- on sert le premier de la file
    if client then
      print("On sert " .. client .. " (file : " .. etat() .. ")")
    else
      print("Personne à servir")
    end
  end
end
