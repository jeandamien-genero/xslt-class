% __ENC/ XSLT/ En-tête XSL__
% Jean-Damien Généro
% 2024

À l'ouverture du fichier `XSLT Stylesheet` dans Oxygen, l'en-tête de la feuille de style se présente ainsi :

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
</xsl:stylesheet>
```

Il contient une déclaration XML et la balise `<xsl:stylesheet/>`. Cette dernière possède des espaces de nom (`xmlns`) et des attributs (`@exclude-result-prefixes` et `@version`).

La déclaration de plusieurs espaces de nom dans `<xsl:stylesheet/>` est nécessaire dans la mesure où la feuille de style mélange des éléments XSL, des éléments du document source et ceux du document de sortie. Le processeur doit pouvoir identifier les espaces de nom d'origine de ces éléments.


## 1. L'espace de nom XSL

- `xmlns:xsl="http://www.w3.org/1999/XSL/Transform"` est l'espace de nom XSL, auquel est associé le préfixe `xsl:`. Il est écrit au début de chaque balise appartenant à la recommandation XSL.

## 2. À déclarer : l'espace de nom du document source

### 2.1 Dcoument source XML basique

- Le document de base `XSLT Stylesheet` de Oxygen est paramétré pour transformer un document XML sans standard particulier (TEI, EAD, etc.).
- C'est la raison pour laquelle l'en-tête de ce document contient l'espace de nom XML `xmlns:xs="http://www.w3.org/2001/XMLSchema"` et l'exlusion de son préfixe `xs:` (`exclude-result-prefixes="xs"`).
- Ces éléments ne sont pas obligatoires pour transformer un document qui suit un standard.

### 2.2 Document source XML-TEI
- Si le document source est un document XML-TEI, l'espace de nom TEI (`tei`) doit être déclaré : `xmlns:tei="http://www.tei-c.org/ns/1.0"`.
- Il est dès lors possible d'écrire la feuille de style en mettant le préfixe `tei:` devant chaque balise dans le chemin XPath des `@match` ou `@select` des balises XSL.
- Pour ne pas avoir à déclarer le préfixe `tei:` dans les chemins XPath, deux éléments sont nécessaires :
  - Ajouter `xpath-default-namespace="http://www.tei-c.org/ns/1.0"`, afin d'informer le processeur que le document source suit le standard TEI.
  - Ajouter le préfixe `tei` dans `@exclude-result-prefixes`.

### 2.3 Document source XML-EAD

- Si le document source est un document XML-EAD, l'espace de nom EAD (`ead`) doit être déclaré : `xmlns:ead="http://ead3.archivists.org/schema/"`.
- Le principe est ensuite le même. Pour ne pas avoir à écrire le préfixe `ead:`
  - Ajouter `xpath-default-namespace="http://ead3.archivists.org/schema/"`
  - Ajouter `ead` à `@exclude-result-prefixes`.

## 3. L'espace de nom du document de sortie

- La déclaration de l'espace de nom du document de sortie est une bonne pratique ; elle se fait via l'attribut `@xmlns` : `xmlns="http://www.tei-c.org/ns/1.0"`.
- Cette déclaration est à adapter en fonction du type du document de sortie : _elle n'est pas nécessaire lorsqu'il s'agit d'un document html ou texte_.
