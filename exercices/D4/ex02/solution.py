# Fichier : vehicule.py
class Vehicule:
    """Un véhicule du serveur roleplay."""

    def __init__(self, nom, vitesse):
        self.nom = nom
        self.vitesse = vitesse

    def decrire(self):
        return f"{self.nom} roule à {self.vitesse} km/h"

    def accelerer(self, gain):
        self.vitesse = self.vitesse + gain


taxi = Vehicule("Taxi", 120)
moto = Vehicule("Moto", 160)
taxi.accelerer(20)  # seul le taxi change : chaque objet a sa propre vitesse

print(taxi.decrire())
print(moto.decrire())
