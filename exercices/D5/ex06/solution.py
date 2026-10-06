# Fichier : qui_repond.py
class Vehicule:
    def __init__(self, plaque):
        self.plaque = plaque

    def peage(self):
        return 5

    def ticket(self):
        return f"{self.plaque} : {self.peage()} €"


class Voiture(Vehicule):
    def peage(self):
        return 6


class Taxi(Voiture):
    def peage(self):
        return super().peage() // 2


vehicule = Vehicule("V-1")
voiture = Voiture("V-2")
taxi = Taxi("V-3")

print(vehicule.ticket())
print(voiture.ticket())
print(taxi.ticket())
print(isinstance(taxi, Voiture))
print(isinstance(voiture, Taxi))
print(isinstance(taxi, Vehicule))
