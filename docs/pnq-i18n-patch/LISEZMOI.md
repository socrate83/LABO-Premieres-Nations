# Traductions accueil — site Premières Nations du Québec

Corrections prêtes : blocs **Langues**, **Femmes**, **Communauté**, **footer** et **Vidéos** traduits EN/ES.

## Lien site live

https://socrate83.github.io/premieres-nations-quebec/Home.html

**Test :** clic **EN** ou **ES** → descendre après la grille d'articles.

---

## Méthode 1 — Double-clic (PC Jean-Claude, 2 minutes)

1. `git pull` dans **LABO Premieres Nations**
2. Double-clic **`APPLIQUER-TRADUCTIONS-PNQ.bat`**
3. Le script copie les fichiers et fait `git push` avec **ton** compte GitHub

Dossier PNQ habituel : `C:\Users\socra\.cursor\socrate\premieres-nations-quebec`

---

## Méthode 2 — GitHub Actions (depuis le navigateur)

1. Va sur https://github.com/socrate83/LABO-Premieres-Nations/actions/workflows/deploy-pnq-i18n.yml
2. **Run workflow** → colle un token GitHub (scope `repo`) dans le champ `github_pat`
3. Le workflow pousse sur `premieres-nations-quebec` → Pages se met à jour en 1–3 min

*(Option : ajouter le secret `PNQ_PUSH_TOKEN` dans les secrets du repo LABO pour ne plus coller le token.)*

---

## Méthode 3 — Agent Cloud sur le bon repo

Relancer l'agent Cursor sur **`socrate83/premieres-nations-quebec`** (pas seulement LABO) :

GitHub → Settings → Applications → **Cursor** → Configure → cocher **premieres-nations-quebec**

---

## Fichiers modifiés

| Fichier | Rôle |
|---------|------|
| `Home.html` | data-i18n communauté, footer, spotlights |
| `lang-switcher.js` | applyHomeSpotlights(), nav Articles |
| `locales/fr.json`, `en.json`, `es.json` | quote, footer, videos |
| `locales/home-spotlights-i18n.json` | blocs vedettes EN/ES |
| `Videos.html` | suffixe traduit |

Copies prêtes dans `docs/pnq-i18n-patch/files/`.
