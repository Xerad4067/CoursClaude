# Fichier : parc.py
class Vehicule:
    def __init__(self, plaque):
        self.plaque = plaque

    def decrire(self):
        return f"Véhicule {self.plaque}"


class Camion(Vehicule):
    def __init__(self, plaque, nb_essieux):
        super().__init__(plaque)  # la classe mère range la plaque
        self.nb_essieux = nb_essieux


class Voiture(Vehicule):
    def __init__(self, plaque, nb_places):
        super().__init__(plaque)
        self.nb_places = nb_places


camion = Camion("XY-987-ZT", 3)
voiture = Voiture("AB-123-CD", 5)

print(camion.plaque)
print(camion.nb_essieux)
print(voiture.plaque)
print(voiture.nb_places)
print(camion.decrire())
