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
    <xsl:variable name="apos">'</xsl:variable>
    
    <!--<xsl:variable name="witfile">
        <xsl:value-of select="replace(base-uri(class5_st_julien_hospitalier), '.xml', '')"/>
        <!-\- récupération du nom et du chemin du fichier courant -\->
    </xsl:variable>-->
    <xsl:variable name="chap1">
        <xsl:value-of select="concat('st_julien_chap1','.xml')"/>
        <!-- variable pour le contenu du premier chapitre  -->
    </xsl:variable>
    <xsl:variable name="chap2">
        <xsl:value-of select="concat('st_julien_chap2','.xml')"/>
        <!-- variable pour le contenu du deuxième chapitre  -->
    </xsl:variable>
    <xsl:variable name="index">
        <xsl:value-of select="concat('st_julien_index','.xml')"/>
        <!-- variable pour le contenu du deuxième chapitre  -->
    </xsl:variable>
    
    
    <!-- 3. ÉLÉMENT RACINE + TEIHEADER -->
    <!-- Sélection l'élément racine et travail sur le <teiHeader> -->
    <xsl:template match="/">
        <xsl:variable name="teiheader" >
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
        </xsl:variable>
        
        
        <!-- reproduction des balises <TEI>, <teiHeader> et <fileDesc> -->
        <xsl:result-document href="{$chap1}" method="xml" indent="yes">
            <TEI>
                <xsl:copy-of select="$teiheader"/>
                <xsl:apply-templates select="./TEI/text"/>
            </TEI>
        </xsl:result-document>
        
        <xsl:result-document href="{$chap2}" method="xml" indent="yes">
            <TEI>
                <xsl:copy-of select="$teiheader"/>
                <xsl:apply-templates select="./TEI/text" mode="chapter2"/>
            </TEI>
        </xsl:result-document>
        
        <xsl:result-document href="{$index}" method="xml" indent="yes">
            <TEI>
                <xsl:copy-of select="$teiheader"/>
                <text>
                    <body>
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
            </TEI>
        </xsl:result-document>
    </xsl:template>
    
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
                        <xsl:when test=".//title[@level='j']">
                            <xsl:value-of select=".//title[@level='j']"/>
                        </xsl:when>
                        <xsl:when test=".//title[@level='m']">
                            <xsl:value-of select=".//title[@level='m']"/>
                        </xsl:when>
                    </xsl:choose>
                </hi>
                <xsl:if test=".//ref">
                    <xsl:text> [</xsl:text><ref>
                        <xsl:attribute name="target">
                            <xsl:value-of select=".//ref[@type='URL']/@target"/>
                        </xsl:attribute>
                        en ligne</ref>
                    <xsl:if test=".//ref[@type='DOI']">
                        <xsl:text>, DOI : </xsl:text>
                        <ref>
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
                <xsl:value-of select=".//date"/>
                <xsl:if test=".//biblScope[@unit='page']">
                    <xsl:text>, p. </xsl:text><xsl:value-of select=".//biblScope[@unit='page']/@from"/><xsl:text>-</xsl:text><xsl:value-of select=".//biblScope[@unit='page']/@to"/>
                </xsl:if>
                <xsl:text>.</xsl:text>
            </bibl>
        </xsl:for-each>
    </xsl:template>
    
    <!-- 4. TEXTE -->
    <xsl:template match="//text">
        <text>
            <body>
                <div>
                    <head>Chapitre 1.</head>
                    <xsl:for-each select="//div[@n='1']/p">
                        <p><xsl:apply-templates select="."/></p>
                    </xsl:for-each>
                </div>
            </body>
        </text>
    </xsl:template>
    
    <xsl:template match="//text"  mode="chapter2">
        <!-- reproduction des balises <text> et <body> -->
        <text>
            <body>
                <div>
                    <head>Chapitre <xsl:value-of select="//div[@n='2']/head"/></head>
                    <xsl:apply-templates select="//div[@n='2']/p"/>
                </div>
            </body>
        </text>
    </xsl:template>
    <!-- reproduction des <p> avec numérotation continue + apply-templates pour les enfants -->
    <xsl:template match="//div[@n='2']/p">
        <p>
            <xsl:attribute name="n">
                <xsl:number count="//body/div/p" format="1" level="single"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    
    
    <!-- transformation des <hi> en <persName> ou <placename> selon le cas -->
    <xsl:template match="//hi">
        <xsl:variable name="xmlid">
            <xsl:value-of select="lower-case(replace(
                replace(current(), ' ', '_'),
                $apos,''))"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="./@rend='b'">
                <persName>
                    <xsl:attribute name="corresp">
                        <xsl:value-of select="$xmlid"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test=".[not(preceding-sibling::text())]">
                            <xsl:value-of select="replace(., 'Julien', 'Saint Julien')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="replace(., 'Julien', 'saint Julien')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </persName>
            </xsl:when>
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