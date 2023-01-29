% __ENC/ XSLT/ Exercices (séance 4)__
% Jean-Damien Généro
% 2023

## Exercice 4.1 : `<xsl:for-each/>`

- Faire une boucle sur les deux `<title>` du `<titleStmt>` pour 
	- les reproduire à l'identitque (avec leur attribut) ;
	- ajouter leur texte dans une sous balise `<title>` ;
	- ajouter les prénoms et noms de l'auteur dans une balise `<persName>` juste après ;
	- ajouter la date de publication entre paranthèse après `<persName>` ;
	- mettre `par` entre le nouveau `<title>` et le `<persName>`.

## Exercice 4.2 : `<xsl:sort/>`

- Faire une boucle sur les deux références bibliographiques dans `<listBibl>` :
	- Reproduisez les `<biblStruct>` sans changement ;
	- Mais les trier :
	  - Une première fois par date de parution ;
	  - Une deuxième fois par ordre alphabétique (en vous basant sur le nom de famille).

## Exercice 4.3 : `<xsl:for-each-group/>`

- Sélectionner le `<text/>` et reproduire les balises `<text>`.
- Reproduire les balises `<body>` ;
- Reproduire les deux `<div>` des chapitres sans changement ;
- Ajouter un index des noms de personnes et un index des noms de lieux dans une nouvelle `<div>` après celles des chapitres.
	- Ajouter un `<head>Index</head>` ;
	- Utiliser plusieurs `<xsl:for-each-group/>` :
	  1. Un premier `<xsl:for-each-group/>` pour sélectionner les `<hi>` et les grouper en fonction de leur attribut. À l'intérieur, créer une `<div>` avec un `@type`. Utiliser une condition pour spécifier la valeur de l'`@type` : `name` si l'itération est sur les `<hi rend="b"/>` et `place` si elle est sur les `<hi rend="i"/>` ;
	  2. Un deuxième `<xsl:for-each-group/>` pour créer **un seul** `<p/>` par entrée d'index (attention, il y a un doublon : `Julien`). Ajouter le nom de l'individu ou du lieu dans le `<p>` et deux points (`:`) devant. Exemple : `<p>Julien :</p>` ;
	  3. Un troisième `<xsl:for-each-group/>` pour ajouter devant les deux points le numéro des chapitres où apparaissent les entrées d'index. Exemple : `<p>Julien : 1, 2.</p>`.