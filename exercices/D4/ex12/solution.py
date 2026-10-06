# Fichier : compte_bancaire.py
class CompteBancaire:
    """Un compte en banque avec son historique."""

    def __init__(self, titulaire, solde=0):
        self.titulaire = titulaire
        self._solde = solde
        self._historique = []  # les opérations, dans l'ordre

    @property
    def solde(self):
        return self._solde

    @property
    def historique(self):
        return list(self._historique)  # une COPIE : on ne peut pas tricher

    def _verifier_montant(self, montant):
        # méthode « interne » : le _ dit qu'elle sert seulement à la classe
        if montant <= 0:
            raise ValueError("Le montant doit être positif")

    def deposer(self, montant):
        self._verifier_montant(montant)
        self._solde = self._solde + montant
        self._historique.append(f"dépôt de {montant} €")

    def retirer(self, montant):
        self._verifier_montant(montant)
        if montant > self._solde:
            raise ValueError(
                f"{self.titulaire} : solde insuffisant "
                f"({self._solde} € disponibles, {montant} € demandés)"
            )
        self._solde = self._solde - montant
        self._historique.append(f"retrait de {montant} €")

    def __str__(self):
        return f"{self.titulaire} : {self._solde} €"


sam = CompteBancaire("Sam", 100)
kim = CompteBancaire("Kim")  # solde de départ : 0
sam.deposer(50)
sam.retirer(30)
kim.deposer(300)

try:
    sam.retirer(500)
except ValueError as erreur:
    print("Refusé :", erreur)

try:
    kim.deposer(-10)
except ValueError as erreur:
    print("Refusé :", erreur)

print(sam)
print(kim)
for operation in sam.historique:
    print("-", operation)

copie = sam.historique
copie.append("triche")  # ne modifie que la copie
print(len(sam.historique), "opérations enregistrées")
