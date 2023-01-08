% __ENC/ XSLT/ Noeuds et axes XPath__
% Jean-Damien Généro
% 2023

---

## 1. Les noeuds

Pour XPath, un document XML est un "_tree of nodes_" ("arbre avec des noeuds"). Chaque noeud est une "étape" possible dans une expression XPath. Il y a sept types de noeud :

### 1.1 _Root node_

- Notation : `/`.
- Il contient l'ensemble du document ; c'est le seul noeud "orphelin" (il ne peut pas avoir de parent). On parle parfois du _document node_.
- À ne pas confondre avec l'élément racine (_root element_) d'un document XML : `<TEI>` est entièrement contenu dans le _root node_ tout en étant le seul _root element_ du document.

### 1.2 _Element nodes_

- Notation : `element()`.
- Les éléments (i. e. balises) du document XML, notés entre `< >`.

### 1.3 _Attribute Nodes_

- Notation : `attribute()`.
- Les attributs sont des balises XML. Le parent direct d'un _attribute node_ est forcément un _element node_.

### 1.4 _Text nodes_

- Notation : `text()`.
- Le texte d'un _element node_ ou d'un _attribute node_.

### 1.5 _Comment nodes_

- Notation : `comment()`.
- Les commentaires d'un document XML (notés entre `<!-- -->`).
- Le _comment node_ sélectionne le texte du commentaire sans les `<!-- -->`.

### 1.6 _Namespace nodes_

- Notation : _via_ l'axe `namespace::`.
- Les noms de domaine, généralement stockés dans des `xmlns:`. Cela signifie que dans `<TEI xmlns="http://www.tei-c.org/ns/1.0">`, `xmlns` n'est pas un `attribute node` mais un `namespace node`. On y accède par l'expression `/TEI/namespace::*`.
- Très peu utilisés en XSLT. 

### 1.7 _Processing instruction nodes_

- Notation : `processing-instruction()`.
- Les instructions de traitement XML (notées entre `<? ?>`) indiquent à une application comment traiter le document XML qu'elle lit.
- Elles possèdent un nom (`name()`) et une valeur (`string()`).
- Exemple : `<?xml-stylesheet href="exemple.xsl" type="text/xsl" title="Exemple"?>`.
- À ne pas confondre avec l'entête XML (`<?xml version="1.0" encoding="UTF-8"?>` au début du document).

---

## 2. Les axes

- Les axes (_axis_) permettent de s'émanciper de la direction de base _parent>enfant_ d'un chemin XPath ou précisant ou en changeant cette direction.
- Il y a treize axes.
- Ils se notent avec des `::` à la fin ; certains peuvent être abrégés.

### 2.1 _Child axis_

- Notation : `child::`.
- Sélection : la balise hiérarchiquement inférieure au noeud de contexte.
- Attention :
  - C'est l'axe par défaut, ce qui signie que `/child::TEI/child::teiHeader` est identique à `/TEI/teiHeader`.
  - Les `attribute nodes` et `namespace nodes` sont exclus de cet axe.

### 2.2 _Parent axis_

- Notation et abréviation : `child::` et `..` (deux points).
- Sélection : la balise hiérarchiquement supérieure au noeud de contexte.
- Exemples : `//fileDesc/parent::teiHeader` et `//fileDesc/..` sélectionnent le `<teiHeader>` depuis le `<fileDesc>`.

### 2.3 _Self axis_

- Notation et abréviation : `self::` et `.` (un point).
- Sélection : le noeud de contexte.

### 2.4 _Attribute axis_

- Notation et abréviation : `attribute::` et `@`.
- Sélection : les attributs du noeud de contexte.
- Attention : si le noeud de contexte est un _attribute node_, il n'y a pas d'axe attribut.
- Exemples : `//titleStmt/title/attribute::level` et `//titleStmt/title/@level` sélectionnent l'attribut `level` de `<title>`.

### 2.5 _Ancestor axis_

- Notation : `ancestor::`.
- Sélection : tous les noeuds entre la balise hiérarchiquement supérieure au noeud de contexte (= le parent) et le premier du document (= le _root node_).
- Exemple : `//titleStmt/title/ancestor::fileDesc/sourceDesc//author` sélectionne tous les `<author>` dans `<sourceDesc>` depuis `<title>`.

### 2.6 _Ancestor-or-self axis_

- Notation : `ancestor-or-self::`.
- Sélection : le noeud de contexte et _ancestor axis_.

### 2.7 _Descendant axis_

- Notation : `descendant::`.
- Sélection : tous les enfants du noeud de contexte, et leurs enfants, et ainsi de suite.
- Exemple : `//descendant::sourceDesc`.
- Attention : les `attribute nodes` et `namespace nodes` ne sont pas pris en compte par cet axe.

### 2.8 _Descendant-or-self axis_

- Notation : `descendant-or-self::`.
- Sélection : le noeud de contexte et _descendant-axis_
- Attention : les `attribute nodes` et `namespace nodes` ne sont pas pris en compte par cet axe.

### 2.9 _Preceding-sibling axis_

- Notation : `preceding-sibling::`.
- Sélection : tous les noeuds qui ont le même parent que le noeud de contexte et qui sont avant lui dans l'arbre.
- Exemples : `//sourceDesc/preceding-sibling::titleStmt` sélectionne le `<titleStmt>` depuis le `<sourceDesc>` ; `//sourceDesc/preceding-sibling::*` sélectionne le `<titleStmt>` et le `<publicationStmt>`.

