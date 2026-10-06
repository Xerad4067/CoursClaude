#!/usr/bin/env python3
"""tester_autres.py : vérifie les solutions Python, JavaScript (Node.js), SQL (SQLite) et Git/shell.

Utilisation (depuis la racine du dépôt) :
    python3 exercices/tester_autres.py          # tout tester
    python3 exercices/tester_autres.py D2       # un seul module
(sous Windows : py exercices/tester_autres.py)

Pour chaque exercice (dossier exercices/<MODULE>/exNN/), selon le langage :
  * solution.py  : Python, comparé à attendu.txt. entrees.txt (optionnel) = les lignes « tapées » au clavier
                   (input() les affiche comme dans un vrai terminal).
  * solution.js  : JavaScript exécuté avec Node.js, comparé à attendu.txt.
  * solution.sql : SQL exécuté dans SQLite (module sqlite3 de Python) sur la base donnée par config.json
                   {"base": "boutique"} = exercices/_donnees/boutique.sql ; les SELECT sont affichés en tableau.
  * solution.sh  : script shell (Git) exécuté dans un dossier temporaire, comparé à attendu.txt.
  * casse.<ext>  : (débogage) le code cassé, qui NE doit PAS donner le bon résultat.
Le test des solutions Lua est fait par exercices/tester.lua.
"""
import json
import os
import shutil
import sqlite3
import subprocess
import sys
import tempfile

RACINE = os.path.dirname(os.path.abspath(__file__))
FILTRE = sys.argv[1] if len(sys.argv) > 1 else None
DELAI = 20  # secondes maximum par exercice

EXTENSIONS = {"py": "Python", "js": "JavaScript", "sql": "SQL", "sh": "Git/shell"}

RUNNER_PYTHON = r'''
import builtins, runpy, sys, json
chemin, dossier, entrees = sys.argv[1], sys.argv[2], json.loads(sys.argv[3])
sys.path.insert(0, dossier)
it = iter(entrees)
def faux_input(invite=""):
    sys.stdout.write(str(invite))
    try:
        valeur = next(it)
    except StopIteration:
        raise EOFError("entrees.txt : pas assez de lignes prévues")
    sys.stdout.write(valeur + "\n")
    return valeur
builtins.input = faux_input
runpy.run_path(chemin, run_name="__main__")
'''


def lire(chemin):
    try:
        with open(chemin, encoding="utf-8") as f:
            return f.read()
    except FileNotFoundError:
        return None


def normaliser(texte):
    return texte.replace("\r\n", "\n").rstrip()


def config_de(dossier):
    contenu = lire(os.path.join(dossier, "config.json"))
    return json.loads(contenu) if contenu else {}


def executer_python(chemin, dossier):
    entrees = lire(os.path.join(dossier, "entrees.txt"))
    liste = entrees.split("\n") if entrees else []
    if liste and liste[-1] == "":
        liste.pop()
    env = dict(os.environ, PYTHONIOENCODING="utf-8", PYTHONDONTWRITEBYTECODE="1")
    r = subprocess.run(
        [sys.executable, "-c", RUNNER_PYTHON, chemin, dossier, json.dumps(liste)],
        capture_output=True, text=True, encoding="utf-8", timeout=DELAI, cwd=dossier, env=env,
    )
    return r.returncode == 0, r.stdout, r.stderr


def executer_js(chemin, dossier):
    if shutil.which("node") is None:
        return False, "", "Node.js introuvable (installe-le : voir INSTALLATION.md)"
    r = subprocess.run(["node", chemin], capture_output=True, text=True, encoding="utf-8", timeout=DELAI, cwd=dossier)
    return r.returncode == 0, r.stdout, r.stderr


def formater_valeur(v):
    if v is None:
        return "NULL"
    if isinstance(v, float):
        return f"{v:.2f}".rstrip("0").rstrip(".") if v != int(v) else str(int(v))
    return str(v)


def executer_sql(chemin, dossier):
    config = config_de(dossier)
    connexion = sqlite3.connect(":memory:")
    connexion.execute("PRAGMA foreign_keys = ON")
    sortie = []
    try:
        if "base" in config:
            donnees = lire(os.path.join(RACINE, "_donnees", config["base"] + ".sql"))
            if donnees is None:
                return False, "", f"base introuvable : _donnees/{config['base']}.sql"
            connexion.executescript(donnees)
        script = lire(chemin)
        # Découpe en instructions complètes (point-virgule hors des chaînes).
        courant = ""
        instructions = []
        for ligne in script.split("\n"):
            courant += ligne + "\n"
            if sqlite3.complete_statement(courant):
                instructions.append(courant.strip())
                courant = ""
        if courant.strip():
            instructions.append(courant.strip())
        for instruction in instructions:
            if not instruction or all(l.strip().startswith("--") or not l.strip() for l in instruction.split("\n")):
                continue
            curseur = connexion.execute(instruction)
            if curseur.description is not None:
                noms = [d[0] for d in curseur.description]
                lignes = curseur.fetchall()
                sortie.append(" | ".join(noms))
                for ligne in lignes:
                    sortie.append(" | ".join(formater_valeur(v) for v in ligne))
                sortie.append("")
            elif instruction.split()[0].upper() in ("INSERT", "UPDATE", "DELETE"):
                sortie.append(f"{curseur.rowcount} ligne(s) modifiée(s)")
                sortie.append("")
        return True, "\n".join(sortie), ""
    except Exception as e:  # message d'erreur SQLite tel quel
        return False, "\n".join(sortie), f"{type(e).__name__}: {e}"
    finally:
        connexion.close()


