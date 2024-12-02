<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    <!-- 1. INSTRUCTION D'OUTPUT : XML -->
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    <xsl:template match="/">
        <TEI>
            <xsl:apply-templates/>
        </TEI>
    </xsl:template>
    
    <xsl:template match="/TEI/teiHeader">
        <teiHeader>
            <xsl:apply-templates/>
        </teiHeader>
    </xsl:template>
    
    <xsl:template match="/TEI/teiHeader/fileDesc">
        <xsl:copy>
            <xsl:copy-of select="./titleStmt"/>
            <xsl:element name="editionStmt">
                <edition>
                    Édition dans le Master TNAH 2024
                </edition>
                <respStmt>
                    Jean-Damien Généro
                </respStmt>
            </xsl:element>
            <xsl:copy-of select="./publicationStmt"/>
            <xsl:copy-of select="./sourceDesc"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/TEI/text">
        <xsl:copy>
            <body>
                <xsl:apply-templates/>
                <div n="3">
                    <head n="C">III.</head>
                    <p>Il s’en alla, mendiant sa vie par le monde.</p>
                    <p>Il tendait sa main aux cavaliers sur les routes, avec des génuflexions s’approchait des moissonneurs, ou restait immobile devant la barrière des cours ; et son visage était si triste que jamais on ne lui refusait l’aumône.</p>
                </div>
            </body>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/TEI/text/body/div">
        <xsl:copy>
            <xsl:attribute name="n"><xsl:value-of select="./@n"/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/TEI/text/body/div/head">
        <head>
            <xsl:attribute name="n">
                <xsl:number level="any" format="A" count="//div/head"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </head>
    </xsl:template>
    
    <xsl:template match="/TEI/text/body/div/p">
        <xsl:element name="p">
            <xsl:attribute name="n">
                <xsl:number count="//div/p" format="1" level="single"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="/TEI/text/body/div/p/hi[@rend='b']">
        <persName>
            <xsl:apply-templates/>
        </persName>
    </xsl:template>
    
    <xsl:template match="/TEI/text/body/div/p/hi[@rend='i']">
        <placeName>
            <xsl:apply-templates/>
        </placeName>
    </xsl:template>
    
</xsl:stylesheet>