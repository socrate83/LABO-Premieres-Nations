# Patch traductions — site Premières Nations du Québec

Les corrections sont prêtes mais le push direct vers `premieres-nations-quebec` a échoué (droits GitHub).

## Lien du site live (vérification)

**Accueil :** https://socrate83.github.io/premieres-nations-quebec/Home.html

**Test EN :** ouvrir le lien → clic **EN** (haut droite) → descendre après les articles

**Autres pages :**
- Articles : https://socrate83.github.io/premieres-nations-quebec/Articles.html
- Vidéos : https://socrate83.github.io/premieres-nations-quebec/Videos.html
- Audio : https://socrate83.github.io/premieres-nations-quebec/Audio.html

## Appliquer les corrections sur ton PC

Dans le dossier `premieres-nations-quebec` sur ton PC :

```bash
git pull
git am docs/pnq-i18n-patch/*.patch
git push origin main
```

Ou copier les 2 fichiers `.patch` depuis ce dossier LABO vers ton clone PNQ, puis `git am *.patch`.

GitHub Pages met à jour le site en 1 à 3 minutes après le push.

## Fichiers modifiés

- Home.html — blocs vedettes + communauté + footer
- lang-switcher.js — traduction dynamique spotlights
- locales/fr.json, en.json, es.json — footer, quote, videos
- locales/home-spotlights-i18n.json — **nouveau**
- Videos.html — suffixe traduit
