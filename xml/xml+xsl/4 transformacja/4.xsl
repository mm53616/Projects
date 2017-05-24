<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:output method="xml" encoding="utf-8"/>

  <xsl:template match="/">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="I_strona"
                            page-height="29.7cm" page-width="21cm"
                            margin-top="8cm" margin-bottom="2.5cm"
                            margin-left="3cm" margin-right="3cm">
          <fo:region-body margin-top="2.5cm" />
        </fo:simple-page-master>
        <fo:simple-page-master master-name="strona"
                            page-height="29.7cm" page-width="21cm"
                            margin-top="1cm" margin-bottom="1cm"
                            margin-left="1.5cm" margin-right="1.5cm">
          <fo:region-body margin-top="2cm" />
          <fo:region-before extent="50mm"/>
          <fo:region-after extent="50mm"/>
        </fo:simple-page-master>
		 <fo:simple-page-master master-name="strona_ostatnia"
                            page-height="29.7cm" page-width="21cm"
                            margin-top="3cm" margin-bottom="3cm"
                            margin-left="1cm" margin-right="1cm">
          <fo:region-body margin-top="2cm" />
          <fo:region-before extent="10mm"/>
          <fo:region-after extent="10mm"/>
        </fo:simple-page-master>
		
        <fo:page-sequence-master master-name="kolejnosc">
          <fo:repeatable-page-master-alternatives>
            <fo:conditional-page-master-reference  master-reference="I_strona" page-position="first"/>
            <fo:conditional-page-master-reference master-reference="strona" page-position="rest"/>
			<fo:conditional-page-master-reference master-reference="strona_ostatnia" page-position="last"/>
          </fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
      </fo:layout-master-set>
      
      <fo:page-sequence master-reference="I_strona">
        <fo:flow flow-name="xsl-region-body">
         <fo:block font-size="65pt" color="red" text-align="center" font-family="georgia">
          Moje hobby
        </fo:block>
        <fo:block font-size="45pt" color="#0066ff" text-align="center" font-family="georgia">
          Zespol MUSE
        </fo:block>

        <fo:block text-align="center" margin-top="2cm">
               <fo:external-graphic src="{MUSE/@grafika}" width="4cm" height="2cm"/>
        </fo:block>
        </fo:flow>
      </fo:page-sequence>

      <fo:page-sequence master-reference="strona">
        <xsl:call-template name="naglowek"/>
        <xsl:call-template name="numer_strony"/>
        <fo:flow flow-name="xsl-region-body">
				 <fo:block  text-align="justify" font-size="10pt" >
	   <xsl:apply-templates select="MUSE/muzycy/muzyk"/>
          </fo:block>
          <fo:block  text-align="justify" font-size="10pt" >
	  <xsl:apply-templates select="MUSE/plyty"/>
	  </fo:block>
        </fo:flow>
      </fo:page-sequence>


      <fo:page-sequence master-reference="strona_ostatnia">
        <xsl:call-template name="naglowek"/>
        <xsl:call-template name="numer_strony"/>
        <fo:flow flow-name="xsl-region-body">
          <fo:block  text-align="left"  font-size="10pt" >
		    <xsl:apply-templates select="MUSE/trasy/trasa"/>	
          </fo:block>
        </fo:flow>
      </fo:page-sequence>

    </fo:root>
  </xsl:template>


    <xsl:template name="naglowek">
    <fo:static-content flow-name="xsl-region-before">
      <fo:block   text-align="center" font-family="Georgia" color="grey" font-size="25pt"  text-decoration="underline">
        Moje hobby
      </fo:block>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="numer_strony">
    <fo:static-content flow-name="xsl-region-after">
      <fo:block  text-align="center" font-size="10pt">
        Strona <fo:page-number />
      </fo:block>
    </fo:static-content>
  </xsl:template>


  <xsl:template match="opis">
      <fo:block >
      <fo:leader leader-length="170mm" leader-pattern="rule" rule-thickness="3pt" color="green"/>
    </fo:block>
    <fo:block font-size="20pt" font-family="Georgia" color="#0066ff">
      <xsl:value-of select="nazwa"/>
      <xsl:text> </xsl:text>
	  <xsl:value-of select="rok_zalozenia"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="styl"/>
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="pochodzenie"/>
	  <xsl:text> </xsl:text>
    </fo:block>
  </xsl:template>

