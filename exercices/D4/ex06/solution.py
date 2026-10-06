# Fichier : alias.py
class Joueur:
    def __init__(self, nom, argent):
        self.nom = nom
        self.argent = argent


sam = Joueur("Sam", 1500)
autre = sam               # un deuxième nom pour le MÊME objet
autre.argent = 0
print(sam.argent)

copie = Joueur("Sam", 0)  # un nouvel objet, créé séparément
print(sam == copie)
print(sam == autre)
print(sam is autre)
print(sam is copie)
