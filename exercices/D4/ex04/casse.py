# Fichier : joueur.py
class Joueur:
    def __init__(self, nom, argent):
        self.nom = nom
        self.argent = argent

    def gagner(montant):
        self.argent = self.argent + montant

    def afficher(self):
        print(f"{self.nom} : {self.argent} €")


sam = Joueur("Sam", 1500)
sam.gagner(100)
sam.afficher()
