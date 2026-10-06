# Fichier : tickets.py
numeros = [7, 42, 128, 1000]

for numero in numeros:
    texte = str(numero).zfill(3)     # zfill : complète avec des zéros à gauche
    print("Ticket n°" + texte)
