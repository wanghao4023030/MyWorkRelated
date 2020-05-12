<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output  omit-xml-declaration="yes" method="xml" indent="yes" version="1.0" encoding="utf-8"/>
  <xsl:template match="/">
    <examInfoList>
      <!--<xsl:for-each select="NewDataSet/Table">-->
      <xsl:for-each select="//NewDataSet/Table/ACCESSIONNUMBER[not(.=following::ACCESSIONNUMBER)]">
      <examInfo>
        <autoForward>0</autoForward>
		<forwardDestination></forwardDestination>
        <patientID><xsl:value-of select="../PATIENTID"/></patientID>
        <accessionNumber><xsl:value-of select="."/></accessionNumber>
        <nameEN><xsl:value-of select="../NAMEEN"/></nameEN>
        <nameCN><xsl:value-of select="../NAMECN"/></nameCN>
        <gender><xsl:value-of select="../GENDER"/></gender>
        <birthday><xsl:value-of select="../BIRTHDAY"/></birthday>
        <modalityType><xsl:value-of select="../MODALITY"/></modalityType>
        <modalityName><xsl:value-of select="../MODALITYNAME"/></modalityName>
        <patientType><xsl:value-of select="../PATIENTTYPE"/></patientType>
        <requestID><xsl:value-of select="../REQUESTID"/></requestID>
        <referringDepartment><xsl:value-of select="../REQUESTDEPARTMENT"/></referringDepartment>
        <requestDepartment><xsl:value-of select="../REQUESTDEPARTMENT"/></requestDepartment>
        <requestDT><xsl:value-of select="../REQUESTDT"/></requestDT>
        <registerDT><xsl:value-of select="../REGISTERDT"/></registerDT>
        <examDT><xsl:value-of select="../EXAMDT"/></examDT>
        <submitDT><xsl:value-of select="../SUBMITDT"/></submitDT>
        <approveDT><xsl:value-of select="../APPROVEDT"/></approveDT>
        <studyStatus><xsl:value-of select="../STUDYSTATUS"/></studyStatus>        
		<examName><xsl:value-of select="../EXAMNAME"/></examName>
		<examBodyPart><xsl:value-of select="../EXAMBODYPART"/></examBodyPart>
		<outHospitalNo><xsl:value-of select="../OUTHOSPITALNO"/></outHospitalNo>
		<inHospitalNo><xsl:value-of select="../INHOSPITALNO"/></inHospitalNo>
		<physicalNumber><xsl:value-of select="../PHYSICALNUMBER"/></physicalNumber>		
		<emergencyFlag></emergencyFlag>		
        <optional0></optional0>
        <optional1></optional1>
        <optional2></optional2>
        <optional3></optional3>
        <optional4></optional4>
        <optional5></optional5>
      </examInfo>
      </xsl:for-each>
    </examInfoList>
  </xsl:template>
 </xsl:stylesheet>
