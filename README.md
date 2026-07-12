# LABO-Premieres-Nations

Dépôt d'essai privé pour apprendre GitHub et la structure d'un site.

## Démarrage local (une bonne fois pour toutes)

1. Clone ou mets à jour le dépôt sur ton PC (`git pull`)
2. Double-clique **`DEMARRER-LABO.bat`**
3. **Laisse la fenêtre noire OUVERTE** — si tu la fermes, localhost refuse la connexion
4. Le navigateur s'ouvre sur **`http://localhost:8081`**

| Fichier | Rôle |
|---------|------|
| `DEMARRER-LABO.bat` | Démarre le serveur + ouvre le navigateur |
| `OUVRIR-LABO.bat` | Ouvre le navigateur (démarre le serveur si besoin) |
| `VERIFIER-LABO.bat` | Diagnostic si ça ne marche pas |

Port fixe : **8081**

### ERR_CONNECTION_REFUSED — que faire ?

Ce message = **aucun serveur ne tourne**. Ce n'est pas un problème de pare-feu.

1. Double-clic **`DEMARRER-LABO.bat`** (pas seulement OUVRIR-LABO)
2. Vérifie que la fenêtre noire **reste ouverte**
3. Attends 2 secondes, puis va sur http://localhost:8081
4. Si ça bloque : double-clic **`VERIFIER-LABO.bat`** et lis le diagnostic
5. Si Python manque : installe-le avec **« Add to PATH »** coché → https://www.python.org/downloads/

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
| **ERR_CONNECTION_REFUSED** | Lance `DEMARRER-LABO.bat` et garde la fenêtre ouverte |
| Page blanche ou 404 | Vérifie que `DEMARRER-LABO.bat` tourne encore |
| Port déjà utilisé | Ferme l'autre fenêtre serveur, relance le .bat |
| Python introuvable | Installe Python avec « Add to PATH » coché |
| Diagnostic complet | Double-clic `VERIFIER-LABO.bat` |
