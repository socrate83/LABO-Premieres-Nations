# Supprimer Base44 — site PNQ

Base44 n’est plus utilisé : **images** et **liens** pointent vers le dépôt GitHub / Pages.

## Publier sur premieres-nations-quebec

Dans le dossier **premieres-nations-quebec** sur ton PC :

```bash
git pull
git am docs/pnq-image-fix/0001-*.patch docs/pnq-image-fix/0002-*.patch
git push origin main
```

*(Chemin depuis le LABO cloné : `docs/pnq-image-fix/`.)*

**Test :** https://socrate83.github.io/premieres-nations-quebec/Home.html  
https://socrate83.github.io/premieres-nations-quebec/Abenaquis.html

## Scripts (dans le repo PNQ après patch)

```bash
node scripts/repair-local-images.mjs
node scripts/remove-base44-links.mjs
node scripts/mirror-pages-to-root.mjs
```
