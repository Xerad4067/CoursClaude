# Fichier : carnet.py
import os

nom_fichier = "carnet.txt"

# "w" : on ÉCRIT (le fichier est créé, ou vidé s'il existait)
with open(nom_fichier, "w", encoding="utf-8") as fichier:
    fichier.write("Sam : 1500 euros\n")      # write n'ajoute pas de retour à la ligne : on met \n
    fichier.write("Kim : 900 euros\n")

# "r" : on LIT
with open(nom_fichier, "r", encoding="utf-8") as fichier:
    contenu = fichier.read()

print(contenu)
print("Nombre de caractères :", len(contenu))

os.remove(nom_fichier)                        # nettoyage : on supprime le fichier de test
