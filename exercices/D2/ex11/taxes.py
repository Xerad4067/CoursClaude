# Fichier : taxes.py : un module est un fichier .py rangé dans le même dossier
TAUX_TVA = 20


def ttc(prix_ht):
    return prix_ht + prix_ht * TAUX_TVA // 100


def appliquer_remise(prix, pourcentage=10):
    return prix - prix * pourcentage // 100


if __name__ == "__main__":
    # Ce bloc ne s'exécute que si on lance taxes.py directement, pas avec import.
    print("Test de taxes.py :", ttc(100), appliquer_remise(200))
