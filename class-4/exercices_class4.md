% __ENC/ XSLT/ Exercices (séance 4)__
% Jean-Damien Généro
% 2024

## Exercice 4.1 : `<xsl:for-each/>`

- Faire une boucle sur les deux `<title>` du `<titleStmt>` pour 
	- les reproduire à l'identitque (avec leur attribut) ;
	- ajouter leur texte dans une sous balise `<title>` ;
	- ajouter les prénoms et noms de l'auteur dans une balise `<persName>` juste après ;
	- ajouter la date de publication entre paranthèse après `<persName>` ;
	- mettre `par` entre le nouveau `<title>` et le `<persName>`.

- Résultat attentu :

```xml
<titleStmt>
	<title level="m">
		<title>Trois Comtes</title>
		par
		<persName>Gustave Flaubert</persName>
		(1877)
	</title>
	<title level="a">
		<title>La Légende de Saint Julien l'Hospitalier</title>
		par
		<persName>Gustave Flaubert</persName>
		(1877)
	</title>
</titleStmt>
```

## Exercice 4.2 : `<xsl:sort/>`

- Faire une boucle sur les deux références dans `<listBibl>` :
	- Reproduire les `<biblStruct>` sans changement ;
	- Mais les trier par ordre alphabétique (en vous basant sur le nom de famille).

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
- Résultat attentu : _cf._ 4.2.

## Exercice 4.4

- Utiliser la feuille de style écrite avec les exercices précédents. Retirer le code de l'exercice 4.2.

### 4.4.1. La bibliographie
- Dans `<listBibl>`, remplacer chaque référence contenue dans `<biblStruct>` par un `<bibl>` reproduisant le contenu des commentaires.
	- Utiliser des boucles et conditions ;
	- Trier les reférences par ordre alphabétique ;
	- Les guillemets français correspondent aux entités `&#171;` et `&#187;`.

- Résultat attendu :
```xml
<listBibl>
	<bibl>DORD-CROUSLÉ Stéphanie, « Établir le texte de Trois contes », 
		<hi rend="i">Flaubert. Revue critique et génétique</hi> 
		[<ref target="https://journals.openedition.org/flaubert/4143">
		en ligne</ref>], n°24, 2020.</bibl>
	<bibl>NARR Sabine, « Le Saint Julien de Flaubert – une poétique
		du vitrail narrativisé », <hi rend="i">Les Dossiers du Grihl</hi>
		[<ref target="http://journals.openedition.org/dossiersgrihl/6447">
		en ligne</ref>, DOI : <ref target="htpps://doi.org/10.4000/
		dossiersgrihl.6447">10.4000/dossiersgrihl.6447</ref>], n°9-1,
		2015.</bibl>
	<bibl>SAMSON Véronique, « Le roman après la fin », dans 
		<hi rend="i">Après la fin. Gustave Flaubert et le temps du 
		roman</hi>, chap. 2, 2021, p. 105-190.</bibl>
</listBibl>
```

### 4.4.2. Le `<text>`
- Reproduire les balises `<text>`, `<body>`, `<head>` et `<div>`.
- Numéroter en continu les `<p>`.
- Transformer les `<hi rend="b">` en `<persName ana="">` et les `<hi rend="i">` en `<placeName ana="">`, le `@ana` devant à chaque fois avoir pour valeur le texte contenu dans la balise, mais sans les apostrophes et avec les espaces remplacés par des tirets bas (`_`).
	- Exemple : `<hi rend="b">empereur d'Occitanie</hi>` est transformé en `<persName ana="empereur_doccitanie">empereur d'Occitanie</persName>`.
	- Pour éviter une erreur de validation ("`Unmatched quote in expression`"), créer une variable nommée `apos` et contenant une apostrophe (`'`).
- Reprendre l'index de l'exercice 4.3 et :
  - Écrire en majuscule les entrées d'index ;
  - Ajouter aux `<p>` un `@corresp` avec pour valeur : `#` suivi du contenu des `@ana` créés plus haut.

- Résultat attendu (dans le `<body>`, après les `<div>` des chapitres) :

```xml
<div>
	<head>Index</head>
	<div type="name">
		<p corresp="#père">père : 1.</p>
		<p corresp="#mère">mère : 1.</p>
		<p corresp="#julien">Julien : 1, 2.</p>
		<p corresp="#dauphin_de_france">dauphin de France : 2.</p>
		(...)
	</div>
	<div type="place">
		<p corresp="#milan">Milan : 2.</p>
		<p corresp="#oberbirbach">Oberbirbach : 2.</p>
	</div>
</div>
```