<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    
    <!-- 1. INSTRUCTION D'OUTPUT : XML -->
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    <!-- 2. VARIABLES -->
    <xsl:variable name="booktitle" select="upper-case(//titleStmt/title[@level='m'])"/>
    <xsl:variable name="chaptitle" select="replace(//titleStmt/title[@level='a'], 'Saint', 'saint')"/>
    
    <!-- 3. ÉLÉMENT RACINE + TEIHEADER -->
    <!-- Sélection l'élément racine et travail sur le <teiHeader> -->
    <xsl:template match="/">
        <!-- reproduction des balises <TEI>, <teiHeader> et <fileDesc> -->
        <TEI>
            <teiHeader>
                <fileDesc>
                    <!-- Reproduction de la balise <titleStmt>, appel des variables avec <value-of/> et copie du <author> -->
                    <titleStmt>
                        <title level='m'><xsl:value-of select="$booktitle"/></title>
                        <title level='a'><xsl:value-of select="$chaptitle"/></title>
                        <xsl:copy-of select="//titleStmt/author"></xsl:copy-of>
                    </titleStmt>
                    <!-- ajout du <editionStmt/> -->
                    <editionStmt>
                        <edition>Édition dans le cadre du M2 TNAH 2023.</edition>
                        <respStmt>
                            <name>Jean-Damien Généro</name>
                            <resp>encodage</resp>
                        </respStmt>
                    </editionStmt>
                    <!-- reproduction du <publicationStmt/> sans changement -->
                    <xsl:copy-of select="//publicationStmt"/>
                    <!-- reproduction du <sourceDesc/> -->
                    <!-- pour éviter d'avoir les commentaires qui sont après <listBibl!>, -->
                    <!-- on ne fait un <copy-of/> que pour les <biblStruct/> -->
                    <sourceDesc>
                        <xsl:copy-of select="//sourceDesc/biblStruct"/>
                        <listBibl>
                            <xsl:copy-of select="//listBibl/biblStruct"/>
                        </listBibl>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <!-- instruction pour que le processeur applique **uniquement** les règles qui concernent le <text> -->
            <xsl:apply-templates select="./TEI/text"/>
        </TEI>
    </xsl:template>
    
    <!-- 4. TEXTE -->
    <xsl:template match="//text">
        <!-- reproduction des balises <text> et <body> -->
        <text>
            <body>
                <!-- ajout d'un head et appel des variables -->
                <head><xsl:value-of select="$booktitle"/>, <xsl:value-of select="$chaptitle"/></head>
                <!-- instruction pour que le processeur applique les règles cocnernant les enfants de <text> -->
                <xsl:apply-templates/>
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
        <xsl:choose>
            <xsl:when test="./@rend='b'">
                <persName>
                    <xsl:choose>
                        <!-- le but est de remplacer "Julien" par "saint Julien" -->
                        <!-- mais on ajoute une condition pour dire au processeur -->
                        <!-- "si le preceding-sibling de <hi rend="b"/> n'est pas du text(), -->
                        <!-- (c'est-à-dire quand il est en début de phrase) -->
                        <!-- alors ajoute une majuscule à saint." -->
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
                    <xsl:value-of select="."/>
                </placename>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>