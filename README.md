# LABO-Premieres-Nations

Dépôt d'essai privé pour apprendre GitHub et la structure d'un site.

## Démarrage local (une bonne fois pour toutes)

1. Clone ou mets à jour le dépôt sur ton PC
2. Double-clique **`DEMARRER-LABO.bat`**
3. Le navigateur s'ouvre sur **`http://localhost:8081`**
4. **Laisse la fenêtre noire ouverte** pendant tes essais

Pour rouvrir le navigateur sans relancer le serveur : double-clique **`OUVRIR-LABO.bat`**.

Port fixe : **8081** (toujours le même).

## Arborescence

```
LABO-Premieres-Nations/
├── index.html              ← page d'accueil du labo
├── DEMARRER-LABO.bat       ← lance le serveur (Windows)
├── OUVRIR-LABO.bat         ← ouvre le navigateur seulement
├── articles/
│   └── pierre-memoire.html ← article Pierre le Fouineur
├── assets/
│   ├── css/style.css       ← styles partagés
│   ├── js/app.js
│   └── images/Ours.png
├── locales/                ← exemples FR/EN/ES
└── docs/notes-labo.md
```

## Chemins relatifs (important)

| Tu es dans…              | CSS                         | Image                          |
|--------------------------|-----------------------------|--------------------------------|
| `index.html` (racine)    | `assets/css/style.css`      | `assets/images/Ours.png`       |
| `articles/xxx.html`      | `../assets/css/style.css`   | `../assets/images/Ours.png`    |

## Commande manuelle (si besoin)

```bash
python -m http.server 8081
```

Puis ouvre : http://localhost:8081

## Dépannage

| Problème | Solution |
|----------|----------|
| Page blanche ou 404 | Vérifie que `DEMARRER-LABO.bat` tourne encore |
| Port déjà utilisé | Ferme l'autre fenêtre serveur, relance le .bat |
| Image ne s'affiche pas | Vérifie le chemin `../assets/images/` depuis `articles/` |
| CSS absent | Même chose pour `../assets/css/style.css` |
| Python introuvable | Installe Python avec « Add to PATH » coché |
