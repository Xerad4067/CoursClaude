class Joueur:
    def __init__(self, nom, argent):
        self.nom = nom
        self.argent = argent

    def gagner(self, montant):
        self.argent = self.argent + montant

    def depenser(self, montant):
        if montant > self.argent:
            print("Refusé : pas assez d'argent")
        else:
            self.argent = self.argent - montant
            print(f"{self.nom} dépense {montant} €")

    def decrire(self):
        return f"{self.nom} possède {self.argent} €"


sam = Joueur("Sam", 1500)
sam.gagner(100)
sam.depenser(5000)
sam.depenser(200)
print(sam.decrire())
