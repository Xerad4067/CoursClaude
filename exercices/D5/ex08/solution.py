# Fichier : joueur.py
class Inventaire:
    """Un inventaire simple : à chaque objet correspond une quantité."""

    def __init__(self):
        self._objets = {}

    def ajouter(self, objet, quantite):
        self._objets[objet] = self._objets.get(objet, 0) + quantite

    def quantite(self, objet):
        return self._objets.get(objet, 0)


class Joueur:
    def __init__(self, nom):
        self.nom = nom
        # Un Joueur A UN Inventaire (composition) : un par joueur.
        self.inventaire = Inventaire()

    def ramasser(self, objet, quantite=1):
        self.inventaire.ajouter(objet, quantite)  # il confie le travail
        print(f"{self.nom} ramasse {quantite} {objet}")


sam = Joueur("Sam")
kim = Joueur("Kim")
sam.ramasser("pain", 2)
sam.ramasser("lampe")
kim.ramasser("pain")

print(sam.inventaire.quantite("pain"))
print(kim.inventaire.quantite("pain"))
print(kim.inventaire.quantite("lampe"))
