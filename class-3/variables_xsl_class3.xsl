<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    <xsl:output indent="yes" method="xml" encoding="UTF-8" omit-xml-declaration="no"/>

    
    <!-- 1. EXEMPLE D'UTILISATION DES VARIABLES XSL -->
    <xsl:param name="booktitle" select="//titleStmt/title[@level='m']"/>
    <xsl:param name="parttitle" select="//titleStmt/title[@level='a']"/>
    <xsl:variable name="chap">Chapitre </xsl:variable>
    <xsl:variable name="num">n°</xsl:variable>
    
    <xsl:template match="/TEI">
        <xsl:copy>
            <xsl:copy-of select="./teiHeader"/>
            <text>
                <body>
                    <head>
                        <hi rend="i"><xsl:value-of select="$booktitle"/></hi>,
            <hi rend="i"><xsl:value-of select="$parttitle"/></hi>.
         </head>
                    <xsl:apply-templates select="//body/div"/>
                </body>
            </text>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//body/div">
        <div>
            <head>
                <xsl:value-of select="$chap"/> <xsl:value-of select="$num"/> <xsl:value-of select="./head"/>
            </head>
            <xsl:copy-of select="./p"/>
        </div>
    </xsl:template>
</xsl:stylesheet>