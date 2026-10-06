# Fichier : inventaire.py
class Inventaire:
    """Un inventaire : à chaque objet correspond une quantité."""

    def __init__(self):
        self._objets = {}  # dictionnaire objet -> quantité

    def ajouter(self, objet, quantite):
        self._objets[objet] = self._objets.get(objet, 0) + quantite

    def retirer(self, objet, quantite):
        """Renvoie True si le retrait est possible, False sinon."""
        if self._objets.get(objet, 0) < quantite:
            return False
        self._objets[objet] = self._objets[objet] - quantite
        if self._objets[objet] == 0:
            del self._objets[objet]  # plus aucun : on retire la ligne
        return True

    def afficher(self):
        if not self._objets:
            print("(inventaire vide)")
        for objet in sorted(self._objets):  # ordre alphabétique
            print(f"- {objet} : {self._objets[objet]}")


inventaire = Inventaire()
while True:
    ligne = input("> ")
    if ligne == "fin":
        break
    mots = ligne.split()  # "ajouter pain 3" -> ["ajouter", "pain", "3"]
    if mots[0] == "ajouter":
        inventaire.ajouter(mots[1], int(mots[2]))
    elif mots[0] == "retirer":
        if not inventaire.retirer(mots[1], int(mots[2])):
            print(f"Refusé : pas assez de {mots[1]}")
    elif mots[0] == "afficher":
        inventaire.afficher()
    else:
        print("Commande inconnue :", mots[0])
