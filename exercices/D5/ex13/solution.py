# Fichier : parc_vehicules.py
class Vehicule:
    """Classe mère : ce que tous les véhicules ont en commun."""

    nom_type = "Véhicule"  # attribut de classe, redéfini dans chaque fille

    def __init__(self, plaque):
        self.plaque = plaque

    def decrire(self):
        return f"{self.plaque} ({self.nom_type})"

    def peage(self):
        # Méthode « abstraite » : chaque classe fille doit la redéfinir.
        raise NotImplementedError("peage() à définir dans la classe fille")


class Voiture(Vehicule):
    nom_type = "Voiture"

    def peage(self):
        return 6


class Camion(Vehicule):
    nom_type = "Camion"

    def __init__(self, plaque, nb_essieux):
        super().__init__(plaque)
        self.nb_essieux = nb_essieux

    def decrire(self):
        return f"{self.plaque} ({self.nom_type}, {self.nb_essieux} essieux)"

    def peage(self):
        return 8 + 4 * self.nb_essieux


class Moto(Vehicule):
    nom_type = "Moto"

    def peage(self):
        return 2


class Parc:
    """Un parc A des véhicules (composition)."""

    def __init__(self, nom):
        self.nom = nom
        self._vehicules = []

    def ajouter(self, vehicule):
        self._vehicules.append(vehicule)

    def afficher_tickets(self):
        print(self.nom)
        for vehicule in self._vehicules:
            print(f"{vehicule.decrire()} : {vehicule.peage()} €")

    def recette(self):
        total = 0
        for vehicule in self._vehicules:
            total = total + vehicule.peage()  # polymorphisme
        return total


parc = Parc("Péage de la vallée")
parc.ajouter(Voiture("AB-123-CD"))
parc.ajouter(Camion("XY-987-ZT", 3))
parc.ajouter(Moto("MM-001-AA"))
parc.ajouter(Voiture("KM-456-LP"))
parc.afficher_tickets()
print(f"Recette : {parc.recette()} €")

try:
    Vehicule("ZZ-000-ZZ").peage()
except NotImplementedError as erreur:
    print("Refusé :", erreur)
