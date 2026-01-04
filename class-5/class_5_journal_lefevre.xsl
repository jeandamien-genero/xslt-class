<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:output method="html"/>
    
    <!-- VARIABLE CONTENANT LE HEAD DES DOCUMENTS HTML -->
    <xsl:variable name="head"><head>
            <meta charset="utf-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <link rel="preconnect" href="https://fonts.googleapis.com"/>
            <link rel="preconnect" href="https://fonts.gstatic.com" />
            <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100..900;1,100..900&amp;display=swap" rel="stylesheet"/>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
            <script src="https://openseadragon.github.io/openseadragon/openseadragon.min.js"></script>
            <title>Journal de Jean Le Fèvre</title>
            <style>
                #navbar > ul > li {
                    display: inline-block;
                    list-style: none;
                }
            </style>
    </head></xsl:variable>
    
    <!-- VARIABLE CONTENANT LE FOOTER -->
    <xsl:variable name="footer"><footer style="margin: 5em 0 0 0;">
            <hr/>
            <p>Site réalisé dans le cadre du cours de XSLT du Master TNAH de l'École nationale des chartes.</p>
    </footer></xsl:variable>
    
    <!-- VARIABLE CONTENANT LA NAVBAR -->
    <xsl:variable name="navbar">
        <div style="text-align: center;" id="navbar">
            <ul>
                <li><a href="home.html">Accueil</a> - </li>
                <!-- QUESTION N°1.1. À COMPLÉTER EN AJOUTER DES LIENS POUR LES QUATRE CHAPITRES ET L'INDEX -->
            </ul>
        </div>
    </xsl:variable>
    
    <!-- TEMPLATE QUI MATCHE LA RACINE ET APPELLE LES TEMPLATES -->
    <xsl:template match="/">
        <xsl:call-template name="home"/>
        <!-- À COMPLÉTER EN AJOUTANT LES <XSL:CALL-TEMPLATE/> POUR LES CHAPITRES ET L'INDEX -->
    </xsl:template>
    
    <!-- TEMPLATE CONTENANT LA PAGE D'ACCUEIL DU SITE -->
    <xsl:template name="home">
        <xsl:result-document href="out/home.html" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body style="margin: 2em 20em 5em 20em; font-family: 'Roboto', serif;">
                    <xsl:copy-of select="$navbar"/>
                    <h1 style="text-align: center;">Édition numérique du <em><xsl:value-of select="//titleStmt/title"/></em> de <xsl:value-of select="//titleStmt/author"/></h1>
                    
                    <div style="margin: 2em 0 2em 0;">
                        <p><!-- QUESTION N°1.2 --></p>
                    </div>
                    <div style="margin: 2em 0 2em 0;">
                        <h2>Informations sur le manuscrit:</h2>
                        <!-- QUESTION N°1.3 -->
                        <ul>
                            <li>Institution: ...</li>
                            <li>Cote: ...</li>
                            <li>Numérisation: ...</li>
                        </ul>
                    </div>
                    <div id="visioneuse">
                        <div id="_viewer" style="width: 100%; height: 800px;"></div>
                        <!-- QUESTION N°1.4 -->
                        <script type="text/javascript">
                            var _viewer = OpenSeadragon({
                            id: "_viewer",
                            prefixUrl: "https://openseadragon.github.io/openseadragon/images/",
                            sequenceMode: true,
                            tileSources:[
                            'https://gallica.bnf.fr/iiif/ark:/12148/btv1b9007462z/f39/info.json',
                            'https://gallica.bnf.fr/iiif/ark:/12148/btv1b9007462z/f40/info.json',
                            'https://gallica.bnf.fr/iiif/ark:/12148/btv1b9007462z/f41/info.json', 
                            ],
                            });
                        </script>
                    </div>
                    <div>
                        <h2>Chapitres disponibles:</h2>
                        <ul>
                            <!-- QUESTION N°1.5 -->
                        </ul>
                    </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>