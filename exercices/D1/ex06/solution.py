# Fichier : pompe.py
nom = input("Nom : ")
litres = float(input("Litres : "))            # input donne du texte : on convertit
prix_litre = float(input("Prix au litre : "))
total = litres * prix_litre
print(f"{nom} doit payer {total:.2f} €")      # .2f : deux chiffres après la virgule
