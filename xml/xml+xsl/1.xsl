<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
	    <head>
          <link rel="stylesheet" type="text/css" href="Style.css"/>
        </head>
      <body>	  
            <center>
            <xsl:element name="img">
              <xsl:attribute name="src"> Logo.jpg </xsl:attribute>
              <xsl:attribute name="width"> 800 </xsl:attribute>
              <xsl:attribute name="height"> 100 </xsl:attribute>
            </xsl:element>
			</center>
		  
         <h2>Dane osobowe</h2>
		 				          <br></br><br></br>
	 <table border="1" align ="center">
          <tr> 
		    <th>L.p</th>
            <th>Imie</th>
            <th>Funkcja</th>
            <th>Instrument</th>
            <th>Pseudonim</th>
            <th>Data_urodzenia</th>
			<th>Wiek</th>
            <th>Pochodzenie</th>
          </tr>

          <xsl:apply-templates select="MUSE/muzycy/muzyk[wiek='39']"/> 
		  <xsl:call-template name="rozdzielenie"/>
		  <xsl:apply-templates select="MUSE/muzycy/muzyk[wiek!='39']"/> 
        </table>
		          <br></br><br></br><br></br>
				  
		
				<table border="1" align ="center">
          <tr> 
		    <th>Nazwa </th>
		    <th>Rok założenia</th>
            <th>Styl</th>
            <th>Pochodzenie</th>
		</tr>
		  <xsl:apply-templates select="MUSE/opis"/>
		  </table>
				          <br></br><br></br><br></br>
		
		          <table border="1" align ="center">
            <xsl:copy-of select="$ocena" />
		   <xsl:apply-templates select="MUSE/plyty/plyta/ocena"/> 
          </table>
				          <br></br><br></br>

	  
		<table border="1" align ="center">
          <tr> 
		    <th>Nazwa plyty</th>
		    <th>Liczba piosenek</th>
            <th>Singiel</th>
            <th>Rok wydania</th>
            <th>Czas trwania</th>
          </tr>

          <xsl:for-each select="MUSE/plyty/plyta">
			<xsl:sort select="rok_wydania" order="descending" />
			<xsl:value-of select="position()"/>
            <xsl:apply-templates select="."/>
          </xsl:for-each>
        </table>
		
		
				          <br></br><br></br>



	 <table border="1" align ="center">
          <tr> 
		    <th>L.p</th>
		    <th>Nazwa albumu</th>
			<th>Rok</th>
            <th>Liczba koncertow</th>
          </tr>

		  <xsl:apply-templates select="MUSE/trasy/trasa"/>
        </table>
						          <br></br><br></br>
		 <xsl:apply-templates select="MUSE/linki/link"/>
		 				          <br></br><br></br>

	<xsl:apply-templates select="MUSE/oceny_Drones"/>

	  	<xsl:apply-templates select="MUSE/moje_dane"/>
	  	<!--  
	   <xsl:for-each select="festiwal">
          <xsl:sort select="@rok_powstania"/>
          <xsl:sort select="@dostepnosc_w_Polsce"/>
          <xsl:value-of select="nazwa"/>
			  -->
		<center>
            <xsl:element name="img">
              <xsl:attribute name="src"> End.jpg </xsl:attribute>
              <xsl:attribute name="width"> 600 </xsl:attribute>
              <xsl:attribute name="height"> 300 </xsl:attribute>
            </xsl:element>
			</center>

      </body>
    </html>
  </xsl:template>
  
  
  
  <xsl:template match="muzyk">
        <xsl:if test="wiek &gt; 30">
    <tr>
      <td>
        <xsl:number value="position()" format = "A" />
      </td>
      <td>
        <xsl:value-of select="imie"/>
      </td>
      <td>
	  <xsl:choose>
          <xsl:when test="funkcja = 'wokalista'">
            <font color="red">
        <xsl:value-of select="funkcja"/>
		  </font>
		  </xsl:when>
          <xsl:when test="funkcja = 'basista'">
            <font color="green">
        <xsl:value-of select="funkcja"/>
		  </font>
		  </xsl:when>
          <xsl:otherwise>
            <font color="purple">
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
	    </xsl:if>
  </xsl:template>

         
						  
    <xsl:template match="plyta">
<xsl:if test="rok_wydania != 2018">
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
      <td>
        <xsl:value-of select='format-number(czas_trwania, "#.00")'/>
      </td>
    </tr>
