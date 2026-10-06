# Fichier : joueur.py
class Joueur:
    def __init__(self, nom, argent):
        self.nom = nom
        self.argent = argent  # passe par le setter défini plus bas

    @property
    def argent(self):
        return self._argent

    @argent.setter
    def argent(self, valeur):
        if valeur < 0:
            raise ValueError("L'argent ne peut pas être négatif")
        self._argent = valeur


sam = Joueur("Sam", 1500)
sam.argent = sam.argent - 200
print(sam.argent)

try:
    sam.argent = -50
except ValueError as erreur:
    print("Refusé :", erreur)

print(sam.argent)

try:
    kim = Joueur("Kim", -5)  # le setter protège aussi la création
except ValueError as erreur:
    print("Création refusée :", erreur)
