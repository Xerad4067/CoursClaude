# Fichier : moderation.py
mot_interdit = "triche"
messages = [
    "Sam fait de la triche",
    "Belle partie, merci !",
    "Pas de triche ici",
]

for message in messages:
    position = message.find(mot_interdit)    # -1 si le mot est absent
    if position == -1:
        print("OK      :", message)
    else:
        avant = message[:position]           # tout ce qui précède le mot
        print(f"Signalé : {message} (position {position}, avant : '{avant}')")
