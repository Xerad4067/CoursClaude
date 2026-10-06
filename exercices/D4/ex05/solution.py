# Fichier : joueur.py
class Joueur:
    def __init__(self, nom, argent):  # deux underscores de chaque côté
        self.nom = nom
        self.argent = argent

    def afficher(self):
        print(f"{self.nom} : {self.argent} €")


sam = Joueur("Sam", 1500)
sam.afficher()
