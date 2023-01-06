<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:output indent="yes" method="xml" encoding="UTF-8" omit-xml-declaration="no"/>
    
    <xsl:template match="//teiHeader">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="/TEI">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//text">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//body">
        <xsl:copy>
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//body/div[@n]">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- 1. UTILISATION DES CONDITIONS -->
    <!--<xsl:template match="//div[@n]/p">
        <p>
            <xsl:choose>
                <xsl:when test="parent::div/@n=2">
                    <xsl:attribute name="n">
                        <xsl:value-of select="count(preceding-sibling::p) + 1"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="xml:id">
                        chap1-<xsl:value-of select="count(preceding-sibling::p) + 1"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>-->
    
    <xsl:template match="//div[@n]/p">
        <p>
            
                §<xsl:value-of select="count(preceding-sibling::p) + 1"/><xsl:text>. </xsl:text>
            
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
</xsl:stylesheet>