def executer_shell(chemin, dossier):
    bash = shutil.which("bash")
    if bash is None:
        return False, "", "bash introuvable"
    with tempfile.TemporaryDirectory() as tmp:
        home = os.path.join(tmp, "home")
        os.makedirs(home)
        with open(os.path.join(home, ".gitconfig"), "w", encoding="utf-8") as f:
            f.write("[user]\n\tname = Sam\n\temail = sam@example.invalid\n[init]\n\tdefaultBranch = main\n[advice]\n\tdetachedHead = false\n")
        travail = os.path.join(tmp, "travail")
        os.makedirs(travail)
        env = {
            "PATH": os.environ.get("PATH", ""),
            "HOME": home,
            "GIT_CONFIG_GLOBAL": os.path.join(home, ".gitconfig"),
            "GIT_CONFIG_NOSYSTEM": "1",
            "GIT_TERMINAL_PROMPT": "0",
            "LC_ALL": "C",
            "GIT_EDITOR": "true",
        }
        r = subprocess.run([bash, chemin], capture_output=True, text=True, encoding="utf-8", timeout=DELAI, cwd=travail, env=env)
        return r.returncode == 0, r.stdout, r.stderr


EXECUTEURS = {"py": executer_python, "js": executer_js, "sql": executer_sql, "sh": executer_shell}


def premiere_difference(obtenu, attendu):
    lo, la = obtenu.split("\n"), attendu.split("\n")
    for i in range(max(len(lo), len(la))):
        a = la[i] if i < len(la) else None
        o = lo[i] if i < len(lo) else None
        if a != o:
            return f"ligne {i + 1}\n      attendu : {a}\n      obtenu  : {o}"
    return "différence invisible (espaces ?)"


def main():
    modules = sorted(d for d in os.listdir(RACINE) if os.path.isdir(os.path.join(RACINE, d)) and not d.startswith("_"))
    total = reussis = casses = 0
    echecs = []
    par_langage = {}
    for module in modules:
        if FILTRE and FILTRE != module:
            continue
        dossiers = sorted(d for d in os.listdir(os.path.join(RACINE, module)) if d.startswith("ex"))
        for nom in dossiers:
            dossier = os.path.join(RACINE, module, nom)
            for ext, langage in EXTENSIONS.items():
                solution = os.path.join(dossier, f"solution.{ext}")
                if not os.path.exists(solution):
                    continue
                total += 1
                par_langage[langage] = par_langage.get(langage, 0) + 1
                ident = f"{module}/{nom}"
                attendu = lire(os.path.join(dossier, "attendu.txt"))
                probleme = None
                try:
                    ok, sortie, err = EXECUTEURS[ext](solution, dossier)
                    if not ok:
                        probleme = f"erreur à l'exécution : {err.strip()[-400:]}"
                    elif attendu is None:
                        probleme = "attendu.txt manquant"
                    elif normaliser(sortie) != normaliser(attendu):
                        probleme = "sortie différente, " + premiere_difference(normaliser(sortie), normaliser(attendu))
                    cassee = os.path.join(dossier, f"casse.{ext}")
                    if probleme is None and os.path.exists(cassee):
                        okc, sortiec, _ = EXECUTEURS[ext](cassee, dossier)
                        if okc and normaliser(sortiec) == normaliser(attendu):
                            probleme = "casse : le code « cassé » donne le bon résultat, il n'est pas cassé"
                        else:
                            casses += 1
                except subprocess.TimeoutExpired:
                    probleme = f"trop long (plus de {DELAI} s)"
                if probleme:
                    echecs.append(ident)
                    print(f"ÉCHEC {ident} ({langage}) : {probleme}")
                else:
                    reussis += 1
                    print(f"OK    {ident} ({langage})")
    print("-" * 50)
    print(f"Python : {sys.version.split()[0]}")
    detail = ", ".join(f"{n} {l}" for l, n in sorted(par_langage.items())) or "aucun"
    print(f"Exercices testés : {total} ({detail}) · réussis : {reussis} · échecs : {len(echecs)}")
    print(f"Codes « cassés » vérifiés comme vraiment cassés : {casses}")
    if total == 0 and not FILTRE:
        print("Aucun exercice Python/JS/SQL/Git trouvé.")
        return 1
    return 0 if not echecs else 1


if __name__ == "__main__":
    sys.exit(main())
