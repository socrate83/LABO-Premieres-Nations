# Notes LABO Premières Nations

## Démarrer le labo (Windows)

1. Double-clic **`DEMARRER-LABO.bat`** (à la racine du dépôt)
2. Navigateur → **http://localhost:8081**
3. Ne ferme pas la fenêtre noire du serveur

## Pages à tester

- Accueil : http://localhost:8081/
- Article Pierre : http://localhost:8081/articles/pierre-memoire.html

## À essayer

- Modifier le texte de `articles/pierre-memoire.html`
- Ajouter un nouvel article dans `articles/`
- Changer les couleurs dans `assets/css/style.css`

## Chemins qui marchent

Depuis un fichier dans `articles/` :

```html
<link rel="stylesheet" href="../assets/css/style.css">
<img src="../assets/images/Ours.png" alt="...">
```

Depuis `index.html` à la racine :

```html
<link rel="stylesheet" href="assets/css/style.css">
<a href="articles/pierre-memoire.html">Mon article</a>
```

## Si ça bloque

Envoie le message d'erreur ou dis « ça n'affiche plus » — on corrige chemin, CSS ou image.
