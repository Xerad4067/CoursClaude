# Fichier : notes.py
import os

with open("notes.txt", "w", encoding="utf-8") as fichier:
    fichier.write("Cours de Python : revoir les chaînes\n")
    fichier.write("TP à rendre vendredi\n")

with open("notes.txt", "r", encoding="utf-8") as fichier:
    for ligne in fichier:
        print(ligne.strip())

os.remove("notes.txt")
