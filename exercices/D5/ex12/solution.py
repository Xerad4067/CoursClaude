# Fichier : guichet.py
class Vehicule:
    def __init__(self, plaque):
        self.plaque = plaque

    def peage(self):
        # Méthode « abstraite » : chaque classe fille doit la redéfinir.
        raise NotImplementedError("peage() à définir dans la classe fille")


class Voiture(Vehicule):
    def peage(self):
        return 6


class Moto(Vehicule):
    def peage(self):
        return 2


# Une classe est une valeur : on peut la ranger dans un dictionnaire.
types = {"voiture": Voiture, "moto": Moto, "autre": Vehicule}

recette = 0
while True:
    saisie = input("Type (voiture, moto, autre, fin) : ")
    if saisie == "fin":
        break
    elif saisie not in types:
        print("Type inconnu :", saisie)
    else:
        plaque = input("Plaque : ")
        vehicule = types[saisie](plaque)  # types["moto"] est la classe Moto
        try:
            montant = vehicule.peage()
            print(f"{plaque} : {montant} €")
            recette = recette + montant
        except NotImplementedError as erreur:
            print("Erreur :", erreur)

print(f"Recette : {recette} €")
