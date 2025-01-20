% __ENC/ XSLT/ TD XML vers HTML (séance 6)__
% Jean-Damien Généro
% 2025

# Environnement de travail

- Document XML : `class_6_journal_lefevre.xml`.

- Document XSL : `class_6_journal_lefevre.xsl`.

- Vous travaillez avec un document XML-TEI contenant une édition de plusieurs chapitres du *Journal du chancelier Le Fèvre*. Cet exercice a pour objectif de manipuler les données de ce document et de le transformer en plusieurs fichiers HTML contenant des hyperliens pour circuler entre les fichiers.

- La sortie est composée de six fichiers HTML qui s'enregistrent dans un dossier `out/`:
  - `home.html`, qui contient des éléments du `<teiHeader/>`, une visioneuse IIIF constituée à partir des `<facsimile/>` et la liste des chapitres.
  - `chapitre1.html`, qui contient la `<div/>` du premier chapitre.
  - `chapitre2.html`, qui contient la `<div/>` du deuxième chapitre.
  - `chapitre3.html`, qui contient la `<div/>` du troisième chapitre.
  - `chapitre4.html`, qui contient la `<div/>` du quatrième chapitre.
  - `index.html`, qui contient un index cliquable des noms de personne.
- Les `<head/>`, barre de navigation et `<footer/>` des six documents HTML sont identiques.

## 1. Le `home.html`

### 1.1 La navbar

- À partir du modèle du lien vers le fichier `home.html`, compléter la variable `$navbar`:
  - Utiliser une boucle pour ajouter quatre `<li>` contenant les liens vers les chapitres.
  - Ajouter un lien vers le fichier d'index.

### 1.2 Présentation du site

- Dans la première `<div>`, ajouter cette phrase: `<p>Ce site propose un édition de plusieurs chapitres tirés du livre <em>Journal de Jean Le Fèvre. Chancelier des ducs d'Anjou et comtes de Provence (1381-1388)</em> de Michel Hébert et Jean-Michel Matz (Presses universitaires de Rennes, 2020).</p>` à partir de ces éléments tirés du `<biblStruct/>` du XML:
  - Le `<title/>` (`Journal de Jean Le Fèvre. Chancelier des ducs d'Anjou et comtes de Provence (1381-1388)`.
  - Les `<name/>` (`Michel Hébert` et `Jean-Michel Matz`).
  - Le `<publisher/>` et la `<date/>` (`Presses universitaires de Rennes` et `2020`).

### 1.3 Informations sur le manuscrit

- Compléter la section `Informations sur le manuscrit` avec des éléments tirés du `<msIdentifier/>`.
- Le lien vers la numérisation sur Gallica doit être composé en concaténant `https://gallica.bnf.fr/ark:/` et le contenu de la balise `<idno/>`.

### 1.4 Visionneuse IIIF

- Dans le code javascript, effacer le contenu du champ `tileSources` et recréer les adresses qu'il contient à partir du contenu des `<facsimile/>`.
- Les adresses sont composées à partir de la concaténation de `https://gallica.bnf.fr/iiif/ark:/`, le `@url` de `<graphic/>` et `/info.json`.
- Vous pouvez utiliser `<xsl:for-each/>`.

### 1.5 Liste des chapitres

- Compléter la section `Liste des chapitres` avec des liens vers chaque fichier de chapitre, et le titre de ceux-ci.
- Vous pouvez utiliser `<xsl:for-each/>`.

**Vous devriez maintenant obtenir un fichier `home.html` identique au modèle.**

## 2. Les chapitres

### 2.1 Les fichiers

- À l'aide d'une boucle `<xsl:for-each/>`, créer quatre fichiers nommés `chapitreX.html` où `X` est le contenu de l'attribut `@n` des `<div/>` des chapitres.

### 2.2 Le contenu des chapitres

- Observer le code HTML du fichier `chapitre1.html`.
- Créer une template nommée `chapitres` et le `<xsl:call-template/>` correspondant.
- La nouvelle template doit contenir les variables `$head`, `$navbar` et `$footer`.
- À l'aide d'une boucle, compléter la nouvelle template avec:
  - En titre `<h1/>` le titre du chapitre.
  - Une `<div>` contenant les paragraphes des chapitres (`<p>`).
- Laisser la possibilité d'appliquer des règles aux enfants des `<p>`.

## 3. L'index

- Observer le code HTML du fichier d'exemple `index.html`.
- Créer une template nommée `index` et le `<xsl:call-template/>` correspondant.
- La nouvelle template doit contenir les variables `$head`, `$navbar` et `$footer`.
- À l'aide d'une boucle, compléter la nouvelle template avec:
  - Une première boucle groupée pour créer un seul `<p>` par nom propre.
  - Une deuxième boucle groupée (à l'intérieur de la première) pour créer un lien vers chaque chapitre où le nom propre apparaît.

## 5. CSS

- Proposer un habillage CSS pour les documents.

**_Reprenez l'ensemble de l'exercice chez vous jusqu'à pouvoir naviguer correctement entre les quatre documents HTML. Cela vous sera utile pour le projet à rendre pour l'évaluation finale!_**