### 2.9 _Following-sibling axis_

- Notation : `following-sibling::`.
- Sélection : tous les noeuds qui ont le même parent que le noeud de contexte et qui sont après lui dans l'arbre.
- Exemple : `//publicationStmt/following-sibling::sourceDesc` sélectionne le `<sourceDesc>` depuis le `<publicationStmt>`.

### 2.10 _Preceding axis_

- Notation : `preceding::`.
- Sélection : tous les noeuds qui précèdent le noeud de contexte, peu importe leur parent.
- Attention : les `ancestor`, les `attribute` et les `namespace` ne sont pas pris en compte.

### 2.12 _Following axis_

- Notation : `following::`.
- Sélection : tous les noeuds qui suivent le noeud de contexte, peu importe leur parent.
- Attention : les `ancestor`, les `attribute` et les `namespace` ne sont pas pris en compte.

### 2.13 _Namespace axis_
- Notation : `namespace::`.
- Sélection : les noms de domaine du noeud de contexte.
- Attention : ne fonctionne pas avec un _attribute node_.

---

## 3. Fonctions XPath

XPath possède des fonctions prédéfinies :

- Elles sont reconnaissables par leurs `()` finales ;
- Elles peuvent avoir un ou plusieurs arguments, ou ne pas en avoir du tout ;
- Dans XSLT, elles peuvent être utilisées dans les `@match` ou les `@select` ;
- Elles peuvent retourner : une valeur booléenne (`true` ou `false`), un nombre, une chaîne de caractères (`string`) ou une liste de noeuds (`nodeset`) ;
- Les opérateurs suivants sont utilisables avec les fonctions et prédicats XPath :
  - Opérateurs numériques : `+`, `-`, `*`, `div` (division), `mod` (modulo).
  - Opérateurs booléens : `<`, `<=`, `>`, `>=`, `=`, `!=`, `and`, `or`.

Sélection de fonctions :

### 3.1 `concat()`

- `concat(string1, string2, ...)` : retourne la concaténation de `string1` et `string2` (et plus).

### 3.2 `upper-case()` et `lower-case()`

- `upper-case(string)` : retourne `string` en haut-de-casse ;

- `lower-case(string)` : retourne `string` en bas-de-casse.

### 3.3 `translate()` et `replace()`

- `translate(string, 'abc', 'ABC')` : retourne `string` avec :
  - `a` remplacé par `A` ;
  - `b` remplacé par `B` ;
  - `c` remplacé par `c`.
  - _NB : le troisième paramètre n'a pas besoin d'être de la même taille que le deuxième. Avec `translate(string, 'abc', '')`, tous les  `a`, les `b` et les `c` seront enlevés de `string`._
  - Ce n'est pas l'équivalent d'un "rechercher/remplacer".

- `replace(string, abc, ABC)` : retourne `string` avec `abc` replacé par `ABC`.
  - Ce peut être considéré comme l'équivalent d'un "rechercher/remplacer".
  - Attention : ne fonctionne qu'à partir de XSLT version 2.

### 3.4 `contains()`

- `contains(string1, string2)` : retourne `true` ou `false` selon que `string1` contienne (`true`) ou ne contienne pas `string2` (`false`).

### 3.5 `starts-with()` et `ends-with()`

- `starts-with(string1, string2)` : retourne `true` ou `false` selon que `string1` commence (`true`) ou ne commence pas par `string2` (`false`) ;

- `ends-with(string1, string2)` : retourne `true` ou `false` selon que `string1` se termine (`true`) ou ne se termine pas par `string2` (`false`) ;

### 3.6 `not()`

- `not(arg)` : évalue `arg` et retourne la valeur opposée.
  - `\\title[not(@level = 'm')]` renvoie tous les `<title>` dont le `@level` n'a pas pour valeur `m` ainsi que ceux qui n'ont pas de `@n`.
  - _Attention : ce n'est pas l'équivalent de l'opérateur booléen `!=`. `\\title[@level != 'm')]` renvoie tous les `<title>` qui ont un `@level` dont la valeur n'est pas `m`._
  - Peut être combiné avec `contains()` sous la forme de `not(contains(..., ...))`.

### 3.7 `last()`, `position()` et `count()`

- _NB : dans XPath, la numérotation commence à `1`._

- `last( )` : évalue la taille d'un ensemble de balises.
  - Exemple d'utilisation : appliquer une règle à la dernière balise d'un ensemble. Ainsi, `//div/p[last()]` renvoie tous les `<p>` en dernière position dans les `<div>`.

- `position( )` : évalue la position d'une balise au sein de l'ensemble de balises auquel s'applique la règle courante.
  - Exemple d'utilisation : atteindre une balise en fonction de son emplacement. Ainsi, `//div/p[position() = 5]` renvoie tous les `<p>` en cinquième position dans les `<div>`.
  - `//div/p[position() = 5]` et `//div/p[5]` sont deux expressions identiques.
  - _Attention : `position( )` ne permet pas de déterminer la position de la balise par rapport à son parent._

- `count(arg)` : évalue le nombre de `node` et retourne ce nombre.
  - Le résultat est identique à `last()`, la différence étant que `count()` prend une expression XPath en argument.
  - Exemple d'utilisation : connaître le nombre total d'élément au sein d'un parent (comme le nombre de `<p>` au sein d'une `<div>`).
