<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- LES BOUCLES EN XSLT: EXEMPLES -->
    
    <xsl:template match="/">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt/>
                    <publicationStmt/>
                    <sourceDesc>
                        <msDesc/>
                        <!-- EXEMPLE N°1: <XSL-FOR-EACH/> ET <XSL:SORT/> -->
                        
                        <xsl:for-each select="//biblStruct">
                            <xsl:sort select="monogr/imprint/date" data-type="number"/>
                            
                            <xsl:copy-of select="."/>
                            
                        </xsl:for-each>
                        
                        <!-- EXEMPLE N°2: <XSL-FOR-EACH-GROUP/> -->
                        <!--<listBibl>
                            
                            <xsl:for-each-group
                                select="//biblStruct"
                                group-by=".//author[1]/surname">
                                
                                <listBibl>
                                    <head>
                                        <xsl:value-of select=".//author[1]/surname"/>
                                    </head>
                                    
                                    <xsl:copy-of select="."/>
                                    
                                </listBibl>
                                
                            </xsl:for-each-group>
                            
                        </listBibl>-->
                        
                        <!--
                             EXEMPLE N°3: <XSL-FOR-EACH-GROUP/> ET CURRENT-GROUP()
                             même code que l'exemple n°2, mais en ajoutant
                             current-group() dans le  <xsl:copy-of/>
                        -->
                        <!--<listBibl>
                            
                            <xsl:for-each-group
                                select="//biblStruct"
                                group-by=".//author[1]/surname">
                                
                                <listBibl>
                                    <head>
                                        <xsl:value-of select=".//author[1]/surname"/>
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="count(current-group())"/> référence(s))
                                    </head>
                                    
                                    <xsl:copy-of select="current-group()"/>
                                    
                                </listBibl>
                                
                            </xsl:for-each-group>
                            
                        </listBibl>-->
                        
                        <!-- EXEMPLE N°4: <XSL-FOR-EACH-GROUP/> ET CURRENT-GROUPING-KEY() -->
                        <!--<listBibl>
                            
                            <xsl:for-each-group
                                select="//biblStruct"
                                group-by=".//author[1]/surname">
                                
                                <listBibl>
                                    <head>
                                        <xsl:value-of select="current-grouping-key()"/>
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="count(current-group())"/> référence(s))
                                    </head>
                                    
                                    <xsl:copy-of select="current-group()"/>
                                    
                                </listBibl>
                                
                            </xsl:for-each-group>
                            
                        </listBibl>-->
                    </sourceDesc>
                </fileDesc>
                <encodingDesc/>
                <profileDesc/>
                <revisionDesc/>
            </teiHeader>
            <text/>
        </TEI>
    </xsl:template>
</xsl:stylesheet>