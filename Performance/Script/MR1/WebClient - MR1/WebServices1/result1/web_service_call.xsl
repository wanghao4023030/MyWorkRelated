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
		<tr><td height="30"><p><span class="hl1name">Web Service Call Properties</span></p></td></tr>
		<tr><td height="2" class="bg_darkblue"></td></tr>
		</table>

  <p>	
  <table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
  <COLGROUP>
  	<COL width="25%" />
  	<COL width="75%" />
  </COLGROUP>	
  <tr><td class="tablehl">Service Name</td><td bgcolor="white" class="text"><xsl:value-of select="/report/web_service_call/service/@name"/></td></tr>
  <tr><td class="tablehl">Port Name</td><td bgcolor="white" class="text"><xsl:value-of select="/report/web_service_call/port/@name"/></td></tr>
  <tr><td class="tablehl">Operation Name</td><td bgcolor="white" class="text"><xsl:value-of select="/report/web_service_call/operation/@name"/></td></tr>
  <xsl:if test="string-length(/report/web_service_call/address/@url) &gt; 0">
  <tr><td class="tablehl">URL</td><td bgcolor="white" class="text"><xsl:value-of select="/report/web_service_call/address/@url"/></td></tr>
  </xsl:if>
  <tr><td class="tablehl">WSDL location</td><td bgcolor="white" class="text"><xsl:value-of select="/report/web_service_call/wsdl/@location"/></td></tr>
  <tr><td class="tablehl">Toolkit</td><td bgcolor="white" class="text"><xsl:value-of select="/report/web_service_call/toolkit/@name"/></td></tr>
  <tr><td class="tablehl">Testing Aspect</td><td bgcolor="white" class="text"><xsl:value-of select="/report/web_service_call/aspect/@name"/></td></tr>
  </table>
  </p>
  
  </body>
</html>
</xsl:template>
</xsl:stylesheet>
