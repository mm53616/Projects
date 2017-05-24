<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >


  <xsl:template match="/">
    <html>
	
      <body>	  
            <center>
            <xsl:element name="img">
              <xsl:attribute name="src"> Logo.jpg </xsl:attribute>
              <xsl:attribute name="width"> 400 </xsl:attribute>
              <xsl:attribute name="height"> 50 </xsl:attribute>
            </xsl:element>
			</center>
		  
         <h2>Dane osobowe</h2>
        <table border="3">
          <tr bgcolor="#3399CC" style="color:#330066">
		    <th>L.p</th>
            <th>Imie</th>
            <th>Funkcja</th>
            <th>Instrument</th>
            <th>Pseudonim</th>
            <th>Data_urodzenia</th>
			<th>Wiek</th>
            <th>Pochodzenie</th>
          </tr>

          <xsl:apply-templates select="MUSE/muzycy/muzyk"/> 
        </table>
		          <br></br><br></br><br></br>
				  
        <table border="3">
          <tr bgcolor="#CC66CC" style="color:#CC0099">
		    <th>Nazwa plyty</th>
		    <th>Liczba piosenek</th>
            <th>Singiel</th>
            <th>Rok wydania</th>
          </tr>

		  <xsl:apply-templates select="MUSE/plyty/plyta"/>
        </table>
				          <br></br><br></br><br></br>
				  
        <table border="3">
          <tr bgcolor="#FFCC33" style="color:#FF3300"> 
		  	<th>Rok</th>
		    <th>Nazwa albumu</th>
            <th>Liczba koncertow</th>
          </tr>

		  <xsl:apply-templates select="MUSE/trasy/trasa"/>
        </table>
			<h2><xsl:apply-templates select="MUSE/linki/link"/></h2>
      </body>
    </html>
  </xsl:template>
  
  
  
  <xsl:template match="muzyk">
    <tr>
      <td>
        <xsl:number />
      </td>
      <td>
        <xsl:value-of select="imie"/>
      </td>
      <td>
	  <xsl:choose>
          <xsl:when test="funkcja = 'wokalista'">
            <font color="blue">
        <xsl:value-of select="funkcja"/>
		  </font>
		  </xsl:when>
          <xsl:when test="funkcja = 'basista'">
            <font color="green">
        <xsl:value-of select="funkcja"/>
		  </font>
		  </xsl:when>
          <xsl:otherwise>
            <font color="orange">
        <xsl:value-of select="funkcja"/>
		  </font>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:value-of select="instrument"/>
      </td>
      <td>
        <xsl:value-of select="pseudonim"/>
      </td>
      <td>
        <xsl:value-of select="data_urodzenia"/>
      </td>
      <td>
        <xsl:value-of select="wiek"/>
      </td>
      <td>
        <xsl:value-of select="pochodzenie"/>
      </td>
    </tr>
  </xsl:template>


    <xsl:template match="plyta">
	 <xsl:if test="rok_wydania &gt; 2002">
    <tr>
      <td>
        <xsl:value-of select="nazwa"/>
      </td>
      <td>
        <xsl:value-of select="l.piosenek"/>
      </td>
      <td>
        <xsl:value-of select="singiel"/>
      </td>
      <td>
        <xsl:value-of select="rok_wydania"/>
      </td>
    </tr>
		    </xsl:if>
  </xsl:template>


  
    <xsl:template match="link">
    <h2>Link : </h2>
      <a href="{@adres}">
        <xsl:value-of select="."/>
      </a>
      <br/>
	   <br/>

  </xsl:template>
  
  
   <xsl:template match="trasa">

    <tr>
      <td>
	  <xsl:choose>
          <xsl:when test="rok = '2015'">
            <font color="pink">
        <xsl:value-of select="rok"/>
		  </font>
		  </xsl:when>
          <xsl:when test="rok &lt; '2002'">
            <font color="blue">
        <xsl:value-of select="rok"/>
		  </font>
		  </xsl:when>
          <xsl:otherwise>
            <font color="orange">
        <xsl:value-of select="rok"/>
		  </font>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:value-of select="album"/>
      </td>
      <td>
        <xsl:value-of select="liczba"/>
      </td>
    </tr>

  </xsl:template> 
  
  
</xsl:stylesheet>
