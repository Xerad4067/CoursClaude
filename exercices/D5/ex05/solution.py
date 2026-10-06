# Fichier : peage.py
class Vehicule:
    def __init__(self, plaque):
        self.plaque = plaque


class Voiture(Vehicule):
    def peage(self):
        return 6


class Camion(Vehicule):
    def __init__(self, plaque, nb_essieux):
        super().__init__(plaque)
        self.nb_essieux = nb_essieux

    def peage(self):
        return 8 + 4 * self.nb_essieux


class Moto(Vehicule):
    def peage(self):
        return 2


# Une seule liste, trois sortes d'objets.
parc = [Voiture("AB-123-CD"), Camion("XY-987-ZT", 3), Moto("MM-001-AA")]

total = 0
for vehicule in parc:
    montant = vehicule.peage()  # même appel : chaque objet répond à sa façon
    print(f"{vehicule.plaque} : {montant} €")
    total = total + montant
print(f"Total : {total} €")
