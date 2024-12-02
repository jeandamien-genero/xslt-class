% __ENC/ XSLT/ Exercice (séance 3)__
% Jean-Damien Généro
% 2024-2025

# Environnement de travail
- Document XML : `class_3_journal_lefevre.xml`.
- Document XSL :
  - Ouvrir une feuille de style XSLT dans Oxygen.
  - Compléter son en-tête et ajouter l'instruction d'output avec XML comme méthode.

# Consignes
## 1/ Les variables
- écrire le contenu du `<title>` en majuscule. Stocker cette balise dans une variable `$booktitle`.
- enlever la majuscule à "Le" dans le "Jean Le Fèvre" de `<author>`. Stocker le résultat dans une variable `$author`.
- créer une variable `$today` pour stocker la date du jour.

## 2/ Le `<teiHeader>`
- Dans le `<titleStmt>` : reproduire les balises `<title>` et `<author>`, mais en changeant leurs textes par le contenu des variables définies précédemment.
- Ajouter un `<editionStmt/>` (avec `<edition/>` et `<respStmt/>`).
- Compléter le `<revisionDesc>` avec un nouveau `<change>`, dont l'attribut `@when` doit contenir la `$today`.
- Reproduire les autres balises sans changement.

## 3/ Le `<text>`
- Ajouter dans le `<body>` une balise `<head>` avec pour contenu : "`<hi rend="i">$booktitle</hi>` de `$author`".
- Changer le format de numérotation des `<div>`.
- Numéroter les paragraphes en continu.
- Appliquer une condition aux `<hi>` pour :
  - Transformer en `<placename>` ceux qui ont un `@rend="i"`.
  - Transformer en `<persName>` ceux qui ont un `@rend="b"`.

- Ajouter les extraits suivants :
```xml
<div n="3">
  <head n="C">Jean Le Fèvre nommé chancelier de Marie de Blois.</head>
  <p>Samedi ensuivant, V jour de novembre, Madame me retint son chancelier,
  present messire Guillaume de Craon segneur de la Ferté Bernard, et maistre
  Jehan Haucepié a qui lettre en fu commandée. Et fis serment in verbo pontificis
  et sacerdotis,
  de la servir loyalment en office de chancelier, et la conseiller contre
  toulx exceptés le pape et le roy, et son honneur et pourfit garder et son blasme
  et damage eschever; mais elle ne me bailla point son seel encore.</p>
</div>
<div n="4">
  <head n="D">La lettre du duc de Berry.</head>
  <p>Lundi VIIe jour de novembre monsegneur de Berri escript au conseil que
  monsegneur de Bourgongne se estoit excusé de venir devers Madame; mes li
  monsegneur de Berry y seroit le samedi ensuivant.</p>
</div>
```

