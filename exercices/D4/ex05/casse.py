# Fichier : joueur.py
class Joueur:
    def __int__(self, nom, argent):
        self.nom = nom
        self.argent = argent

    def afficher(self):
        print(f"{self.nom} : {self.argent} €")


sam = Joueur("Sam", 1500)
sam.afficher()
