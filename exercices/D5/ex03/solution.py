# Fichier : parc.py
class Vehicule:
    def __init__(self, plaque):
        self.plaque = plaque

    def decrire(self):
        return f"Véhicule {self.plaque}"


class Voiture(Vehicule):
    def decrire(self):  # redéfinition : REMPLACE celle de Vehicule
        return f"Voiture {self.plaque}"


class Moto(Vehicule):
    def decrire(self):  # redéfinition : COMPLÈTE celle de Vehicule
        return super().decrire() + " (casque obligatoire)"


class Camion(Vehicule):
    pass  # pas de redéfinition : il garde decrire de Vehicule


print(Voiture("AB-123-CD").decrire())
print(Moto("MM-001-AA").decrire())
print(Camion("XY-987-ZT").decrire())
