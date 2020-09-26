<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://qifstandards.org/xsd/qif2">

  <xsl:import href="CheckLibrary.xsl"/>

  <xsl:output method="xml" indent="yes" />

  <!-- skip text content -->
  <xsl:template match="text()" mode="Constraints" />

  <!-- SphericalDiameterCharacteristicActualKeyref -->
  <!-- TODO t:ExternalQIFReferences/t:ExternalQIFDocument in keys? -->
  <xsl:template match="t:Statistics/t:StatisticalStudiesResults/t:*/t:CharacteristicsStats/t:SphericalDiameterCharacteristicStats/t:ActualIds/t:Ids/t:Id
                     | t:Statistics/t:StatisticalStudiesResults/t:*/t:CharacteristicsStats/t:SphericalDiameterCharacteristicStats/t:Subgroup/t:ActualIds/t:Ids/t:Id"
                mode="Constraints">
    <xsl:if test="@xId">
      <xsl:variable name="xId" select="@xId"/>
      <xsl:variable name="idDoc" select="."/>
      <xsl:variable name="URI" select="/t:QIFDocument/t:ExternalQIFReferences/t:ExternalQIFDocument[@id = $idDoc]/t:URI"/>
      <xsl:for-each select="document($URI)/t:QIFDocument">
        <xsl:if test="not(count((t:MeasurementsResults/t:MeasurementResultsSet/t:MeasurementResults/t:MeasuredCharacteristics/t:CharacteristicActuals/t:SphericalDiameterCharacteristicActual)[@id = $xId]) = 1)">
          <xsl:call-template name="error_node">
            <xsl:with-param name="report">
              SphericalDiameterCharacteristicActualKeyref failed: URI = <xsl:value-of select="$URI"/>, idDoc = <xsl:value-of select="$idDoc"/>, xId = <xsl:value-of select="$xId"/>.
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
    </xsl:if>
    <xsl:apply-templates mode="Constraints"/>
  </xsl:template>
  
  <!-- Experimental -->
  <!-- <xsl:import href="CheckConstraints.xsl"/> -->

    <!-- Experimental -->
    <!--
    <xsl:element name="CheckConstraints">
      <xsl:apply-templates mode="Constraints"/>
    </xsl:element>
    -->

    <!--
  <CheckFormatParameters>
    <Check name="UnitVector">
      <Parameter name="ToleranceNorm">0.0001</Parameter>
    </Check>
  </CheckFormatParameters>
  <CheckQualityParameters>
    <Check name="G-CU-HD">
      <Parameter name="MaxDegree">8</Parameter>
    </Check>
    <Check name="G-CU-FG">
      <Parameter name="MaxNumSegments">200</Parameter>
    </Check>
    <Check name="G-CU-TI">
      <Parameter name="Tolerance">0.0001</Parameter>
    </Check>
  </CheckQualityParameters>
  -->

  <!-- ArcCircular13Core/Normal: unit vectors -->
  <!--<xsl:template match="//t:ArcCircular13Core" mode="Format">
    <xsl:variable name="ToleranceNorm">
      <xsl:value-of select="$CheckParameters/CheckFormatParameters/Check[@name='UnitVector']/Parameter[@name='ToleranceNorm']"/>
    </xsl:variable>
    <xsl:variable name="MinSquaredNorm">
      <xsl:value-of select="(1 - $ToleranceNorm)*(1 - $ToleranceNorm)"/>
    </xsl:variable>
    <xsl:variable name="MaxSquaredNorm">
      <xsl:value-of select="(1 + $ToleranceNorm)*(1 + $ToleranceNorm)"/>
    </xsl:variable>
    <xsl:variable name="ns">
      <xsl:value-of select="normalize-space(t:Normal)"/>
    </xsl:variable>
    <xsl:variable name="nx">
      <xsl:value-of select="substring-before($ns,' ')"/>
    </xsl:variable>
    <xsl:variable name="ny">
      <xsl:value-of select="substring-before(substring-after($ns,' '), ' ')"/>
    </xsl:variable>
    <xsl:variable name="nz">
      <xsl:value-of select="substring-after(substring-after($ns,' '), ' ')"/>
    </xsl:variable>
    <xsl:variable name="norm2">
      <xsl:value-of select="$nx*$nx + $ny*$ny + $nz*$nz"/>
    </xsl:variable>
    <xsl:if test="not(($norm2 &gt;= $MinSquaredNorm) and ($norm2 &lt;= $MaxSquaredNorm))">
      <xsl:for-each select=".">
        <xsl:call-template name="error_node">
          <xsl:with-param name="report">
            ArcCircular13Core: id=<xsl:value-of select="../@id"/>, Normal(<xsl:value-of select="$nx"/>,<xsl:value-of select="$ny"/>,<xsl:value-of select="$nz"/>), norm2(<xsl:value-of select="$norm2"/>) not in range [<xsl:value-of select="$MinSquaredNorm"/>, <xsl:value-of select="$MaxSquaredNorm"/>]
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:if>
    <xsl:apply-templates mode="Format"/>
  </xsl:template>-->

  <!-- TODO idMax -->
  <!-- TODO nurbs23: nWt == nCp -->
  <!-- TODO base64: check length -->
  <!-- TODO meshtriangle: nm size = vx size, nb size = tr.size -->
  <!-- TODO facemesh: colors size = triangles size, visible, hidden <= tr size -->
  <!-- TODO asmpath: check sequence of components -->

  <!-- Tiny Curve or segment (G-CU-TI) -->
  <!--<xsl:template match="//t:Segment13Core[../@id = 11]" mode="Quality">
    <xsl:variable name="Tolerance">
      <xsl:value-of select="$CheckParameters/CheckQualityParameters/Check[@name='G-CU-TI']/Parameter[@name='Tolerance']"/>
    </xsl:variable>
    <xsl:variable name="Tolerance2">
      <xsl:value-of select="number($Tolerance*$Tolerance)"/>
    </xsl:variable>
    <xsl:variable name="a">
      <xsl:value-of select="normalize-space(t:StartPoint)"/>
    </xsl:variable>
    <xsl:variable name="ax">
      <xsl:value-of select="substring-before($a,' ')"/>
    </xsl:variable>
    <xsl:variable name="ay">
      <xsl:value-of select="substring-before(substring-after($a,' '), ' ')"/>
    </xsl:variable>
    <xsl:variable name="az">
      <xsl:value-of select="substring-after(substring-after($a,' '), ' ')"/>
    </xsl:variable>
    <xsl:variable name="b">
      <xsl:value-of select="normalize-space(t:EndPoint)"/>
    </xsl:variable>
    <xsl:variable name="bx">
      <xsl:value-of select="substring-before($b,' ')"/>
    </xsl:variable>
    <xsl:variable name="by">
      <xsl:value-of select="substring-before(substring-after($b,' '), ' ')"/>
    </xsl:variable>
    <xsl:variable name="bz">
      <xsl:value-of select="substring-after(substring-after($b,' '), ' ')"/>
    </xsl:variable>
    <xsl:variable name="dist2">
      <xsl:value-of select="number(($bx - $ax)*($bx - $ax) + ($by - $ay)*($by - $ay) + ($bz - $az)*($bz - $az))"/>
    </xsl:variable>
    <xsl:if test="not($dist2 &gt; $Tolerance2)">
      <xsl:for-each select=".">
        <xsl:call-template name="error_node">
          <xsl:with-param name="report">
            Tiny Curve or segment (G-CU-TI): id=<xsl:value-of select="../@id"/>, dist2(<xsl:value-of select="$dist2"/>) &lt;= <xsl:value-of select="$Tolerance2"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:if>
    <xsl:apply-templates mode="Quality"/>
  </xsl:template>-->
  
  <!-- TODO Over-used vertex (G-SH-OU) -->
  <!-- TODO Over-Used Face (G-FA-OU) -->
  <!-- TODO Missing Part (G-PT-MI) -->
  <!-- TODO Over-used vertex (G-SH-OU) -->
  <!-- TODO Non-Graphical Annotation (A-AN-NG) -->

  <!-- PositionCharacteristicDefinition: if ZoneShape = DiametricalZone then  -->
  <!--<xsl:template match="/t:QIFDocument/t:Characteristics/t:CharacteristicNominals/t:PositionCharacteristicNominal" mode="Semantic">
    <xsl:variable name="idDefinition">
      <xsl:value-of select="t:CharacteristicDefinitionId"/>
    </xsl:variable>
    <xsl:variable name="ZoneShape">
      <xsl:value-of select="name(/t:QIFDocument/t:Characteristics/t:CharacteristicDefinitions/t:PositionCharacteristicDefinition[@id = $idDefinition]/t:ZoneShape/t:*[1])"/>
    </xsl:variable>
    <xsl:if test="1">
      <xsl:for-each select=".">
        <xsl:call-template name="error_node">
          <xsl:with-param name="report">
            PositionCharacteristicNominal: id=<xsl:value-of select="@id"/>, idDefinition(<xsl:value-of select="$idDefinition"/>), ZoneShape(<xsl:value-of select="$ZoneShape"/>)
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:if>
    <xsl:apply-templates mode="Semantic"/>
  </xsl:template>-->

  <!-- TODO CN Flatness -> FN Cylinder -->
  <!-- TODO CN without topology -->

</xsl:stylesheet>
