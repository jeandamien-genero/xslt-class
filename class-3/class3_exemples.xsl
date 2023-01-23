<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    <!-- 1. INSTRUCTION D'OUTPUT : XML -->
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    <!-- 2. VARIABLES ET PARAMÈTRES -->
    <xsl:param name="booktitle" select="//titleStmt/title[@level='m']"/>
    <xsl:variable name="parttitle" select="//titleStmt/title[@level='a']"/>
    <xsl:variable name="num">n°</xsl:variable>
    
    <!-- 3. REPRODUCTION DE L'ÉLÉMENT RACINE <TEI> -->
    <xsl:template match="/">
        <TEI>
            <xsl:apply-templates/>
        </TEI>
    </xsl:template>
    
    
    <!-- 4. REPRODUCTION DU <TEIHEADER> -->
    
    <!-- 4.1 reproduction du <teiHeader> -->
    <xsl:template match="//teiHeader">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- 4.2 reproduction du <fileDesc> -->
    <!-- NB : ajout d'un <editionStmt> entre le <titleStmt> et <publicationStmt> -->
    <xsl:template match="//fileDesc">
        <xsl:copy>
            <xsl:copy-of select="//titleStmt"/>
            <editionStmt>
                <edition>
                    Édition dans le cadre du M2 TNAH 2023.
                </edition>
                <respStmt>
                    <name>Jean-Damien Généro</name>
                    <resp>encodage</resp>
                </respStmt>
            </editionStmt>
            <xsl:copy-of select="//publicationStmt"/>
            <xsl:copy-of select="//sourceDesc"/>
        </xsl:copy>
    </xsl:template>
    
    
    <!-- 5. Le <TEXT> -->
    <xsl:template match="//text">
        <xsl:element name="text">
            <xsl:element name="body">
                <xsl:apply-templates/>
                <!-- ajout du 3e paragraphe -->
                <div n="3">
                    <head n="C">III.</head>
                    <p>Il s’en alla, mendiant sa vie par le monde.</p>
                    <p>Il tendait sa main aux cavaliers sur les routes, avec des génuflexions s’approchait des moissonneurs, ou restait immobile devant la barrière des cours ; et son visage était si triste que jamais on ne lui refusait l’aumône.</p>
                </div>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <!-- 5.1 reproduction des <div> et leur attribut @n -->
    <xsl:template match="//body/div">
        <xsl:variable name="headN"><xsl:value-of select="current()/head/@n"/></xsl:variable>
        <xsl:element name="div">
            <xsl:attribute name="n">
                <xsl:value-of select="./@n"/>
            </xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="//div/head">
        <head>
            <xsl:attribute name="n">
                <xsl:number level="any" format="A" count="//div[@n]/head"/>
            </xsl:attribute>
            <xsl:if test="parent::div[@n='1']">
                <xsl:value-of select="$parttitle"/><xsl:text>, </xsl:text><xsl:value-of select="$num"/>
            </xsl:if>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
    
    <!-- 5.3 reproduction des <p> avec ajout d'un @n dont la valeur change selon la place de la <div> supérieure -->
    <xsl:template match="//div[@n]/p">
        <xsl:variable name="numbering">
            <xsl:number count="//div[@n]/p" level="single" format="A"/>
        </xsl:variable>
        <xsl:variable name="num_div">
            <xsl:value-of select="parent::div/@n"/>
        </xsl:variable>
        <p>
            <xsl:attribute name="n">
                <xsl:choose>
                    <xsl:when test="parent::div[@n&lt;2]">
                        <xsl:value-of select="concat($num_div, '_', $numbering)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:number count="//div[@n]/p" level="single" format="I"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- 5.3 transformation des <hi> en <persName> ou <placename> selon la valeur de leur attribut -->
    <xsl:template match="//hi[@rend='b']">
        <persName>
            <xsl:attribute name="type">
                <xsl:value-of select="lower-case(replace(., ' ', '_' ))"/>
            </xsl:attribute>
            <xsl:value-of select="upper-case(.)"/>
        </persName>
    </xsl:template>
    <xsl:template match="//hi[@rend='i']">
        <placename>
            <xsl:value-of select="."/>
        </placename>
    </xsl:template>
</xsl:stylesheet>