# Cours Claude · Développement de jeux, de zéro à l'autonomie

Site de cours en français (thème sombre, police Roboto) pour apprendre pas à pas : installer son environnement sur deux machines Windows, programmer en **Lua**, utiliser **Git/GitHub**, puis écrire des scripts et de petites maps pour **Nanos World**, avec des bases utiles au **BTS SIO option SLAM**.

- Site publié : https://xerad4067.github.io/CoursClaude/ (une fois GitHub Pages activé, voir ci-dessous)
- Plan, choix techniques et planning : [`PLAN.md`](PLAN.md)
- Installation des outils (portable et PC fixe) : [`INSTALLATION.md`](INSTALLATION.md)
- Outils recommandés : [`OUTILS-RECOMMANDES.md`](OUTILS-RECOMMANDES.md) · Sources : [`SOURCES.md`](SOURCES.md)
- Où en est le cours : [`ETAT_AVANCEMENT_COURS.md`](ETAT_AVANCEMENT_COURS.md)

## Lancer le site en local
Prérequis : Node.js 24 LTS (voir `INSTALLATION.md`, section 9).
```powershell
npm install
npm run dev
```
Puis ouvre http://localhost:4321/CoursClaude/. Pour la version complète avec la recherche : `npm run build` puis `npm run preview`.

## Tester les exercices Lua
Prérequis : Lua 5.4 (voir `INSTALLATION.md`, section 8).
```powershell
lua exercices/tester.lua
```

## Publier sur GitHub Pages
1. Le dépôt doit être public (GitHub Free).
2. GitHub → **Settings** → **Pages** → **Source** : **GitHub Actions**.
3. Chaque `push` sur `main` publie le site (`.github/workflows/deploy.yml`).

Aucune donnée personnelle, aucun compte ni jeton dans ce dépôt. La progression de l'apprenant reste dans son navigateur.
