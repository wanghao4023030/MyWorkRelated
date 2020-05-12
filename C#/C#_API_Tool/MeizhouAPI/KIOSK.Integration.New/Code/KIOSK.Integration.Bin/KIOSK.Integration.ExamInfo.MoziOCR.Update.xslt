<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output  omit-xml-declaration="yes" method="xml" indent="yes" version="1.0" encoding="utf-8"/>
	<xsl:template match="/">
		<!--<xsl:for-each select="NewDataSet/Table">-->
		<xsl:for-each select="//NewDataSet/Table/AccessionNumber[not(.=following::AccessionNumber)]">
		<WorkList>
			<PatientID><xsl:value-of select="../PatientID"/></PatientID>
			<Name><xsl:value-of select="../NameCN"/></Name>
			<EnglishName><xsl:value-of select="../NameEN"/></EnglishName>
			<Sex><xsl:value-of select="../Gender"/></Sex>
			<Birthday><xsl:value-of select="../Birthday"/></Birthday>
			<AccessionNumber><xsl:value-of select="../AccessionNumber"/></AccessionNumber>
			<Modality><xsl:value-of select="../Modality"/></Modality>
			<Device><xsl:value-of select="../ModalityName"/></Device>
			<StudyDate><xsl:value-of select="../RegisterDT"/></StudyDate>
			<StudyPart></StudyPart>
			<ReportDoctor></ReportDoctor>
			<ReportDate><xsl:value-of select="../SubmitDT"/></ReportDate>
			<ConfirmDoctor></ConfirmDoctor>
			<ConfirmDate><xsl:value-of select="../ApproveDT"/></ConfirmDate>
			<IsHospitalized></IsHospitalized>
			<IsEmergent></IsEmergent>
			<IsFee></IsFee>
		</WorkList>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>