<xsl:template match="plyty">

	  <fo:block >
      <fo:leader leader-length="180mm" leader-pattern="rule" rule-thickness="0.05pt" color="grey"/>
    </fo:block>

    <fo:block text-align="center">
      <fo:table>
        <fo:table-column column-width="30mm"/>
        <fo:table-column column-width="30mm"/>
        <fo:table-column column-width="30mm"/>
        <fo:table-column column-width="30mm"/>
        <fo:table-column column-width="30mm"/>
	    	<fo:table-column column-width="30mm"/>

        <fo:table-header>
          <fo:table-row>
             <fo:table-cell border="solid black 3px" background-color="#FF4000">
              <fo:block font-weight="bold">Plyta</fo:block>
            </fo:table-cell>
            <fo:table-cell border="solid black 3px" background-color="#FF4000">
              <fo:block font-weight="bold">Liczba piosenek</fo:block>
            </fo:table-cell>
            <fo:table-cell border="solid black 3px" background-color="#FF4000">
              <fo:block font-weight="bold">Singiel</fo:block>
            </fo:table-cell>
 <fo:table-cell border="solid black 3px" background-color="#FF4000">
              <fo:block font-weight="bold">Rok wydania</fo:block>
            </fo:table-cell>
 <fo:table-cell border="solid black 3px" background-color="#FF4000">
              <fo:block  font-weight="bold">Czas trwania</fo:block>
            </fo:table-cell>
 <fo:table-cell border="solid black 3px" background-color="#FF4000">
              <fo:block  font-weight="bold">Ocena</fo:block>
            </fo:table-cell>
 
          </fo:table-row>
        </fo:table-header>

       
          <fo:table-body>
            <xsl:for-each select="plyta">
              <fo:table-row>
                    <fo:table-cell border="solid black 3px" background-color="#F7FE2E">
                  <fo:block>
                    <xsl:value-of select="nazwa"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell border="solid black 3px" background-color="#F7FE2E">
                  <fo:block>
                    <xsl:value-of select="l.piosenek"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell border="solid black 3px" background-color="#F7FE2E">
                  <fo:block>
                    <xsl:value-of select="singiel"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell border="solid black 3px" background-color="#F7FE2E">
                  <fo:block>
                    <xsl:value-of select="rok_wydania"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell border="solid black 3px" background-color="#F7FE2E">
                  <fo:block>
                    <xsl:value-of select="czas_trwania"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell border="solid black 3px" background-color="#F7FE2E">
                  <fo:block >
                    <xsl:value-of select="ocena"/>
                  </fo:block>
                </fo:table-cell>

              </fo:table-row>
            </xsl:for-each>
          </fo:table-body>

      </fo:table>
    </fo:block >
  </xsl:template>  
  
  <xsl:template match="muzyk">
      <fo:block >
      <fo:leader leader-length="180mm" leader-pattern="rule" rule-thickness="3pt" color="green"/>
    </fo:block>

    <fo:block text-align="center" font-size="23pt" font-family="sans-serif">
      Muzycy zespolu MUSE
    </fo:block>

    <fo:block text-align="center">
      <fo:table>
        <fo:table-column column-width="25mm"/>
        <fo:table-column column-width="25mm"/>
        <fo:table-column column-width="25mm"/>
        <fo:table-column column-width="25mm"/>
        <fo:table-column column-width="25mm"/>
        <fo:table-column column-width="25mm"/>
        <fo:table-column column-width="25mm"/>

        <fo:table-header>
          <fo:table-row>
             <fo:table-cell border="solid black 2px" background-color="#0066ff">
              <fo:block font-weight="bold">Imie</fo:block>
            </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#0066ff">
              <fo:block font-weight="bold">Funikcja</fo:block>
            </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#0066ff">
              <fo:block font-weight="bold">Instrument</fo:block>
            </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#0066ff">
              <fo:block font-weight="bold">Pseudonim</fo:block>
            </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#0066ff">
              <fo:block font-weight="bold">Wiek</fo:block>
            </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#0066ff">
              <fo:block  font-weight="bold">Data urodzenia</fo:block>
            </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#0066ff">
              <fo:block break-after="page" font-weight="bold">Pochodzenie</fo:block>
            </fo:table-cell>

          </fo:table-row>
        </fo:table-header>

       
          <fo:table-body>
            <fo:table-row>
                  <fo:table-cell border="solid black 2px" background-color="#4d94ff">
                <fo:block>
                  <xsl:value-of select="imie"/>
                </fo:block>
              </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#4d94ff">
                <fo:block>
                  <xsl:value-of select="funkcja"/>
                </fo:block>
              </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#4d94ff">
                <fo:block>
                  <xsl:value-of select="instrument"/>
                </fo:block>
              </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#4d94ff">
                <fo:block>
                  <xsl:value-of select="pseudonim"/>
                </fo:block>
              </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#4d94ff">
                <fo:block >
				<xsl:choose>
                      <xsl:when test="liczba > 39">
                        <fo:inline color="red">
                          <xsl:value-of select="wiek"/>
                        </fo:inline>
                      </xsl:when>
                      <xsl:otherwise>
                        <fo:inline color="green">
                          <xsl:value-of select="wiek"/>
                        </fo:inline>
                      </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
              </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#4d94ff">
                <fo:block>
                  <xsl:value-of select="data_urodzenia"/>
                </fo:block>
              </fo:table-cell>
 <fo:table-cell border="solid black 2px" background-color="#4d94ff">
                <fo:block break-after="page">
                  <xsl:value-of select="pochodzenie"/>
                </fo:block>
              </fo:table-cell>

            </fo:table-row>
          </fo:table-body>

      </fo:table>
    </fo:block >
  </xsl:template>


  <xsl:template match="opis">
    <fo:block font-size="35pt" font-family="sans-serif" color="pink">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>
	
	
	  <xsl:template match="trasa">

      <fo:list-block font-size="18pt" color="blue">
        <fo:list-item start-indent="0.75m">
          <fo:list-item-label>
            <fo:block>
            <xsl:value-of select="position()"/>
			- 
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block>
              <xsl:value-of select="."/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>

  </xsl:template>

</xsl:stylesheet>



