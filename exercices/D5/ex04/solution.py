# Fichier : parc.py
class Vehicule:
    def __init__(self, plaque):
        self.plaque = plaque

    def decrire(self):
        return f"Véhicule {self.plaque}"


class Camion(Vehicule):
    def __init__(self, plaque, nb_essieux):
        super().__init__(plaque)  # on confie la plaque à la classe mère
        self.nb_essieux = nb_essieux

    def decrire(self):
        return f"{super().decrire()} ({self.nb_essieux} essieux)"


camion = Camion("XY-987-ZT", 3)
print(camion.decrire())
