<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/TR/xhtml1/strict">
<xsl:template match="/">
<html>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8"/>
  <link rel="stylesheet" media="screen">
  <xsl:attribute name="href">
  ..\Results.css
  </xsl:attribute>
  </link>
  <body>
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
    <tr><td height="1" class="bg_midblue"></td></tr>
    <tr><td height="30"><p><span class="hl1name">Database Properties</span></p></td></tr>
    <tr><td height="2" class="bg_darkblue"></td></tr>
  </table>
    
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
    <tr>
      <td>
        <table width="100%">
          <caption align="left" class="tablehl">
            <xsl:value-of select="/report/database_validation/validation/errorTitle"/>
          </caption>
          <tr>
            <td>
              <div style="overflow:auto;width:100%;height:100%">
                <table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
                  <COLGROUP>
                    <COL width="100%" />
                  </COLGROUP>
                  <xsl:for-each select="/report/database_validation/validation/error">
                    <tr>
                      <td bgcolor="white" class="Failed">
                        <xsl:value-of select="."/>
                      </td>
                    </tr>
                  </xsl:for-each>
                </table>
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
	  
	  <tr>
		  <td>
			  <table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
			  <caption align="left" class="tablehl">Connection string</caption>
			  <COLGROUP>
			  	<COL width="100%" />
			  </COLGROUP>	
			  <tr>
			  	<td bgcolor="white" class="text">
			  		<div style="overflow:auto;width:100%;">
			  			<pre><xsl:value-of select="/report/database_validation/source"/></pre>
			  		</div>
			  	</td>
			  </tr>
			  </table>
		  </td>
	  </tr>
  </table>
	
  </body>
</html>
</xsl:template>
</xsl:stylesheet>
