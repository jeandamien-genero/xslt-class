<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    
    <!-- 1. INSTRUCTION D'OUTPUT : XML -->
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    <!-- VARIABLES -->
    <xsl:variable name="booktitle" select="upper-case(//titleStmt/title[@level='m'])"/>
    <xsl:variable name="chaptitle" select="replace(//titleStmt/title[@level='a'], 'Saint', 'saint')"/>    
    
    <!-- Reproduction de l'élément racine -->
    <xsl:template match="/">
        <TEI>
            <xsl:apply-templates/>
        </TEI>
    </xsl:template>
    
    <!-- Reproduction du teiHeader -->
    <xsl:template match="//teiHeader">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Reproduction du filedesc et du titleStmt -->
    <xsl:template match="//fileDesc">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="//titleStmt">
        <titleStmt>
            <title level='m'><xsl:value-of select="$booktitle"/></title>
            <title level='a'><xsl:value-of select="$chaptitle"/></title>
            <xsl:copy-of select="//titleStmt/author"></xsl:copy-of>
        </titleStmt>
    </xsl:template>
    
</xsl:stylesheet>