<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="3.0" >

<!-- DOCTYPE -->
<xsl:output 
    method="xml"
    doctype-public="-//NLM//DTD Journal Publishing DTD v3.0 20070202//EN"
    doctype-system="journalpublishing.dtd"
    indent="yes"
    encoding="UTF-8"
/>

<!-- ARTICLE (MAIN) -->
<xsl:template match="article">
    <article article-type="{@typeart}" xmlns:xlink="http://www.w3.org/1999/xlink">
        <front>
        <journal-meta>
        <journal-id journal-id-type="hwp"><xsl:value-of select="//admin/revue/titrerevabr"/></journal-id>
        <journal-id journal-id-type="publisher-id"><xsl:value-of select="//admin/revue/titrerevabr"/></journal-id>
        <journal-title><xsl:value-of select="//admin/revue/titrerev"/></journal-title>
        <issn pub-type="ppub"><xsl:value-of select="//admin/revue/idissn"/></issn>
        <publisher>
        <publisher-name><xsl:value-of select="//admin/editeur/nomorg"/></publisher-name></publisher>
        </journal-meta>
        <article-meta>
        <article-categories>
        <subj-group>
        <subject><xsl:value-of select="//admin/infoarticle/section_sommaire"/></subject>
        </subj-group>
        </article-categories>
        <xsl:apply-templates select="//liminaire/grtitre"/>
        <xsl:apply-templates select="//liminaire/grauteur"/>
        <xsl:apply-templates select="//admin/numero/pub"/>
        <xsl:apply-templates select="//admin/numero/volume"/>
        <issue></issue>
        <xsl:apply-templates select="//admin/infoarticle/pagination/ppage"/>
        <xsl:apply-templates select="//admin/infoarticle/pagination/dpage"/>
        <permissions>
        <xsl:apply-templates select="//admin/droitsauteur"/>
        </permissions>
        <xsl:apply-templates select="//liminaire/resume"/>
        <counts>
        <xsl:apply-templates select="//admin/infoarticle/nbpage"/>
        <xsl:apply-templates select="//admin/infoarticle/nbpara"/>
        <xsl:apply-templates select="//admin/infoarticle/nbmot"/>
        <xsl:apply-templates select="//admin/infoarticle/nbfig"/>
        <xsl:apply-templates select="//admin/infoarticle/nbtabl"/>
        <xsl:apply-templates select="//admin/infoarticle/nbimage"/>
        <xsl:apply-templates select="//admin/infoarticle/nbaudio"/>
        <xsl:apply-templates select="//admin/infoarticle/nbvideo"/>
        <xsl:apply-templates select="//admin/infoarticle/nbrefbiblio"/>
        <xsl:apply-templates select="//admin/infoarticle/nbnote"/>
        </counts>
        </article-meta>
        </front>
        <xsl:apply-templates select="corps"/>
        <xsl:apply-templates select="partiesann"/>
    </article>
</xsl:template>

<!-- FRONT -->

<xsl:template match="//liminaire/grtitre">
    <title-group>
    <xsl:apply-templates select="//grtitre/titre"/>
    <xsl:apply-templates select="titreparal"/>
    <xsl:apply-templates select="sstitre"/>
    </title-group>
</xsl:template>

<xsl:template match="//grtitre/titre">
    <article-title xml:lang="fr">
        <xsl:apply-templates/>
    </article-title>
</xsl:template>

<xsl:template match="titreparal">
    <trans-title xml:lang="en">
        <xsl:apply-templates/>
    </trans-title>
</xsl:template>

<xsl:template match="sstitre">
    <subtitle>
        <xsl:apply-templates/>
    </subtitle>
</xsl:template>

<xsl:template match="//liminaire/grauteur">
    <contrib-group>
    <xsl:apply-templates select="auteur"/>
    </contrib-group>
</xsl:template>

