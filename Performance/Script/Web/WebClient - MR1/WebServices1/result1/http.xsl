<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/TR/xhtml1/strict">
<xsl:template match="/">
<html>
	<head>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8"/>
    <link rel="stylesheet" media="screen">
      <xsl:attribute name="href">
        ..\Results.css
      </xsl:attribute>
    </link>
	</head>
	
	<body>
		<table border="0" cellpadding="3" cellspacing="0" width="100%">
		<tr><td height="1" class="bg_midblue"></td></tr>
		<tr><td height="30"><p><span class="hl1name">Web Service Call HTTP Snapshot</span></p></td></tr>
		<tr><td height="2" class="bg_darkblue"></td></tr>
		</table>

		<p>
		<table border="0" cellpadding="3" cellspacing="1" height="100%">
		<tr>
		

		<td>
		<table border="0" cellpadding="2" cellspacing="1" height="95%" bgcolor="#666699">
		<tr height="3%"><th bgcolor="#666699"><font color="white">Request</font></th></tr>
		<tr height="3%"><th class="tablehl"><div class="tablehl">HTTP Header</div></th></tr>
		<tr height="30%">
		<td bgcolor="white" class="text"><div style="height:100%;width:400;overflow:auto"><pre><xsl:value-of select="/report/http/request/header"/></pre></div></td>
		</tr>
		<tr height="3%"><th class="tablehl"><div class="tablehl">SOAP</div></th></tr>
		<tr height="61%">
		<td bgcolor="white" class="text"><div style="height:100%;width:400;overflow:auto"><pre><xsl:value-of select="/report/http/request/body"/></pre></div></td>
		</tr>
		</table>
		</td>
		
		<td>
		<table border="0" cellpadding="2" cellspacing="1" height="95%" bgcolor="#666699">
		<tr height="3%"><th bgcolor="#666699"><font color="white">Response</font></th></tr>
		<tr height="3%"><th class="tablehl"><div class="tablehl">HTTP Header</div></th></tr>
		<tr height="30%">
		<td bgcolor="white" class="text"><div style="height:100%;width:400;overflow:auto"><pre><xsl:value-of select="/report/http/response/header"/></pre></div></td>
		</tr>
		<tr height="3%"><th class="tablehl"><div class="tablehl">SOAP</div></th></tr>
		<tr height="61%">
		<td bgcolor="white" class="text"><div style="height:100%;width:400;overflow:auto"><pre><xsl:value-of select="/report/http/response/body"/></pre></div></td>
		</tr>
		</table>
		</td>

		</tr>
		</table>
		</p>
	</body>
</html>
</xsl:template>
</xsl:stylesheet>
