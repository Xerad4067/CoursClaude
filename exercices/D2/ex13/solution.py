# Fichier : courses.py
import os   # pour effacer le fichier de test à la fin

FICHIER = "liste_courses.txt"


def sauvegarder(courses, chemin):
    with open(chemin, "w", encoding="utf-8") as fichier:   # "w" : écrire
        for article in courses:
            fichier.write(article + "\n")                  # un article par ligne


def charger(chemin):
    courses = []
    try:
        with open(chemin, encoding="utf-8") as fichier:    # lecture par défaut
            for ligne in fichier:
                courses.append(ligne.strip())              # strip : retire le \n
    except FileNotFoundError:
        print("Pas encore de liste : on repart de zéro.")
    return courses


courses = charger(FICHIER)        # le fichier n'existe pas encore
print(len(courses))
courses = ["pain", "eau", "lampe"]
sauvegarder(courses, FICHIER)
relues = charger(FICHIER)
print(relues)
print(relues == courses)
os.remove(FICHIER)                # ménage : on efface le fichier de test
