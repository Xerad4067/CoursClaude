# Fichier : compte.py
class CompteBancaire:
    def __init__(self, titulaire, solde):
        self.titulaire = titulaire
        self._solde = solde  # le _ dit : « n'y touche pas de l'extérieur »

    @property
    def solde(self):  # lecture seule : il n'y a pas de setter
        return self._solde

    def deposer(self, montant):
        self._solde = self._solde + montant


compte = CompteBancaire("Sam", 100)
compte.deposer(50)
print(compte.solde)

try:
    compte.solde = 1000000  # tentative de triche
except AttributeError as erreur:
    print("Triche refusée :", erreur)

print(compte.solde)
