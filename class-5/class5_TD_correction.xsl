<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    
    <!-- 1. INSTRUCTION D'OUTPUT : XML -->
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    <!-- 2. VARIABLE -->
    <!-- variable avec une apostrophe -->
    <xsl:variable name="apos">'</xsl:variable>
    
    <!-- 3. ÉLÉMENT RACINE + TEIHEADER -->
    <!-- Sélection l'élément racine et travail sur le <teiHeader> -->
    <xsl:template match="/">
        <!-- reproduction des balises <TEI>, <teiHeader> et <fileDesc> -->
        <TEI>
            <teiHeader>
                <fileDesc>
                    <!-- Reproduction des <titleStmt> et <publicationStmt> -->
                    <titleStmt>
                        <xsl:for-each select="//titleStmt/title">
                            <xsl:copy>  <!-- copie de la balise <title> -->
                                <xsl:attribute name="level">  <!-- ajout de l'@level -->
                                    <xsl:value-of select="./@level"/>
                                </xsl:attribute>
                                <!-- copie du texte de <title> dans un nouveau <title> -->
                                <title><xsl:value-of select="."/></title>
                                <!-- ajout de "par" -->
                                par
                                <!-- ajout d'un <persName avec pour valeur le texte de <author> -->
                                <persName><xsl:value-of select="parent::titleStmt/author"/></persName>
                                <!-- ajout entre () de la date de publication -->
                                (<xsl:value-of select="ancestor::fileDesc//sourceDesc/biblStruct//date"/>)
                            </xsl:copy> <!-- copie de la balise </title> -->
                        </xsl:for-each>
                    </titleStmt>
                    <xsl:copy-of select="//publicationStmt"/>
                    <sourceDesc>
                        <xsl:copy-of select="//sourceDesc/biblStruct"/>
                        <listBibl>
                            <xsl:apply-templates select="//listBibl"/>
                        </listBibl>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <!-- instruction pour que le processeur applique **uniquement** les règles qui concernent le <text> -->
            <xsl:apply-templates select="./TEI/text"/>
        </TEI>
    </xsl:template>
    
    <!-- EXERCICE SUR LA BIBLIOGRAPHIE -->
    <xsl:template match="//listBibl">
        <xsl:for-each select="./biblStruct">
            <xsl:sort select=".//surname"/>
            <bibl>
                <xsl:for-each select="./monogr/author/persName">
                    <!-- identité du ou des auteurs -->
                    <xsl:value-of select="upper-case(./surname)"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="./forename"/>
                    <xsl:text>, </xsl:text>
                </xsl:for-each>
                
                <!-- titres -->
                <!-- 1/ titre de l'article ou du chapitre -->
                <!-- titre de l'article entre guillemets français -->
                <xsl:text>&#171; </xsl:text>
                <xsl:apply-templates select=".//title[@level='a']"/>
                <xsl:text> &#187;, </xsl:text>
                <!-- 2/ titre du livre ou de la revue -->
                <xsl:if test=".//title[@level='m']">
                    <!-- si c'est une monographie, il y a "dans" avant le titre -->
                    <xsl:text>dans </xsl:text>
                </xsl:if>
                <hi>
                    <xsl:attribute name="rend">i</xsl:attribute>
                    <xsl:choose>
                        <!-- condition 1 = titre de revue -->
                        <xsl:when test=".//title[@level='j']">
                            <xsl:value-of select=".//title[@level='j']"/>
                        </xsl:when>
                        <!-- condition 2 = titre de monographie -->
                        <xsl:when test=".//title[@level='m']">
                            <xsl:value-of select=".//title[@level='m']"/>
                        </xsl:when>
                    </xsl:choose>
                </hi>
                <!-- si la référence est disponible en ligne (= s'il y a un <ref>) -->
                <xsl:if test=".//ref[@type='URL']">
                    <!-- ouverture des crochets et de la balise <ref> -->
                    <xsl:text> [</xsl:text><ref>
                        <xsl:attribute name="target">  <!-- <ref> a pour attribut @target avec l'URL -->
                            <xsl:value-of select=".//ref[@type='URL']/@target"/>
                        </xsl:attribute>
                        en ligne</ref> <!-- <ref a pour texte "en ligne" -->
                    <!-- condition dans la condition : s'il y a un DOI -->
                    <xsl:if test=".//ref[@type='DOI']">
                        <xsl:text>, DOI : </xsl:text> <!-- ajout d'une virgule et "DOI" -->
                        <ref>
                            <!-- création d'un <ref> avec en @target l'adresse du DOI (qui commence par https://doi.org/ -->
                            <xsl:attribute name="target">
                                <xsl:text>htpps://doi.org/</xsl:text><xsl:value-of select=".//ref[@type='DOI']/@target"/>
                            </xsl:attribute>
                            <xsl:value-of select=".//ref[@type='DOI']/@target"/></ref>
                    </xsl:if>]</xsl:if><xsl:text>, </xsl:text>
                <!-- si il y a un numéro de chapitre -->
                <xsl:if test=".//biblScope[@unit='chapter']">
                    chap. <xsl:value-of select=".//biblScope[@unit='chapter']/@n"/><xsl:text>, </xsl:text>
                </xsl:if>
                <!-- numéro de revue -->
                <xsl:if test=".//biblScope[@unit='issue']">
                    n°<xsl:value-of select=".//biblScope[@unit='issue']/@n"/><xsl:if test=".//biblScope[@unit='volume']">
                        -<xsl:value-of select=".//biblScope[@unit='volume']/@n"/></xsl:if><xsl:text>, </xsl:text>
                </xsl:if>
                <!-- date de la référence -->
                <xsl:value-of select=".//date"/>
                <!-- s'il y a un numéro de page (une référence est disponible uniquement en ligne -->
                <xsl:if test=".//biblScope[@unit='page']">
                    <xsl:text>, p. </xsl:text><xsl:value-of select=".//biblScope[@unit='page']/@from"/><xsl:text>-</xsl:text><xsl:value-of select=".//biblScope[@unit='page']/@to"/>
                </xsl:if>
                <!-- point final -->
                <xsl:text>.</xsl:text>
            </bibl>
            </xsl:for-each>
    </xsl:template>
    
    <!-- 4. TEXTE -->
    <xsl:template match="//text">
        <!-- reproduction des balises <text> et <body> -->
        <text>
            <body>
                <xsl:apply-templates/>
                <!-- AJOUT D'UNE <DIV> AVEC L'INDEX -->
                <div>
                    <head>Index</head>
                    <!-- BOUCLE N°1 : créer une <div> pour les individus et une autre pour les lieux -->
                    <xsl:for-each-group select=".//hi" group-by="./@rend">
                        <div>
                            <xsl:attribute name="type">
                                <xsl:choose>
                                    <xsl:when test="./@rend='b'">
                                        <xsl:text>name</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="./@rend='i'">
                                        <xsl:text>place</xsl:text>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:attribute>
                            <!-- BOUCLE N°2 : créer un seul <p> par entrée d'index -->
                            <xsl:for-each-group select="current-group()" group-by=".">
                                <p>
                                    <!-- ajout de l'attribut @corresp -->
                                    <xsl:attribute name="corresp">
                                        <xsl:text>#</xsl:text><xsl:value-of select="lower-case(replace(
                                            replace(current(), ' ', '_'),
                                            $apos,''))"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="."/> :
                                    <!-- BOUCLE N°3 : ajouter le n° de la ou des <div> où apparaissent les entrées d'index -->
                                    <xsl:for-each-group select="current-group()" group-by="ancestor::div">
                                        <xsl:value-of select="ancestor::div/@n"/>
                                        <xsl:if test="position()!= last()">, 
                                        </xsl:if><xsl:if test="position() = last()">.</xsl:if>
                                    </xsl:for-each-group>
                                </p>
                            </xsl:for-each-group>
                        </div>
                    </xsl:for-each-group>
                </div>
            </body>
        </text>
    </xsl:template>
    <!-- reproduction des <div>, avec numérotation + apply-templates pour les enfants -->
    <xsl:template match="//body/div">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:number count="//body/div" format="A" level="multiple"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <!-- copie conforme des <head> -->
    <xsl:template match="//head">
        <xsl:copy-of select="."/>
    </xsl:template>
    <!-- reproduction des <p> avec numérotation continue + apply-templates pour les enfants -->
    <xsl:template match="//div/p">
        <p>
            <xsl:attribute name="n">
                <xsl:number count="//body/div/p" format="1" level="any"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <!-- transformation des <hi> en <persName> ou <placename> selon le cas -->
    <xsl:template match="//hi">
        <!-- création d'une variable xmlid qui contient l'id du nom de lieu ou d'individu -->
        <xsl:variable name="xmlid">
            <!-- lower-case() permet de tout mettre en minuscule -->
            <!-- le premier raplace() enlève les apostrophes -->
            <!-- le deuxième replace() remplace les espaces par des _ -->
            <!-- le deuxième replace() est placé dans le premier de manière à faire les remplacements en série-->
            <xsl:value-of select="lower-case(replace(
                replace(current(), ' ', '_'),
                $apos,''))"/>
        </xsl:variable>
        <xsl:choose>
            <!-- condition n°1 : si c'est un <hi rend='b'>, création d'un <persName> -->
            <!-- avec un @corresp contenant la variable xmlid définie plus haut -->
            <xsl:when test="./@rend='b'">
                <persName>
                    <xsl:attribute name="corresp">
                        <xsl:value-of select="$xmlid"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <!-- si "Julien" est en début de phrase, il est remplacé par "Saint Julien" -->
                        <xsl:when test=".[not(preceding-sibling::text())]">
                            <xsl:value-of select="replace(., 'Julien', 'Saint Julien')"/>
                        </xsl:when>
                        <!-- si "Julien" est au milieu d'une phrase, il est remplacé par "saint Julien" -->
                        <xsl:otherwise>
                            <xsl:value-of select="replace(., 'Julien', 'saint Julien')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </persName>
            </xsl:when>
            <!-- condition n°2 : si c'est un <hi rend='i'>, création d'un <placename> -->
            <!-- avec un @corresp contenant la variable xmlid définie plus haut -->
            <xsl:when test="./@rend='i'">
                <placename>
                    <xsl:attribute name="corresp">
                        <xsl:value-of select="$xmlid"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </placename>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>