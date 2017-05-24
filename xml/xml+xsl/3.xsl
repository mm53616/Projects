<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template match="/MUSE">
    <xsl:copy>
      <xsl:apply-templates select="muzycy"/>
      <xsl:element name="tworczosc">
        <xsl:apply-templates select="plyty/plyta"/>
      </xsl:element>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="muzycy">
    <xsl:copy>
      <xsl:apply-templates select="muzyk"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="muzyk">
    <xsl:element name="{imie}">
      <xsl:attribute name="{pseudonim}">ksywka</xsl:attribute>
      <xsl:element name="urodziny">
        <xsl:attribute name="ukonczone_lata">
          <xsl:value-of select="wiek"/>
        </xsl:attribute>
        <xsl:value-of select="data_urodzenia"/>
      </xsl:element>
      <xsl:element name="dane_muzyczne">
        <xsl:element name="instrumenty">
          <xsl:apply-templates select="instrument"/>
        </xsl:element>
        <xsl:copy-of select="funkcja"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="instrument">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="plyta">
    <xsl:element name="{nazwa}">
      <xsl:attribute name="ocena">
        <xsl:value-of select="ocena"/>
      </xsl:attribute>
      <xsl:element name="piosenki">
        <xsl:attribute name="liczba">
          <xsl:value-of select="l.piosenek"/>
        </xsl:attribute>
        <xsl:element name="dlugosc">
          <xsl:value-of select="czas_trwania"/>
        </xsl:element>
        <xsl:element name="singiel">
          <xsl:element name="nazwa">
            <xsl:value-of select="singiel"/>
          </xsl:element>
          <xsl:element name="rok">
            <xsl:value-of select="rok_wydania"/>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
