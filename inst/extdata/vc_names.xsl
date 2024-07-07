<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:vt="http://viaf.org/viaf/terms#"
            xmlns:foaf="http://xmlns.com/foaf/0.1/"
            xmlns:owl="http://www.w3.org/2002/07/owl#"
            xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:void="http://rdfs.org/ns/void#"
            xmlns:ns1="http://viaf.org/viaf/terms#"
           xmlns:xs="http://www.w3.org/2001/XMLSchema"
           xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
           xmlns:fn = "http://www.w3.org/2005/xpath-functions"
           exclude-result-prefixes="vt foaf owl rdf void xs"
version="1.0" type="text" >

<xsl:output method="xml" encoding="UTF-8" />

<xsl:param name="viafrversion" />
<xsl:param name="now" />
<xsl:variable name="viafUpdate" select="/ns1:VIAFCluster/ns1:creationtime" />

<xsl:template match="ns1:VIAFCluster">
<xsl:variable name="viafID" select="ns1:viafID" />
<xsl:variable name="viafType" select="ns1:nameType" />
<names>
    <xsl:attribute name="viafid"><xsl:value-of select="$viafID" /></xsl:attribute>
    <xsl:attribute name="viafrVersion"><xsl:value-of select="$viafrversion" /></xsl:attribute>
    <xsl:attribute name="processDate"><xsl:value-of select="$now" /></xsl:attribute>
    <xsl:apply-templates select="ns1:mainHeadings/ns1:mainHeadingEl">
        <xsl:with-param name="viafID" select="$viafID" />
        <xsl:with-param name="viafType" select="$viafType" />
        <xsl:with-param name="preferred" select="'TRUE'" />
    </xsl:apply-templates>
    <xsl:apply-templates select="ns1:x400s/ns1:x400">
        <xsl:with-param name="viafID" select="$viafID" />
        <xsl:with-param name="viafType" select="$viafType" />
        <xsl:with-param name="preferred" select="'FALSE'" />
    </xsl:apply-templates>
</names>
</xsl:template>

<xsl:template match="ns1:x400s/ns1:x400">
    <xsl:param name="viafID"/>
    <xsl:param name="viafType" />
    <xsl:param name="preferred"/>
    <xsl:variable name="elemname" >
        <xsl:choose>
            <xsl:when test="contains(name(),':')" ><xsl:value-of select="substring-after(name(),':')" /></xsl:when>
            <xsl:otherwise><xsl:value-of select="name()" /></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="dispName" >
        <xsl:apply-templates select="ns1:datafield" mode="list"/>
    </xsl:variable>
    <xsl:variable name="normName" >
        <xsl:choose>
            <xsl:when test="ns1:datafield/ns1:normalized" >
                <xsl:value-of select="ns1:datafield/ns1:normalized" />
            </xsl:when>
            <xsl:otherwise><xsl:text disable-output-escaping="yes">&lt;NA&gt;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="tag" >
        <xsl:value-of select="ns1:datafield/@tag" />
    </xsl:variable>
    <xsl:variable name="linkcount" ><xsl:value-of select="count(ns1:links/ns1:link)" /></xsl:variable>
    <xsl:apply-templates select="ns1:sources/ns1:s" mode="naming" >
        <xsl:with-param name="viafID" select="$viafID" />
        <xsl:with-param name="viafType" select="$viafType" />
        <xsl:with-param name="heading" select="$elemname" />
        <xsl:with-param name="tag" select="$tag" />
        <xsl:with-param name="viafUpdate" select="$viafUpdate" />
        <xsl:with-param name="normName" select="$normName" />
        <xsl:with-param name="dispName" select="$dispName" />
        <xsl:with-param name="linkcount" select="$linkcount" />
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="ns1:mainHeadings/ns1:mainHeadingEl">
    <xsl:param name="viafID"/>
    <xsl:param name="viafType" />
    <xsl:param name="preferred"/>
    <xsl:variable name="dispName" >
        <xsl:apply-templates select="ns1:datafield" mode="list"/>
    </xsl:variable>
    <xsl:variable name="normName" >
        <xsl:choose>
            <xsl:when test="ns1:datafield/ns1:normalized" >
                <xsl:value-of select="ns1:datafield/ns1:normalized" />
            </xsl:when>
            <xsl:otherwise><xsl:text disable-output-escaping="yes">&lt;NA&gt;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="tag" >
        <xsl:value-of select="ns1:datafield/@tag" />
    </xsl:variable>
    <xsl:variable name="linkcount" ><xsl:value-of select="count(ns1:links/ns1:link)" /></xsl:variable>
    <xsl:apply-templates select="ns1:sources/ns1:s" mode="naming" >
        <xsl:with-param name="viafID" select="$viafID" />
        <xsl:with-param name="viafType" select="$viafType" />
        <xsl:with-param name="heading" select="'mainHeadingEl'" />
        <xsl:with-param name="tag" select="$tag" />
        <xsl:with-param name="viafUpdate" select="$viafUpdate" />
        <xsl:with-param name="normName" select="$normName" />
        <xsl:with-param name="dispName" select="normalize-space($dispName)" />
        <xsl:with-param name="linkcount" select="$linkcount" />
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="ns1:datafield" mode="list" >
    <xsl:variable name="index1"> 
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(@ind1)) &gt; 0"><xsl:value-of select="@ind1" /></xsl:when>
            <xsl:otherwise><xsl:text disable-output-escaping="yes">&lt;NA&gt;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="index2"> 
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(@ind2)) &gt; 0"><xsl:value-of select="@ind2" /></xsl:when>
            <xsl:otherwise><xsl:text disable-output-escaping="yes">&lt;NA&gt;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="'ind1'"/><xsl:text>={</xsl:text><xsl:value-of select="$index1" /><xsl:text>}</xsl:text>
    <xsl:text>,</xsl:text><xsl:value-of select="'ind2'"/><xsl:text>={</xsl:text><xsl:value-of select="$index2" /><xsl:text>}</xsl:text>
    <xsl:apply-templates select="ns1:subfield" mode="list" />
