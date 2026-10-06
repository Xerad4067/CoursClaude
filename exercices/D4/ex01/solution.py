# Fichier : joueur.py
class Joueur:
    """Un joueur du serveur roleplay."""

    def __init__(self, nom, argent):
        self.nom = nom        # attribut : le nom du joueur
        self.argent = argent  # attribut : son argent, en euros


sam = Joueur("Sam", 1500)  # on construit un objet (une instance)
kim = Joueur("Kim", 900)   # un deuxième objet, indépendant du premier

print(sam.nom)
print(sam.argent)
print(kim.nom)
print(kim.argent)
