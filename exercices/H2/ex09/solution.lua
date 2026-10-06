-- Fichier : issues-fermees.lua
-- Dit quelles issues (du même dépôt) une description de Pull Request fermera à la fusion.
-- Mots-clés reconnus par GitHub : close(s/d), fix(es/ed), resolve(s/d), éventuellement suivis de « : ».

local MOTS_CLES = {
  close = true, closes = true, closed = true,
  fix = true, fixes = true, fixed = true,
  resolve = true, resolves = true, resolved = true,
}

local function issuesFermees(description)
  local numeros = {}
  -- un mot, des « : » facultatifs, des espaces, puis # et un nombre
  for mot, numero in description:lower():gmatch("(%a+):?%s+#(%d+)") do
    if MOTS_CLES[mot] then
      numeros[#numeros + 1] = tonumber(numero)
    end
  end
  return numeros
end

local descriptions = {
  "Closes #12",
  "Corrige le prix négatif. Fixes: #7",
  "Resolves #10, resolves #123",
  "Voir aussi #5 pour le contexte",
  "Closes #3 et #4",
  "Ajoute le préfixe : prefixes #9 dans les noms",
}

for _, description in ipairs(descriptions) do
  local numeros = issuesFermees(description)
  if #numeros == 0 then
    print(description .. " -> ne ferme rien")
  else
    print(description .. " -> ferme " .. table.concat(numeros, ", "))
  end
end
