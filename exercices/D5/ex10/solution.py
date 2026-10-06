# Fichier : boutique.py
class Produit:
    def __init__(self, nom, prix):
        self.nom = nom
        self.prix = prix

    def etiquette(self):
        return f"{self.nom} : {self.prix} €"


class Perissable(Produit):
    def __init__(self, nom, prix, jours):
        super().__init__(nom, prix)
        self.jours = jours

    def etiquette(self):
        return f"{super().etiquette()} (à consommer sous {self.jours} jours)"


class Boutique:
    def __init__(self, nom):
        self.nom = nom
        self.produits = []

    def ajouter(self, produit):
        self.produits.append(produit)

    def afficher(self):
        print(self.nom)
        for produit in self.produits:
            print(" -", produit.etiquette())


epicerie = Boutique("Épicerie du parc")
epicerie.ajouter(Produit("lampe", 12))
epicerie.ajouter(Perissable("pain", 2, 3))
epicerie.afficher()
