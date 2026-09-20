# Réparation images site PNQ

**Cause :** le site pointait vers `media.base44.com` (CDN mort → 404).  
Les fichiers locaux sont dans `assets/images/` et `images/articles/`.

## Publier sur premieres-nations-quebec

Dans le dossier **premieres-nations-quebec** sur ton PC :

```bash
git pull
git am "chemin/vers/LABO/docs/pnq-image-fix/"*.patch
git push origin main
```

Ou double-clic **`APPLIQUER-TRADUCTIONS-PNQ.bat`** si mis à jour pour ce patch.

**Test :** https://socrate83.github.io/premieres-nations-quebec/Abenaquis.html  
**Accueil :** https://socrate83.github.io/premieres-nations-quebec/Home.html

Articles #52–#72 : voir `docs/images-manquantes-base44.txt` (50 PNG à ajouter dans `assets/images/`).