<xsl:template match="auteur">
    <contrib contrib-type="author"><xsl:apply-templates select="nompers"/><xref ref-type="aff" rid="{@id}"/><aff id="{@id}"><xsl:apply-templates select="affiliation"/><xsl:apply-templates select="courriel"/></aff></contrib>
</xsl:template>

<xsl:template match="nompers">
    <name><surname><xsl:copy-of select="nomfamille/text()" /></surname><given-names><xsl:copy-of select="prenom/text()" /></given-names></name>
</xsl:template>

<xsl:template match="affiliation">
    <xsl:for-each select="alinea">
    <institution><xsl:apply-templates/></institution>
    </xsl:for-each>
</xsl:template>

<xsl:template match="courriel">
    <email><xsl:apply-templates/></email>
</xsl:template>

<xsl:template match="//admin/numero/pub">
    <pub-date><month><xsl:value-of select="periode"/></month><year><xsl:value-of select="annee"/></year></pub-date>
</xsl:template>

<xsl:template match="//admin/numero/volume">
    <volume><xsl:value-of select="current()"/></volume>
</xsl:template>

<xsl:template match="//admin/infoarticle/pagination/ppage">
    <fpage><xsl:value-of select="current()"/></fpage>
</xsl:template>

<xsl:template match="//admin/infoarticle/pagination/dpage">
    <lpage><xsl:value-of select="current()"/></lpage>
</xsl:template>

<xsl:template match="//admin/droitsauteur">
    <copyright-statement><xsl:value-of select="substring(current(),1,2)"/><xsl:value-of select="nomorg"/></copyright-statement>
    <copyright-year><xsl:value-of select="translate(.,translate(., '0123456789', ''), '')"/></copyright-year>
</xsl:template>

<xsl:template match="//liminaire/resume">
    <xsl:choose>
        <xsl:when test="@lang!='en'">
            <abstract xml:lang="fr"><xsl:apply-templates/></abstract>
        </xsl:when>
        <xsl:otherwise>
            <trans-abstract xml:lang="en"><xsl:apply-templates/></trans-abstract>
        </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template match="//admin/infoarticle/nbpage">
    <page-count><xsl:value-of select="current()"/></page-count>
</xsl:template>

<xsl:template match="//admin/infoarticle/nbpara">
    <para-count><xsl:value-of select="current()"/></para-count>
</xsl:template>

<xsl:template match="//admin/infoarticle/nbmot">
    <nbmot-count><xsl:value-of select="current()"/></nbmot-count>
</xsl:template>

<xsl:template match="//admin/infoarticle/nbfig">
    <fig-count><xsl:value-of select="current()"/></fig-count>
</xsl:template>

<xsl:template match="//admin/infoarticle/nbtabl">
    <table-count><xsl:value-of select="current()"/></table-count>
</xsl:template>

<xsl:template match="//admin/infoarticle/nbimage">
    <image-count><xsl:value-of select="current()"/></image-count>
</xsl:template>

<xsl:template match="//admin/infoarticle/nbaudio">
    <audio-count><xsl:value-of select="current()"/></audio-count>
</xsl:template>

<xsl:template match="//admin/infoarticle/nbvideo">
    <video-count><xsl:value-of select="current()"/></video-count>
</xsl:template>

<xsl:template match="//admin/infoarticle/nbrefbiblio">
    <ref-count><xsl:value-of select="current()"/></ref-count>
</xsl:template>

<xsl:template match="//admin/infoarticle/nbnote">
    <ennote-count><xsl:value-of select="current()"/></ennote-count>
</xsl:template>

<!-- BODY -->

<xsl:template match="corps">
    <body>
        <xsl:apply-templates/>
    </body>
</xsl:template>

<xsl:template match="section1">
    <h1>
        <xsl:apply-templates/>
    </h1>
</xsl:template>

<xsl:template match="section2">
    <h2>
        <xsl:apply-templates/>
    </h2>
</xsl:template>

