# Fichier : joueur.py
class Inventaire:
    """Un inventaire simple : à chaque objet correspond une quantité."""

    def __init__(self):
        self._objets = {}

    def ajouter(self, objet, quantite):
        self._objets[objet] = self._objets.get(objet, 0) + quantite

    def quantite(self, objet):
        return self._objets.get(objet, 0)
