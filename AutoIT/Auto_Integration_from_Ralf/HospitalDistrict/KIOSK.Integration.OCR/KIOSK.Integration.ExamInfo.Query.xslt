<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output  omit-xml-declaration="yes" method="xml" indent="yes" version="1.0" encoding="utf-8"/>
  <xsl:template match="/">
    <examInfoList>
      <!--<xsl:for-each select="NewDataSet/Table">-->
      <xsl:for-each select="//NewDataSet/Table/ExamName[not(.=following::ExamName)]">
      <examInfo>
        <autoForward>1</autoForward>
		<forwardDestination></forwardDestination>
        <examName><xsl:value-of select="."/></examName>
        <patientID><xsl:value-of select="../PatientID"/></patientID>
        <accessionNumber><xsl:value-of select="../AccessionNumber"/></accessionNumber>
        <nameEN><xsl:value-of select="../NameEN"/></nameEN>
        <nameCN><xsl:value-of select="../NameCN"/></nameCN>
        <gender><xsl:value-of select="../Gender"/></gender>
        <birthday><xsl:value-of select="../Birthday"/></birthday>
        <modalityType><xsl:value-of select="../Modality"/></modalityType>
        <modalityName><xsl:value-of select="../ModalityName"/></modalityName>
        <patientType><xsl:value-of select="../PatientType"/></patientType>
        <requestID><xsl:value-of select="../RequestID"/></requestID>
        <referringDepartment><xsl:value-of select="../ReferringDepartment"/>2</referringDepartment>
        <requestDepartment><xsl:value-of select="../RequestDepartment"/>2</requestDepartment>
        <requestDT><xsl:value-of select="../RequestDT"/></requestDT>
        <registerDT><xsl:value-of select="../RegisterDT"/></registerDT>
        <examDT><xsl:value-of select="../ExamDT"/></examDT>
        <submitDT><xsl:value-of select="../SubmitDT"/></submitDT>
        <approveDT><xsl:value-of select="../ApproveDT"/></approveDT>
        <studyStatus><xsl:value-of select="../StudyStatus"/></studyStatus>
		<outHospitalNo><xsl:value-of select="../OutHospitalNo"/></outHospitalNo>
		<inHospitalNo><xsl:value-of select="../InHospitalNo"/></inHospitalNo>
		<physicalNumber><xsl:value-of select="../PhysicalNumber"/></physicalNumber>
		<examBodypart><xsl:value-of select="../ExamBodyPart"/></examBodypart>
        <emergencyFlag></emergencyFlag>
        <optional0></optional0>
        <optional1></optional1>
        <optional2></optional2>
        <optional3></optional3>
        <optional4></optional4>
        <optional5></optional5>
		<patientAge></patientAge>
		<idCardNumber>1</idCardNumber>
		<medicalCardNumber>1</medicalCardNumber>
		<socialSecurityCardNumber>1</socialSecurityCardNumber>
		<phoneNumber>1</phoneNumber>
		<homeAddress></homeAddress>
		<hospitalDistrict>Center</hospitalDistrict>
      </examInfo>
      </xsl:for-each>
    </examInfoList>
  </xsl:template>
 </xsl:stylesheet>