</xsl:if>
  </xsl:template>


  
    <xsl:template match="link">
    <h2>Link : </h2>
     <h3> <a href="{@adres}">
        <xsl:value-of select="."/>
      </a></h3> 
      <br/>
	   <br/>

  </xsl:template>
  

   
  
  
  <xsl:template name="rozdzielenie">
    <tr>
      <td>
        <hr/>
      </td>
      <td>
        <hr/>
      </td>
      <td>
        <hr/>
      </td>
      <td>
        <hr/>
      </td>
      <td>
        <hr/>
      </td>
      <td>
        <hr/>
      </td>
      <td>
        <hr/>
      </td>
      <td>
        <hr/>
      </td>
    </tr>
  </xsl:template>
  
   <xsl:template match="trasa">
     
        <xsl:if test="rok &gt; 2000">
    <tr>
      <td>
        <xsl:number format="I"/>
      </td>
      <td>
        <xsl:value-of select="album"/>
      </td>
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
        <xsl:value-of select="liczba"/>
      </td>
    </tr>
	    </xsl:if>
  </xsl:template> 
  
  
  <xsl:variable name="ocena">
    <tr bgcolor="#0000ff" style="color:#ffffff">
      <th>Numer płyty</th>
	  <th>Ocena końcowa</th>
    </tr>
  </xsl:variable>

  
  
    <xsl:template match="plyta/ocena">
    <tr>
		  <td>
	       <xsl:number value="position()" format = "1" />
		    </td>
	  <td>
        <xsl:value-of select ="../ocena"/>
      </td>
    </tr>
  </xsl:template>
  
   <xsl:variable name="zmienna_NME" select="8.8"/>
  <xsl:variable name="zmienna_Rolling_Stones" select="8.5"/>
  <xsl:variable name="zmienna_moja" select="9.1"/> 
  
  
   <xsl:template match="oceny_Drones">
	<h2>Oceny płyty Absolution:</h2>
	    <h3>
      <xsl:if test="ocena_NME &gt; $zmienna_NME">
        <xsl:text>Ocena NME : </xsl:text>
        <h5>
          <xsl:value-of select="round(ocena_NME)"/>
        </h5>
      </xsl:if>
      
      <xsl:if test="ocena_NME = $zmienna_NME">
        <xsl:text>Ocena NME : </xsl:text>
        <h4>
          <xsl:value-of select="floor(ocena_NME)"/>
        </h4>
      </xsl:if>
	    </h3>
		
			    <h3>
      <xsl:if test="ocena_Rolling_Stones &gt; $zmienna_Rolling_Stones">
        <xsl:text>Ocena Allmusic : </xsl:text>
        <h5>
          <xsl:value-of select="ceiling(ocena_Rolling_Stones)"/>
        </h5>
      </xsl:if>
      
      <xsl:if test="ocena_Rolling_Stones &lt; $zmienna_Rolling_Stones">
        <xsl:text>Ocena Allmusic : </xsl:text>
        <h4>
          <xsl:value-of select="ceiling(ocena_Rolling_Stones)"/>
        </h4>
      </xsl:if>
	    </h3>
		
    <h3>
      <xsl:if test="ocena_moja &gt; $zmienna_moja">
        <xsl:text>Ocena moja : </xsl:text>
        <h5>
          <xsl:value-of select="format-number(ocena_moja,'0.000')"/>
        </h5>
      </xsl:if>
      <xsl:if test="ocena_moja &lt; $zmienna_moja">
        <xsl:text>Ocena moja : </xsl:text>
        <h4>
          <xsl:value-of select="format-number(ocena_moja,'0.000')"/>
        </h4>
      </xsl:if>
    </h3>
	

      	    <h3><xsl:text>Suma: </xsl:text></h3>
        <h5>
        <xsl:value-of select="sum(ocena_NME)+sum(ocena_moja)+sum(ocena_Rolling_Stones)"/>
        </h5>
		<br/><br/>
		<h2>Wykaz ocen</h2>
<br/>
<xsl:if test="ocena_moja &lt; 10">
	 <table border="1" align ="center">
	<tr>
      <td>
        <xsl:value-of select="ocena_moja"/>
      </td>
      <td>
        <xsl:value-of select="ocena_Rolling_Stones"/>
      </td>
      <td>
        <xsl:value-of select="ocena_NME"/>
      </td>
    </tr>
	</table>
</xsl:if>
  </xsl:template>
  
  <xsl:template match="opis">
  <xsl:if test="styl = 'rock'">
    <tr>
	<td>
        <xsl:value-of select="nazwa"/>
      </td>
      <td>
        <xsl:apply-templates select="rok_zalozenia/@data"/>
      </td>
      <td>
        <xsl:value-of select="styl"/>
      </td>
	        <td>
        <xsl:value-of select="pochodzenie"/>
		
      </td>
	  </tr>
	  </xsl:if>
  </xsl:template>
  
  <xsl:template match="moje_dane">  
<xsl:if test="imie_moje = 'Magda'">
    <h1><xsl:value-of select="imie_moje"/></h1>
    <h1> <xsl:value-of select="nazwisko_moje"/></h1>
	  </xsl:if>
 </xsl:template>
 
 <xsl:template match="@data">
	<xsl:choose>
	<xsl:when test=". = '1994-02-11'">
    <span style="color:red;">
      <xsl:value-of select="."/>
    </span>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="."/>
	</xsl:otherwise>
	</xsl:choose>
 </xsl:template>
  
</xsl:stylesheet>