<xsl:template match="section3">
    <h3>
        <xsl:apply-templates/>
    </h3>
</xsl:template>

<xsl:template match="section4">
    <h4>
        <xsl:apply-templates/>
    </h4>
</xsl:template>

<xsl:template match="section5">
    <h5>
        <xsl:apply-templates/>
    </h5>
</xsl:template>

<xsl:template match="section6">
    <h6>
        <xsl:apply-templates/>
    </h6>
</xsl:template>

<xsl:template match="section7">
    <h7>
        <xsl:apply-templates/>
    </h7>
</xsl:template>

<xsl:template match="section8">
    <h8>
        <xsl:apply-templates/>
    </h8>
</xsl:template>

<xsl:template match="titre">
    <title>
        <xsl:apply-templates/>
    </title>
</xsl:template>

<xsl:template match="para">
    <p>
        <xsl:apply-templates/>
    </p>
</xsl:template>

<xsl:template match="encadre">
    <boxed-text>
    <sec>
        <xsl:apply-templates/>
    </sec>
    </boxed-text>
</xsl:template>

<xsl:template match="listenonord">
    <list list-type="bullet">
        <xsl:apply-templates/>
    </list>
</xsl:template>

<xsl:template match="listeord">
    <list list-type="order">
        <xsl:apply-templates/>
    </list>
</xsl:template>

<xsl:template match="elemliste">
    <list-item>
        <xsl:apply-templates/>
    </list-item>
</xsl:template>

<xsl:template match="tableau">
    <fig id="{@id}">
        <xsl:apply-templates select = "no" />
        <xsl:apply-templates select = "legende" />
        <xsl:apply-templates select = "objetmedia/image" />
        <xsl:apply-templates select = "notefig" />
    </fig>
</xsl:template>

<xsl:template match="figure">
    <fig id="{@id}">
        <xsl:apply-templates select = "no" />
        <xsl:apply-templates select = "legende" />
        <xsl:apply-templates select = "objetmedia/image" />
        <xsl:apply-templates select = "notefig" />
    </fig>
</xsl:template>

<xsl:template match="legende">
    <caption>
        <xsl:apply-templates select="titre"/>
        <p>
        <xsl:apply-templates select="node() except titre" />
        </p>
    </caption>
</xsl:template>

<xsl:template match="objetmedia/image">
    <graphic xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="{@xlink:href}">

    </graphic>
</xsl:template>

<xsl:template match="notefig">
    <p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="marquage[@typemarq='gras']">
    <bold>
        <xsl:apply-templates/>
    </bold>
</xsl:template>

<xsl:template match="marquage[@typemarq='italique']">
    <italic>
        <xsl:apply-templates/>
    </italic>
</xsl:template>

<xsl:template match="exposant">
    <sup>
        <xsl:apply-templates/>
    </sup>
</xsl:template>

<xsl:template match="indice">
    <sub>
        <xsl:apply-templates/>
    </sub>
</xsl:template>

<xsl:template match="no">
    <label>
        <xsl:apply-templates/>
    </label>
</xsl:template>

<xsl:template match="liensimple[not(parent::courriel)][not(matches(text(), '.*@.*', 's'))]">
    <uri>
        <xsl:apply-templates/>
    </uri>
</xsl:template>

<!-- BACK -->

<xsl:template match="partiesann">
    <back>
        <xsl:apply-templates/>
    </back>
</xsl:template>

<xsl:template match="biblio">
    <ref-list>
        <xsl:apply-templates/>
    </ref-list>
</xsl:template>

<xsl:template match="refbiblio">
    <ref id="{@id}">
        <xsl:apply-templates/>
    </ref>
</xsl:template>

<xsl:template match="grnote">
    <fn-group>
        <xsl:apply-templates/>
    </fn-group>
</xsl:template>

<xsl:template match="note">
    <fn>
        <xsl:apply-templates/>
    </fn>
</xsl:template>

</xsl:stylesheet>