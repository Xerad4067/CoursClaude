# Fichier : trier_le_parc.py
class Vehicule:
    def __init__(self, plaque):
        self.plaque = plaque


class Voiture(Vehicule):
    pass


class Taxi(Voiture):  # un Taxi EST UNE Voiture
    pass


class Camion(Vehicule):
    pass


class Moto(Vehicule):
    pass


parc = [
    Voiture("AB-123-CD"),
    Camion("XY-987-ZT"),
    Taxi("TX-001-ZZ"),
    Moto("MM-001-AA"),
    Camion("KL-555-MN"),
]

nb_camions = 0
nb_voitures = 0
plaques_motos = []
for vehicule in parc:
    if isinstance(vehicule, Camion):
        nb_camions = nb_camions + 1
    if isinstance(vehicule, Voiture):  # vrai aussi pour un Taxi
        nb_voitures = nb_voitures + 1
    if isinstance(vehicule, Moto):
        plaques_motos.append(vehicule.plaque)

print("Camions :", nb_camions)
print("Voitures (taxis compris) :", nb_voitures)
print("Motos :", plaques_motos)
