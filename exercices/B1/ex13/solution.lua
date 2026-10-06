-- Fichier : tourniquet.lua
local joueurA = "moto"
local joueurB = "taxi"
local joueurC = "camion"
print("Avant :", joueurA, joueurB, joueurC)

-- Première rotation : A prend le véhicule de B, B celui de C, C celui de A.
-- Lua calcule toute la partie droite AVANT de ranger quoi que ce soit.
joueurA, joueurB, joueurC = joueurB, joueurC, joueurA
print("Après 1 :", joueurA, joueurB, joueurC)

-- Deuxième rotation : exactement la même instruction.
joueurA, joueurB, joueurC = joueurB, joueurC, joueurA
print("Après 2 :", joueurA, joueurB, joueurC)
