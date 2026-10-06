# Fichier : journal.py
import os

nom_fichier = "journal.txt"

with open(nom_fichier, "w", encoding="utf-8") as fichier:
    fichier.write("Serveur démarré\n")

# "a" : on AJOUTE à la fin, sans effacer ce qui existe déjà
with open(nom_fichier, "a", encoding="utf-8") as fichier:
    fichier.write("Sam s'est connecté\n")
    fichier.write("Kim s'est connectée\n")

with open(nom_fichier, "r", encoding="utf-8") as fichier:
    lignes = fichier.readlines()               # une liste : une ligne = un élément (avec son \n)

print("Lignes dans le journal :", len(lignes))
for ligne in lignes:
    print("-", ligne.strip())                  # strip enlève le \n de fin de ligne

os.remove(nom_fichier)