</xsl:template>

<xsl:template match="ns1:subfield" mode="list">
    <xsl:variable name="thiscode"><xsl:value-of select="@code" /></xsl:variable>
    <xsl:choose>
        <xsl:when test="preceding-sibling::subfield[@code = $thiscode]" >
            <xsl:text>,</xsl:text><xsl:text>{</xsl:text><xsl:value-of select="." /><xsl:text>}</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>;</xsl:text><xsl:value-of select="$thiscode" /><xsl:text>={</xsl:text><xsl:value-of select="." /><xsl:text>}</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="ns1:datafield" mode="copy" ><datafield>
        <xsl:attribute name="dtype" ><xsl:value-of select="@dtype" /></xsl:attribute>
        <xsl:attribute name="ind1" ><xsl:value-of select="@ind1" /></xsl:attribute>
        <xsl:attribute name="ind2" ><xsl:value-of select="@ind2" /></xsl:attribute>
        <xsl:attribute name="tag" ><xsl:value-of select="@tag" /></xsl:attribute>
        <xsl:apply-templates select="ns1:subfield" mode="copy"/>
    </datafield></xsl:template>

<xsl:template match="ns1:subfield" mode="copy">
    <subfield>
        <xsl:attribute name="code" ><xsl:value-of select="@code" /></xsl:attribute>
        <xsl:value-of select="." />
    </subfield>
</xsl:template>

<xsl:template match="ns1:sources/ns1:s" mode="naming" >
        <xsl:param name="viafID" />
        <xsl:param name="viafType" />
        <xsl:param name="heading" />
        <xsl:param name="tag"  />
        <xsl:param name="viafUpdate" />
        <xsl:param name="normName" />
        <xsl:param name="dispName" />
        <xsl:param name="linkcount" />
        <xsl:variable name="src"><xsl:value-of select="." /></xsl:variable>
    <row>
    <viafID ct="character"><xsl:value-of select="$viafID" /></viafID>
    <viafType ct="character"><xsl:value-of select="$viafType" /></viafType>
    <heading ct="character"><xsl:value-of select="$heading" /></heading>
    <tag ct="character"><xsl:value-of select="$tag" /></tag>
    <normName ct="character"><xsl:value-of select="$normName" /></normName>
    <dispName ct="list"><xsl:value-of select="$dispName" /></dispName>
    <source ct="character"><xsl:value-of select="$src" /></source>
    <linkcount ct="integer"><xsl:value-of select="$linkcount" /></linkcount>
    <viaf-update ct="POSIXct"><xsl:value-of select="$viafUpdate" /></viaf-update>
    <accessed ct="POSIXct"><xsl:value-of select="$now" /></accessed>
    </row>
</xsl:template>




</xsl:stylesheet>
