% __ENC/ XSLT/ Exercices (séance 4)__
% Jean-Damien Généro
% 2025-2026

Écrire une feuille de style XSLT pour transformer le document XML-TEI extrait du *Journal de Jean Le Fèvre*. La transformation conservera le format XML-TEI en sortie.

## Question 4.1

- Reproduire sans changement les parties suivantes du document: `<titleStmt/>`, `<publicationStmt/>`, `<encodingDesc/>` et `<profileDesc/>`.

## Question 4.2

- Stocker dans une variable `$today` la date du jour grâce à une fonction XPath.
- Ajouter une balise `<change>` au `<revisionDesc>` avec un attribut `@when` contenant `$today`, et pour contenu "Modifications effectuées au cours de la quatrième séance par [votre nom]".

## Question 4.3

- Reproduire sans changement le `<msDesc/>`
- Trier les références bibliographiques (`<biblStruct>`) par date dans la section `<sourceDesc>`. Pour cela, vous pouvez utiliser:
  - `<xsl:for-each/>`.
  - `<xsl:sort/>`.

## Question 4.4

- Mettre les titres des chapitres (`<head>`) en majuscule.

## Question 4.5

- Numéroter les paragraphes dans chaque `<div>` en ajoutant un attribut `@n` aux balises `<p>`.

## Question 4.6

- Dans un nouvel élément `<div n="table-of-contents"/>`, créer une table des matières avec les titres des sections, et une numérotation en chiffres romains. Pour cela, vous pouvez utiliser:
  - `<xsl:apply-templates/>` et son attribut `@mode`.
  - `<xsl:for-each/>`.
  - `<xsl:number/>`.

Exemple:

```xml
<div n="table-of-contents">
    <head>Table des matières</head>
    <p>I. Jean Le Fèvre apprend la mort de Louis Ier</p>
    <p>II. Marie de Blois apprend la mort de Louis Ier</p>
</div>
```
## Question 4.7

- Dans un nouvel élément `<div n="index-noms"/>`, lister dans des balises `<p/>` tous les noms propres. Les noms propres qui doivent appraître correspondent au contenu des `@ref` des `<persName>`, dépourvu des signes `#` et où les `_` sont remplacés par des espaces. Chaque entrée d'index doit apparaître une seule fois.
  - `<xsl:apply-templates/>` et son attribut `@mode`.
  - `<xsl:for-each-group/>` et `current-grouping-key()`.
  - `<xsl:sort/>`.

Exemple:

```xml
         <div type="index-noms">
            <head>Index des noms propres</head>
            <p>Begut (Jean le)</p>
            <p>Berry (Jean de)</p>
            <p>Blois (Marie de)</p>
            <p>Bresille (Regnaut)</p>
            <p>Carnard (Jean)</p>
            <p>Corbic (Ernault de)</p>
            <p>Gastelet (Messager)</p>
            <p>Levraut (Thibaut)</p>
            <p>Orgemont (Pierre d')</p>
            <p>Pelerin (Jean)</p>
            <p>Anjou (Louis Ier)</p>
            <p>Avoir (Pierre, sg. de Chateaufromont)</p>
            <p>Craon (Guillaume de, sg. de la Ferté)</p>
            <p>Molins (Oudart de)</p>
            <p>Nades (Guillaume de)</p>
         </div>
```

## Question 4.8

- Faire de même avec les `<placeName>`, dans un nouvel élément `<div n="index-lieux"/>`, et avec `<head>Index des noms de lieux</head>`.