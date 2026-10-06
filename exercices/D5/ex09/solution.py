# Fichier : metiers.py
class Metier:
    def __init__(self, nom, salaire_horaire):
        self.nom = nom
        self.salaire_horaire = salaire_horaire

    def paie(self, heures):
        return self.salaire_horaire * heures


class Livreur(Metier):
    def __init__(self, nom, salaire_horaire):
        super().__init__(nom, salaire_horaire)
        self.colis = 0

    def livrer(self, nb):
        self.colis = self.colis + nb

    def paie(self, heures):
        # salaire normal + 2 € de prime par colis livré
        return super().paie(heures) + 2 * self.colis


class Joueur:
    def __init__(self, nom, argent, metier=None):
        self.nom = nom
        self.argent = argent
        self.metier = metier  # 0..1 : un Joueur a au plus un métier

    def travailler(self, heures):
        if self.metier is None:
            print(f"{self.nom} n'a pas de métier")
            return
        gain = self.metier.paie(heures)
        self.argent = self.argent + gain
        print(f"{self.nom} gagne {gain} €")


taxi = Metier("taxi", 12)
livreur = Livreur("livreur", 11)
sam = Joueur("Sam", 100, taxi)
kim = Joueur("Kim", 100, livreur)
alex = Joueur("Alex", 100)

livreur.livrer(3)
sam.travailler(2)
kim.travailler(2)
alex.travailler(2)
print(sam.argent, kim.argent, alex.argent)
