# Fichier : parc.py
class Vehicule:
    """Un véhicule : ce que tous les véhicules ont en commun."""

    def __init__(self, plaque):
        self.plaque = plaque

    def decrire(self):
        return f"Véhicule {self.plaque}"


class Voiture(Vehicule):  # une Voiture EST UN Vehicule
    pass                  # rien à ajouter : tout est hérité


class Moto(Vehicule):
    pass


ma_voiture = Voiture("AB-123-CD")
ma_moto = Moto("MM-001-AA")

print(ma_voiture.plaque)
print(ma_voiture.decrire())
print(ma_moto.decrire())
