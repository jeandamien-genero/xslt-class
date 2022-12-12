# class1_exercices_correction

## Exercice n°1. Saint Julien l’hospitalier, II.

- Donner le chemin de la racine vers les paragraphes (`<p>`).

`/TEI/text/body/div/p`

- Donner le chemin de la racine vers `<author>` dans le `<sourceDesc>`.

`/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/author`

## Exercice n°2. Saint Julien l’hospitalier, II.

- Donner le chemin le plus court de la racine aux titres des chapitres (`<head>`).

`//div/head`

`//body/div/head`

`//body/div/child::head`

`//div/child::head`

`//div/p/preceding-sibling::head`

## Exercice n°3. 

- Utiliser un prédicat pour sélectionner les `<title>`ayant pour texte `Trois Comtes`.

`//title[@level="m"]`

- Utiliser un prédicat pour sélectionner le deuxième ou le cinquième paragraphe du premier chapitre (deux solutions).

`//div[@n="1"]/p[@n="1" or @n="5"]`

`//div[@n="1"]/p[position()=1 or position()=5]`

`//div[@n="1"]/descendant::p[position()=1 or position()=5]`

## Écriture d’une règle : `<xsl:template>`

- __(sur les slides)__ Appliquer une règle vide en sélectionnant la racine :

```xml
<xsl:template match="/">
</xsl:template>
```

- __(sur les slides)__ Appliquer la règle copy-of sur la racine :

```xml
<xsl:template match="/">
<xsl:copy-of select="."/>
</xsl:template>
```

- Comment copier le `<body>` dans l’output, mais sans le `<teiHeader>` ?

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="//teiHeader"/>
    <xsl:template match="//body">
        <xsl:copy-of select="."/>
    </xsl:template>
</xsl:stylesheet>
```
- Comment obtenir cet arbre en output ?

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no" encoding="UTF-8"/>
    <xsl:template match="/TEI/teiHeader"/>
    <xsl:template match="/TEI/text/body">
        <div>
            <head>Trois comtes</head>
            <xsl:copy-of select="./div"/>
        </div>
    </xsl:template>
</xsl:stylesheet>
```