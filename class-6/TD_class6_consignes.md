% __ENC/ XSLT/ TD XML vers HTML (séance 6)__
% Jean-Damien Généro
% 2023

# Environnement de travail

- Document XML : `class6_st_julien_hospitalier.xml`.
- **Un exemple des documents de sortie se trouve dans le dossier `/class-6/out`**.

# Consigne générale

- Transformer le fichier `class6_st_julien_hospitalier.xml` en quatre documents HTML : `st_julien_home.html`, `st_julien_chap1.html`, `st_julien_chap2.html` et `st_julien_index.html`.

# Étape 1

- Paramétrer l'en-tête XSL et l'instruction `output` pour une transformation vers HTML.
- Écrire quatre variables contenant les noms des quatre fichiers HTML.
- Écrire une variable `$header` contenant :

```html
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title><!-- valeur du <title> de niveau a--></title>
    <meta name="description"
    	  content="
    	  <!-- valeur du title de niveau a--> 
    	  par <!-- valeur de author -->
    	  " />
    <meta name="author" content="<!-- vos prénom et nom -->"/>
</head>
```

- Écrire des variables avec les liens (balise HTML `<a href="#"/>`) vers chaque fichier. Le but est de pouvoir naviguer entre chaque fichier directement dans votre navigateur.
  - `$return_home`, qui doit contenir le lien `./st_julien_home.html` et le texte `Revenir à l'accueil` _en italique_ (balise HTML `<i>`).
  - `$return_chap1` : sur le même modèle que la précédente ;
  - `$return_chap2` : sur le même modèle que la précédente ;
  - `$return_index` : sur le même modèle que la précédente.

# Étape 2. Page Home

1. Écrire une template qui matche la racine.
  - Cette template contiendra les ``<xsl:call-template/>`` sous cette forme :
```xml
<xsl:call-template name="home"/>
<xsl:call-template name="chapter1"/>
<xsl:call-template name="chapter2"/>
<xsl:call-template name="index_st_julien"/>
```
  - Commencer par ajouter le premier sur le home.
2. Écrire une template avec un `@name="home"` pour la lier à ce premier ``<xsl:call-template/>``.
3. À l'intérieur de cette template, écrire un `<xsl:result-document/>` pour le fichier `home` (_regarder le cours précédent pour se remémorer le fonctionnement de cette instruction_).
4. Écrire un code HTML valide à l'intérieur avec :
	- La balise racine `html` ;
	- Le `<header/>` HTML (appeler la variable `$header` définie plus haut)
5. Dans le `<body/>`, ouvrir une première `<div>` avec les éléments de titre sous cette forme :

```html
<h1>Édition en ligne de <!-- titre de niveau m en italique --></h1>
<h2>Comte n°2, <!-- titre de niveau a en italique --></i></h2>
<p><!-- auteur --></p>
```

7. Dans une deuxième `<div>`, ajouter dans des `<p>` : 
	- `Résumé :` en gras, suivi du résumé (balise `<abstract>`) ;
	- Des liens vers les chapitres et l'index (utiliser les variables définies plus haut).
8. Ajouter dans une balise `<footer/>` le contenu de la balise `<edition>`.

# Étape 3. Les chapitres.

_Regarder la correction du TD de la séance 5 pour savoir comment envoyer les textes des deux chapitres dans deux documents de sortie différents._

Utiliser pour chaque chapitre la procédure appliquée pour la page Home afin de :

1. Ajouter le `<xsl:call-template/>` du chapitre à votre feuille de style.
2. Lier ce `<xsl:call-template/>` à un `<xsl:template/>`.
3. Écrire un `<xsl:result-document/>` avec la variable correspondant au chemin du chapitre.
4. Ajouter le code HTML basique (`<html>`, `<header>`, `<body>`).
5. Dans le `<body>`, créer une `<div>` contenant :
  - Un `<h3>` avec le numéro du chapitre ;
  - Les paragraphes du chapitre (utiliser une boucle `for-each`).
6. Ajouter dans une balise `<footer/>` le contenu de la balise `<edition>`.

# Étape 4. Les index

1. Comme aux étapes précédentes, ajouter un `<xsl:call-template/>` pour l'index et le lier à un `<xsl:template/>`.
2. Écrire un `<xsl:result-document/>` et le code HTML basique.
3. Regarder les corrections des TD précédents pour constituer un index des noms de lieux et un index des noms de personnes. **Le code ne doit pas être repris tel quel : vous devez enlever certains éléments (création des `@corresp`) et en ajouter d'autres :**
  - L'index doit sous la forme `<p><i>dauphin de France</i> : <a href="./st_julien_chap2.html">2</a>.</p>`.
  - Utiliser des conditions XSL afin de créer les liens vers les pages où aparraissent les entrées d'index (balise `<a>` de l'exemple ce-dessus).
4. Regarder les corrections des TD précédents afin d'ajouter la template qui permet de transformer les `<hi>` en `<persName>` ou `<placename>` selon le cas.
5. Ajouter dans une balise `<footer/>` le contenu de la balise `<edition>`.

# Étape 5. CSS

- Proposer un habillage CSS pour vos documents.



_**Reprenez l'ensemble de l'exercice chez vous jusqu'à pouvoir naviguer correctement entre les quatre documents HTML. Cela vous sera utile pour le projet à rendre pour l'évaluation finale !**_