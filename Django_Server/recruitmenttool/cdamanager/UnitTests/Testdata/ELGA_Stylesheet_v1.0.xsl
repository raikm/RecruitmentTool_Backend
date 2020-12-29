<?xml version="1.0" encoding="UTF-8"?>
<!--
"ELGA Referenz-Stylesheet" - Hinweise zur Nutzung

Das "ELGA Referenz-Stylesheet" ermöglicht eine allgemeine, einheitliche und benutzerfreundliche Darstellung von medizinischen CDA-Dokumenten (HL7 CDA Release 2.0),
die als gemäß der Vorgaben der ELGA CDA Implementierungsleitfäden erstellt wurden. Das "ELGA Referenz-Stylesheet" wurde auf Grundlage von Vorarbeiten der Firmen
"USECON The Usability Consultants" und "NETCONOMY Software & Consulting GmbH" unter Leitung der ELGA GmbH von Arbeitsgruppen zur Harmonisierung
der CDA Implementierungsleitfäden gemäß dem Stand der Technik und unter Anwendung der größtmöglichen Sorgfalt auf seine Anwendbarkeit getestet und überprüft.

Das "ELGA Referenz-Stylesheet" wird von der ELGA GmbH bis auf Widerruf unentgeltlich und nicht-exklusiv sowie zeitlich und örtlich unbegrenzt, jedoch beschränkt auf
Verwendungen für die Zwecke der "Clinical Document Architecture" (CDA) zur Verfügung gestellt. Veränderungen des "ELGA Referenz-Stylesheet" für die lokale
Verwendung sind zulässig. Derartige Veränderungen (sogenannte bearbeitete Fassungen) dürfen ihrerseits publiziert und Dritten zur Weiterverwendung und Bearbeitung zur Verfügung
gestellt werden. Bei der Veröffentlichung von bearbeiteten Fassungen ist darauf hinzuweisen, dass diese auf Grundlage des von der ELGA GmbH publizierten
"ELGA Referenz-Stylesheet" erstellt wurden.

Die Anwendung sowie die allfällige Bearbeitung des "ELGA Referenz-Stylesheet" erfolgt in ausschließlicher Verantwortung der AnwenderInnen.
Aus der Veröffentlichung, Verwendung und/oder Bearbeitung können keinerlei Rechtsansprüche gegen die ELGA GmbH erhoben oder abgeleitet werden.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n1="urn:hl7-org:v3" xmlns:n2="urn:hl7-org:v3/meta/voc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns2="urn:ihe:pharm:medication"
                exclude-result-prefixes="n1 n2 voc xsi ns2" id="ELGA_Referenzstylesheet_1.09.001">
  <xsl:output method="html" omit-xml-declaration="yes" indent="yes" encoding="utf-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" />

  <!--    
  ShowRevisionMarks:
  Wert 0: Eingefügter Text wird normal, gelöschter Text wird nicht dargestellt
  Wert 1: Eingefügter Text wird unterstrichen und kursiv, gelöschter Text wird durchgestrichen dargestellt
  -->
  <xsl:param name="param_showrevisionmarks" />
  
  <xsl:variable name="showrevisionmarks">
    <xsl:choose>
      <xsl:when test="not($param_showrevisionmarks)">
        <xsl:value-of select="0" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$param_showrevisionmarks" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!--
  use external css 
  useexternalcss:   Wert 0: Externes CSS deaktiviert  
                    Wert 1: Externes CSS aktiviert
  externalcssname:  Name der CSS-Datei bei useexternalcss = 1 
  
  -->
  <xsl:param name="param_useexternalcss" />
  
  <xsl:variable name="useexternalcss">
    <xsl:choose>
      <xsl:when test="not($param_useexternalcss)">
        <xsl:value-of select="0" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$param_useexternalcss" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>  
  
  <xsl:param name="param_externalcssname" />
  
  <xsl:variable name="externalcssname">
    <xsl:if test="$param_externalcssname">
      <xsl:value-of select="$param_externalcssname" />
    </xsl:if>
  </xsl:variable> 
  
  
  <!--
  print icon visibility
    1: show print icon
    0: hide print icon
  -->
  <xsl:param name="param_printiconvisibility" />
  
  <xsl:variable name="printiconvisibility">
    <xsl:choose>
      <xsl:when test="not($param_printiconvisibility)">
        <xsl:value-of select="0" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$param_printiconvisibility" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <!--
  document state
    1: document is deprecated
    0: document is not deprecated
  -->
  <xsl:param name="param_isdeprecated" />
  
  <xsl:variable name="isdeprecated">
    <xsl:choose>
      <xsl:when test="not($param_isdeprecated)">
        <xsl:value-of select="0" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$param_isdeprecated" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!--
   strict mode disabled
     1: valid and invalid documents will be rendered (only allowed in debug mode!)
     0: only valid documents will be rendered (default)
   -->
  <xsl:param name="param_strictModeDisabled" />

  <xsl:variable name="isStrictModeDisabled">
    <xsl:choose>
      <xsl:when test="not($param_strictModeDisabled)">
        <xsl:value-of select="0" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$param_strictModeDisabled" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

<!--
 gesundheit.gv.at service URL. Used for LOINC code resolution.
-->
<xsl:param name="param_LOINCResolutionUrl" />

<xsl:variable name="LOINCResolutionUrl">
<xsl:choose>
    <xsl:when test="not($param_LOINCResolutionUrl)">
        <xsl:value-of select="'https://www.gesundheit.gv.at/linkaufloesung/applikation-flow?quelle=GHP&amp;flow=LO&amp;leistung=LA-GP-LO-'" />
    </xsl:when>
    <xsl:otherwise>
        <xsl:value-of select="$param_LOINCResolutionUrl" />
    </xsl:otherwise>
</xsl:choose>
</xsl:variable>

<!--
    show info button
        0: disable info button
        1: enable info button in "ELGA Laborbefund EIS Full Support" documents
-->
<xsl:param name="param_enableInfoButton" />

<xsl:variable name="enableInfoButton">
    <xsl:choose>
        <xsl:when test="not($param_enableInfoButton)">
            <xsl:value-of select="0" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$param_enableInfoButton" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>

<!--
    show tables in best guess mode
       1: invalid tables will be rendered as good as possible (only allowed in debug mode!; only possible with param_strictModeDisabled = 1!)
       0: only valid tables will be rendered (default)
-->
<xsl:param name="param_showTableInBestGuess" />

<xsl:variable name="showTableInBestGuess">
    <xsl:choose>
        <xsl:when test="not($param_showTableInBestGuess)">
            <xsl:value-of select="0" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$param_showTableInBestGuess" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>

<!--
 white background color for section titles
   1: section title will be displayed with a white background color
   0: section title will be displayed with a grey background color
 -->
<xsl:param name="param_sectionTitleWhiteBackgroundColor" />

<xsl:variable name="isSectionTitleWhiteBackgroundColor">
    <xsl:choose>
        <xsl:when test="not($param_sectionTitleWhiteBackgroundColor)">
            <xsl:value-of select="0" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$param_sectionTitleWhiteBackgroundColor" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>

  <!-- helper vars, transform to lower / uppercase -->
  <xsl:variable name="lc" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uc" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <!--
  global variables for the document
  (document title, language, patient sex, gendered patient title)
   -->
  <xsl:variable name="title">
    <xsl:choose>
      <xsl:when test="/n1:ClinicalDocument/n1:title">
        <xsl:value-of select="/n1:ClinicalDocument/n1:title"/>
      </xsl:when>
      <xsl:otherwise>Clinical Document</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="language"><xsl:value-of select="/n1:ClinicalDocument/n1:languageCode/@code" /></xsl:variable>
  <xsl:variable name="sex" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:administrativeGenderCode/@code"/>
  <xsl:variable name="genderedpatient">
    <xsl:choose>
      <xsl:when test="$sex='M'"><xsl:text>Patient</xsl:text></xsl:when>
      <xsl:when test="$sex='F'"><xsl:text>Patientin</xsl:text></xsl:when>
      <xsl:otherwise><xsl:text>Patient(in)</xsl:text></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="documentValid">
    <xsl:if test="$isStrictModeDisabled='0'">
      <xsl:call-template name="checkDocumentValid" />
    </xsl:if>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="$documentValid = ''">
        <xsl:apply-templates select="n1:ClinicalDocument"/>
      </xsl:when>
      <xsl:otherwise>
        <html>
          <head>
            <meta http-equiv="X-UA-Compatible" content="IE=10; chrome=1" />
            <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
            <xsl:comment> Do NOT edit this HTML directly, it was generated via an XSL transformation from the original release 2 CDA Document. </xsl:comment>
            <title>Ungültiges Dokument</title>
          </head>
          <body style="background-color: white; color: black; font-family: Arial,sans-serif; font-size: 100%; line-height: 130%;">
            <table style="border: 0.1em solid black; width: 100%; align: center" cellspacing="0" cellpadding="0">
              <tr>
                <td style="padding: 1em; text-align: center;"><xsl:text>Das Dokument kann wegen einer ungültigen Formatanweisung nicht dargestellt werden.</xsl:text></td>
              </tr>
            </table>
          </body>
        </html>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="n1:ClinicalDocument">

    <html>
    <!--
      HTML Head
      Document title and patient name is shown in browser tab
    -->
      <head>
        <meta http-equiv="X-UA-Compatible" content="IE=10; chrome=1" />
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
        <xsl:comment> Do NOT edit this HTML directly, it was generated via an XSL transformation from the original release 2 CDA Document. </xsl:comment>
        <title>
          <xsl:value-of select="$title"/> | <xsl:value-of select="$genderedpatient" />:
          <xsl:call-template name="getName">
            <xsl:with-param name="name" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:name"/>
          </xsl:call-template>
        </title>
        <style type="text/css" media="screen,print">
body {
  font-family: Arial, sans-serif;
  font-size: 14px;
  line-height: 130%;
  <xsl:choose>
    <xsl:when test="$isdeprecated=0">
      <xsl:text>color: black;</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>color: #666666;</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  background-color: white;
}

.outerContainer {

}

.bodyContentContainer {
  width: 900px;
  margin: 0 auto 0 auto;
}

hr {
  border: 0.5px solid black;
  padding: 0;
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}

.boxLeft {
  margin-left: 12px;
  margin-right: 1em;
  width: 57%;
  float: left;
  font-size: 1.015em;
}

.boxRight {
  width: 37%;
  float: left;
  font-size: 1.015em;
}

.sectionSubTitle {
  font-weight: bold;
}

img {
  border: none;
}

h2 img {
  vertical-align: text-top;
}

a {
  color: #004A8D;
}

a:hover {
  text-decoration: none;
}

a:focus, .multimediaSubmit:focus {
  background-color: #004A8D;
  color: #ffffff;
}

div.tableofcontentsMinimize a.show_tableofcontents, div.tableofcontentsMinimize a.hide_tableofcontents {
  font-weight: bold;
}

a.collapseShow {
  display: block;
  width: 20px;
  height: 20px;
  background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($expandIcon),'&#32;','')" />);
}

a.collapseShow:hover {
  display: block;
  width: 20px;
  height: 20px;
  background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($expandIconHover),'&#32;','')" />);
}

a.collapseHide {
    display: block;
    width: 20px;
    height: 20px;
    background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($collapseIcon),'&#32;','')" />);
}

a.collapseHide:hover {
  display: block;
  width: 20px;
  height: 20px;
  background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($collapseIconHover),'&#32;','')" />);
}

p {
  margin: 0;
}

.clearer {
  clear: both;
}

.header {
  padding: 1em 0 0.5em 0;
}

.header h1 {
  margin: 0;
  font-size: 1.652em;
}

.header p {
  padding-top: 0.7em;
}

.header .logo {
  float: right;
  overflow: hidden;
  text-align: right;
  width: 327px;
  height: 60px;
}
.header .logo img {
  max-width: 327px;
  max-height: 60px;
}

.print {
  margin-left: 2em;
  vertical-align: top;
}

.tableofcontents {
  margin-bottom: 1em;
}
.tableofcontents .left {
  float: left;
  width: 50%;
  background-color: #DDDDDD;
}
.tableofcontents .right {
  float: left;
  width: 50%;
}
.tableofcontents .right .container,
.tableofcontents .left .container {
  padding: 1em;
}

.tableofcontents .information {
  padding-bottom: 1em;
  font-weight: bold;
}
.subtitle_create {
  font-size: 0.889em;
}

h1 {
  font-size: 1em;
  font-weight: normal;
}

h2 {
  font-size: 1em;
  font-weight: normal;
}

h3 {
  font-size: 1em;
  font-weight: normal;
  padding: 0.4em 0.4em 0.4em 0;
  margin-bottom: 0.2em;
  margin-top: 0.75em;
}

.section_indent h2, .section_indent h3 {
  margin-bottom: 0.5em;
  margin-top: 1.1em;
  padding: 0 0 0 0px;
}

.risk h2, .risk h3 {
  padding: 0 0 5px 0;
  margin: 0 0 0 0px;
}

.risk h2 {
  font-size: 1.204em;
}

.section_indent .risk {
  margin-left: -12px;
}

h4 .backlink {
  display: none;
}

.title {
}

.subTitle {
  font-size: 1.015em;
  margin-bottom: 0.2em;
}

.backlink {
  display: inline-block;
  float: right;
  width: 47px;
  height: 43px;
  text-decoration: none;
  background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($toTopIcon),'&#32;','')" />);
}
.backlink:hover {
  background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($toTopIconHover),'&#32;','')" />);
}

.caption {
  font-size: 120%;
  padding: 0.5em 0 0.5em 0;
  display: block;
}
.paragraph {
  padding: 0.5em 0 0.5em 0;
}

h4 {
  font-size: 110%;
}

.error {
  color: red;
}

.risk {
  padding-left: 12px;
  padding-right: 12px;
  padding-top: 0.6em;
  padding-bottom: 0.6em;
  margin-top: 12px;
  background-color: #FFE17F;
}

.risk .section_text {
  padding-left: 0;
}
.risk .backlink {
  display: none;
}

.xred {
  color: #B10F3D;
  font-weight: bold;
}

.xblue {
  color: #0060f0;
  font-weight: bold;
}

.xMonoSpaced {
  font-family: monospace;
  white-space: pre;
}

.lighter {
  font-weight: normal;
}

.hideCreatedByTo,
.createdbyto,
.collapseTrigger,
.bottomline .element {
  cursor: pointer;
}
.hideCreatedByTo:hover,
.createdbyto:hover,
.collapseTrigger:hover,
.bottomline .element:hover {
  background-color: #ffffd1 !important;
}

.hideCreatedByTo,.createdbyto {
  background-color: #dddddd;
  padding: 0.5em;
  margin-bottom: 1em;
}

.hideCreatedByTo .created,.hideCreatedByTo .to,.createdbyto .to,.createdbyto .created {
  font-weight: bold;
  padding-right: 1em;
}

.collapseLinks {

}

.leftsmall {
  float: left;
  width: 12%;
}

.leftwide {
  float: left;
  width: 33%;
  word-wrap: break-word;
  font-size: 1.015em;
}

.hideCreatedByTo .leftsmall,.createdbyto .leftsmall {
  text-align: right;
  padding-left: 0.5em;
}

.body_section {

}

.body_section h1 {
  background-color: #C7D9FF;
  padding: 0.3em 0 0.3em 0.5em;
}

h1.body_section_header {
  margin-bottom: 0;
}

.salutation {
  font-weight: normal;
  padding-top: 1em;
}

.salutation .section_text {
  padding: 0;
}

.leavetaking {
  padding-top: 2em;
  padding-bottom: 1em;
  font-weight: normal;
}

.leavetaking .section_text {
  padding: 0;
}

.section_indent {
  padding-left: 12px;
  font-size: 1.015em;
}

.section_text {
  padding-left: 12px;
  font-size: 1.015em;
}

.section_table {
  width: 900px;
  font-size: 0.9em;
  margin-left: -12px;
}

.section_table td ul {
  margin-top: 0;
  margin-bottom: 0;
}

.section_table th {
  text-align: left;
  background-color: #DDDDDD;
  border-bottom: 0.5px solid black;
  border-left: 2px solid white;
}

.section_table tr.even {
  background-color: #E8E8E8;
}

.section_table th, .section_table td {
  padding: 0.3em 0.3em 0.3em 0.5em;
  vertical-align: top;
}

.section_table tfoot tr td{
  font-size: 90%;
}

.table_cell {
 border-bottom: 0.5px solid black;
}

.tableFormatExceptionInformation {
  text-align: center;
  color: #FF00FF;
}

/* Addresses */
.address {
  margin-bottom: 1em;
}

.recipient {
  margin-top: 1em;
}

div.collapseTrigger, div.collapseTriggerWithoutHover {
  background-color: #f0f4fb;
  padding: 0.7em 0.5em 0.7em 12px;
}

div.collapseTrigger h1, div.collapseTriggerWithoutHover h1 {
  float: left;
  margin: 0;
  padding-right: 0.5em;
}

div.collapseTriggerWithoutHover .authenticatorShortInfo,
div.collapseTrigger .clientShortInfo,
div.collapseTrigger .stayShortInfo,
div.collapseTrigger .patientShortInfo,
{
  float: left;
}

.authenticatorShortInfo {
  float: left;
  width: 550px;
}

.authenticatorTitle {
  float: left;
  width: 300px;
  font-size: 1.204em;
}

.documentMetaTitle {
  font-size: 1.204em;
  float: left;
}

div.collapseTrigger .stayShortInfo {
  width: 100%;
}

.patientTitle {
  float: left;
  width: 17%;
  font-size: 1.204em
}

.patientTitle h1 {
  padding: 0;
}
.patientShortInfo {
  float: left;
  width: 79%;
}

div.collapseTrigger .authenticatorShortInfo .name, div.collapseTriggerWithoutHover .authenticatorShortInfo .name, div.collapseTrigger .clientShortInfo .name,div.collapseTrigger .stayShortInfo .name,div.collapseTrigger .patientShortInfo .name {
  font-size: 1.204em;
}

.authenticatorShortInfo .name:not(:last-child) {
  margin-bottom: 0.2em;
}

div.collapseTrigger .collapseLinks, div.hideCreatedByTo .collapseLinks, div.createdbyto .collapseLinks, div.bottomline_data .collapseLinks {
  padding-right: 0.5em;
  width: 20px;
}

.collapseLinks {
  float: left;
  display: block;
  font-weight: bold;
}

/* patient container */
.patientContainer {
  margin-bottom: 0.5em;
}

.patientContainer .date, .patientContainer .addresses,.patientContainer .guardian,
.patientContainer .data, .patientContainer .collapsableStay
  {
  padding: 1em 0 1em 0;
}

.patientContainer h2 {
  margin: 0;
  padding-right: 1em;
  padding-bottom: 1em;
  padding-left: 0.5em;
}

.patientContainer .leftsmall {
  width: 30%;
}

.patientContainer .leftwide {
  width: 70%;
}

.patientContainer td {
  vertical-align: top;
}

.patientContainer .firstrow {
  padding-right: 1em;
  font-weight: bold;
}

tr.spacer td {
  padding-bottom: 1em;
}

.contactAddress .address {
  float: left;
  padding-right: 1em;
  width: 12em;
}

.addressRegion {
  font-weight: bold;
}

.guardianContact {
  padding-bottom: 1em;
}

.guardianContact .address {
  margin: 0;
}

.guardianContact .organisationName {
  padding-top: 0.5em;
  font-weight: bold;
}

.guardianName {
  font-weight: bold;
}

/* stay container */
.stayShortInfo {
  margin-top: 0.7em;
}

.stayShortInfo h1 {
  font-weight: normal;
}

.collapsableStay .leftsmall {
  float: left;
  width: 35%;
  padding-left: 4em;
}

.collapsableStay .leftwide {
  float: left;
  width: 42%;
  padding-left: 8%;
}

.collapsableStay .medic {

}

.collapsableStay .medicName {
  font-weight: bold;
}
.collapsableStay .organisationName {
  font-weight: bold;
}

.collapsableStay .az {
  margin-bottom: 1em;
  padding-left: 4em;
}

/* client container */
.clientContainer {
  margin-bottom: 1em;
}

.clientContainer .leftsmall {
  float: left;
  width: 35%;
  padding-left: 4em;
}

.clientContainer .leftwide {
  float: left;
  width: 42%;
  padding-left: 8%;
}

.clientContainer .collapsable {
  padding-top: 1em;
  padding-bottom: 1em;
}

.clientContainer .clientdata,
.clientContainer .collapseable .name {
  font-weight: bold;
}

/* authenticatorContainer */
.authenticatorContainer {
  padding-bottom: 0.5em;
}

.authenticatorContainer .collapsed .name,
.authenticatorContainer .organisationName {
  font-weight: bold;
}

.authenticatorContainer .leftsmall {
  float: left;
  width: 45%;
  padding-left: 12px;
}

.authenticatorContainer .leftwide {
  float: left;
  width: 50%;
}

.authenticatorContainer .collapsable {

}

.authenticatorContainerDivider {
  border-bottom: 0.5px solid black;
  padding-top: 0.5em;
  margin-bottom: 0.5em;
}

.authenticatorContainer .address {
}

.bottomline_data .leftsmall {
  width: 30%;
}

.bottomline_data .leftwide {
  width: 60%;
}

.bottomline .collapseLinks {
}

.bottomline h2 {
  font-size: 1.015em;
  margin: 0;
}

h2 .collapseLinks, h3 .collapseLinks {
  float: right;
}

.bottomline .organisationName {
}

.bottomline .relationship {
  font-weight: normal;
}

.bottomline_data .element {
  clear: both;
  padding: 0.7em 0.5em 0.7em 12px;
  border-bottom: 0.5px solid black;
}

.bottomline_data .address {
}

.bottomline .element:nth-child(2n+1) {
  background-color: #eeeeee;
}
.bottomline .leftsmall .date {
  color: black;
}

.bottomline {
  padding-bottom: 1em;
}

.margin_bottom {
  margin-bottom: 0.5em;
}

.menu {
  margin-top: 0.7em;
  font-size: 1.015em;
}

/* tooltip */
.tooltipTrigger {
  position: relative;
  cursor: help;
}

.tooltip {
  display: none;
  font-weight: bold;
}

.tooltipTrigger:hover .tooltip,.showTooltip .tooltip {
  display: block;
  position: absolute;
  top: 2em;
  left: 2em;
  background-color: white;
  border: 0.1em solid black;
  z-index: 100;
  font-size: 11px;
  padding: 0.5em;
  color: black;
}

.tooltipentry {
  display: block;
}

.backlinktooltip {
  width: 80px;
}

.warning .collapseLinks {
  font-weight: normal;
  float: none;
}

.warningBody .section_text {
  padding: 0 0 0 20px;
}

.warningBody .section_table {
  margin-left: 0px;
  width: 856px;
}

.warningBody .section_table th {
  background-color: transparent;
  border-left: none;
}

.warningBody .section_table tr.even {
  background-color: transparent;
}

.warningBody .section_table {
  margin-left: 0px;
  width: 856px;
}

.warningBody ul {
  padding-left: 25px;
  margin: 3px 0px 3px 0px;
}

.infotooltip {
  width: 470px;
}

.tableofcontenttooltip {
  width: 170px;
}

.risktooltip {
  width: 100px;
}


/* end tooltip */

.footer {
  margin-bottom: 100px;
  font-size: 1.015em;
  margin-top: 3px;
}

.footer_logo {
  float: right;
  height: 40px;
  width: 40px;
  padding-bottom: 1em;
}

/*
*	hide/show collapse triggers and collapseable
* by default (no javascript) triggers are hidden and content is shown
*/
.hide_all,.show_all, .print, .show_tableofcontents, .hide_tableofcontents {
  display: none;
}
.hide_all,.show_all, .show_tableofcontents, .hide_tableofcontents {
  padding-right: 1em;
}

.collapseLinks {
  display: none;
  float: right;
}

.hideCreatedByTo .leftwide p,.hideCreatedByTo .leftwide div {
  display: none;
}

html .hideCreatedByTo .leftwide p.organisationName {
  display: block;
}

.hideBottomlineCollapseable .leftwide div,.hideBottomlineCollapseable .leftwide p.telecom,.hideBottomlineCollapseable .leftsmall p
  {
  display: none;
}

.responsibleContact {
  border: 0.1em solid black;
  width: 40%;
  background-color: #ffff99;
  padding: 1em 1em 1em 20px;
  margin-bottom: 1em;
}

.responsibleContact .organisationName {
  font-weight: bold;
  word-wrap: break-word;
}

.responsibleContactAddress {
  padding-left: 1em;
}

/* warncontainer */
.warncontainer {
  background-color: #FFE17F;
  margin-bottom: 1em;
  padding: 0.7em 12px 0.2em 12px;
  font-size: 1.015em;
}

.warncontainer a {
  padding-left: 0.5em;
  color: black;
  text-decoration: none;
}

.warncontainer a:hover {
  text-decoration: underline;
}


.warncontainer img {
  vertical-align: top;
}

.warningIcon {
  background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($warningIcon),'&#32;','')" />);
  background-size: 14px 14px;
}

.warningIcon:hover {
  background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($warningIconHover),'&#32;','')" />);
  background-size: 14px 14px;
}

.attachmentIcon {
  width: 12px;
  height: 12px;
  margin-right: 0.3em;
}

.country,
.uppercase {
  text-transform: uppercase;
}

.smallcaps {
  font-variant: small-caps;
}

.nonbreaking {
  white-space: nowrap;
}

#IDPatientContainer {
  background-color: #BFD5EE;
}

#IDEncounterContainer {
  background-color: #E4ECF7;
}

.patientinformation_even{
  background-color: #FFFFFF;
}

.patientinformation_odd{
  background-color: #E8E8E8;
}

.inlineimg{
  max-width: 100%;
}

.multimediaicon {
  position: relative;
  top: 3px;
}

.serviceeventlist {
  padding: 0 0 0 0px;
  margin: 0 0 0 0px;
  list-style: none;
}

.deprecated {
  height: 100px;
  font-size: 88px;
  font-weight: bold;
  color: red;
  letter-spacing: 42px;
  margin: 15px;
  line-height: 100%;
}

.warning {
  float: left;
  width: 100%;
  margin-bottom: 0.5em;
}

p.warning img {
  float: left;
}

.tableofcontentsMinimize {
  float: left; 
  padding: 0 0.5em; 
  width: 20px;
}

.expandIcon {
  width: 20px;
  height: 20px;
  float: right;
  background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($expandIcon),'&#32;','')" />);
  margin-left: 0.2em;
}

.expandIcon:hover {
  width: 20px;
  height: 20px;
  float: right;
  background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($expandIconHover),'&#32;','')" />);
  margin-left: 0.2em;
}

.collapseIcon {
  width: 20px;
  height: 20px;
  float: right;
  background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($collapseIcon),'&#32;','')" />);
  margin-left: 0.2em;
}

.collapseIcon:hover {
  width: 20px;
  height: 20px;
  float: right;
  background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($collapseIconHover),'&#32;','')" />);
  margin-left: 0.2em;
}

.collapsable {
  margin-top: 0.5em;
  padding-bottom: 0.5em;
}

.metaInformationLine {
  padding-bottom: 0.15em;
}

.authenticatorContainerNoPadding {
  padding-bottom: 0em;
}

.show_tableofcontents, .hide_tableofcontents, .hide_all, .show_all {
  float: left;
}

#backToTopContainer {
    width: 953px;
    position: fixed;
    bottom: 0%;
    margin-bottom: 30px;
}

.modal {
  display: none;
  position: fixed;
  z-index: 100;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(200,200,200);
  background-color: rgba(0,0,0,0.4);
}

.modal-content {
  background-color: #EEEEEE;
  margin: 15% auto;
  border: 1px solid #004a8d;
  width: 900px;
}

.modal-header {
  padding: 20px;
}

.modal-footer {
  padding: 20px;
  padding-bottom: 23px;
  text-align: right;
}

.modal-body {
  padding-left: 20px;
  padding-right: 20px;
}

.modal-close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.modal-close:hover, .modal-close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

.modal-ok, .modal-ok:visited {
  color: #FFF;
  background-color: #004a8d;
  text-decoration: none;
  padding-left: 20px;
  padding-right: 20px;
  padding-top: 7px;
  padding-bottom: 7px;
  font-weight: bold;
}

.modal-ok:hover, .modal-ok:focus {
  color: #aaa;
  text-decoration: none;
  cursor: pointer;
}

.infoButton {
  cursor: pointer;
  height: 13px;
  width: 13px;
  vertical-align: middle;
}
        </style>
        <style type="text/css" media="print">
html body {
  font-size: 12pt;
}

html .bodyContentContainer {
  width: 100%;
  margin: 0;
}

html .hide_all,.show_all, .print, .collapseShow, .collapseHide,
.show_tableofcontents, .hide_tableofcontents, .backlink {
  display: none !important;
}

html .section_text, html .section_indent {
  padding: 0;
}

html .hideCreatedByTo .leftsmall, html .hideCreatedByTo .leftwide,
html .createdbyto .leftsmall, html .createdbyto .leftwide {
  float: none;
  text-align: left;
}
html .hideCreatedByTo .leftwide,
html .createdbyto .leftwide {
  padding-left: 5em;
}

html .patientContainer .leftwide, html .patientContainer .leftsmall,
html .stayContainer .leftwide, html .stayContainer .leftsmall {
  float: none;
  padding-left: 10%;
  width: 100%;
}

a {
  text-decoration: none;
}

.footer_logo {
  height: 1cm;
  width: 1cm;
}

        </style>
<style type="text/css">

    .multimediaSubmit {
      border: medium none;
      color: #004A8D;
      cursor: pointer;
      text-decoration: underline;
      font-size: 100%;
      padding: 0 0 0 17px;
      margin: 0 0 0 0px;
    }

    .multimediaSubmit:hover {
        text-decoration: none;
    }

    .multimediaSubmitPDF {
      background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($pdfIcon),'&#32;','')" />);
    }

    .multimediaSubmitAudio {
      background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($audioIcon),'&#32;','')" />);
    }

    .multimediaSubmitVideo {
      background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($videoIcon),'&#32;','')" />);
    }

    .multimediaSubmitVarious {
      background: no-repeat left center url(<xsl:value-of select="translate(normalize-space($variousIcon),'&#32;','')" />);
    }

    .emptyblock {
        border: 0.1em dashed black !important;
    }

    .sectionTitle {
      padding-top: 0.5em;
      padding-bottom: 0.5em;
      font-weight: bold;
      font-size: 1.204em;
      <xsl:choose>
        <xsl:when test="$isSectionTitleWhiteBackgroundColor = 0">
          padding-left: 12px;
          background-color: #c9c9c9;
          margin-bottom: 0.5em;
          margin-top: 1.3em;
        </xsl:when>
        <xsl:otherwise>
          padding-left: 0px;
          margin-bottom: 0.0em;
          margin-top: 0.9em;
          background-color: #FFFFFF;
        </xsl:otherwise>
      </xsl:choose>
    }
</style>
        <script type="text/javascript">
<xsl:variable name="javascript">
<![CDATA[

var HIDE_SPECIAL_CONTAINER_CLASS = "hideCreatedByTo";
var SPECIAL_CONTAINER_CLASS = "createdbyto";
var COLLAPSEABLE_CONTAINER_CLASS = "collapsable";
var COLLAPSE_TRIGGER_CONTAINER_CLASS = "collapseTrigger";
var TABLE_OF_CONTENTS_CLASS = "tableofcontents";
var COLLAPSE_LINKS_CONTAINER_CLASS = "collapseLinks";
var HIDE_TRIGGER_CLASS = "collapseHide";
var SHOW_TRIGGER_CLASS = "collapseShow";
var HIDE_ALL_TRIGGER_CLASS = "hide_all";
var SHOW_ALL_TRIGGER_CLASS = "show_all";
var HIDE_TABLE_OF_CONTENTS_CLASS = "hide_tableofcontents";
var SHOW_TABLE_OF_CONTENTS_CLASS = "show_tableofcontents";
var PRINT_BUTTON_CLASS = "print";
var SHOW_BOTTOMLINE_CLASS = "bottomlineCollapseable";
var HIDE_BOTTOMLINE_CLASS = "hideBottomlineCollapseable";



function getElementsByClassFromNode(searchClass, node) {
    "use strict";
    var classElements = [],
        els,
        elsLen,
        pattern,
        i = 0,
        j = 0,
        tag = '*';

    els = node.getElementsByTagName(tag);
    elsLen = els.length;
    pattern = new RegExp("(^|\\s)" + searchClass + "(\\s|$)");
    for (i = 0; i < elsLen; i++) {
        if (pattern.test(els[i].className)) {
            classElements[j] = els[i];
            j++;
        }
    }
    return classElements;
}

function getElementsByClass(searchClass) {
    "use strict";
    return getElementsByClassFromNode(searchClass, window.document);
}

function updateStyleDisplay(node, value) {
    "use strict";
    var i = 0;
    for (i = 0; i < node.length; i++) {
        node[i].style.display = value;
    }
}

function setCollapseContainer(node, hide) {
    "use strict";
    if (node.tagName === "BODY") {
        return false;//error
    }
    if (node.className === SPECIAL_CONTAINER_CLASS || node.className === HIDE_SPECIAL_CONTAINER_CLASS) {
        if (hide === true) {
            node.className = HIDE_SPECIAL_CONTAINER_CLASS;
        } else {
            node.className = SPECIAL_CONTAINER_CLASS;
        }
        return true;
    }
    if (node.className === COLLAPSE_TRIGGER_CONTAINER_CLASS) {
        if (hide === true) {
            if (node.nextSibling.nodeType === 3) {
                node.nextSibling.nextSibling.style.display = "none";
            } else {
                node.nextSibling.style.display = "none"; //IE
            }
        } else {
            if (node.nextSibling.nodeType === 3) {
                node.nextSibling.nextSibling.style.display = "";
            } else {
                node.nextSibling.style.display = ""; //IE
            }
        }
        return true;
    }
    if (node.className === SHOW_BOTTOMLINE_CLASS || node.className === HIDE_BOTTOMLINE_CLASS) {
        if (hide === true) {
            node.className = HIDE_BOTTOMLINE_CLASS;
        } else {
            node.className = SHOW_BOTTOMLINE_CLASS;
        }
        return true;
    }
    setCollapseContainer(node.parentNode, hide);
}

/* all dynamic hideables in arrays */
var hideTriggerElements = null;
var showTriggerElements = null;
var collapseLinkContainerElements = null;
var showAllElements = null;
var hideAllElements = null;
var printElement = null;
var collapseAllElements = null;
var createdByToElements = null;
var bottomlineElements = null;
var tableofcontentsElement = null;
var hideTableofcontens = null;
var showTableofcontens = null;

function showCollapsed(node) {
    "use strict";
    setCollapseContainer(node, false); //false = show
    node.previousSibling.style.display = "block";
    node.style.display = "none";
    return false;
}

function hideCollapseable(node) {
    "use strict";
    setCollapseContainer(node, true); //true = hide
    node.nextSibling.style.display = "block";
    node.style.display = "none";
    return false;
}


function showAll() {
    "use strict";
    var i = 0;
    updateStyleDisplay(collapseAllElements, "");
    updateStyleDisplay(hideAllElements, "inline");
    updateStyleDisplay(showAllElements, "");
    updateStyleDisplay(hideTriggerElements, "block");
    updateStyleDisplay(showTriggerElements, "none");
    for (i = 0; i < createdByToElements.length; i++) {
        createdByToElements[i].className = SPECIAL_CONTAINER_CLASS;
    }
    for (i = 0; i < bottomlineElements.length; i++) {
        bottomlineElements[i].className = SHOW_BOTTOMLINE_CLASS;
    }
    showTableOfContents();
    return false;
}

function hideAll() {
    "use strict";
    var i = 0;
    updateStyleDisplay(collapseAllElements, "none");
    updateStyleDisplay(hideAllElements, "");
    updateStyleDisplay(showAllElements, "inline");
    updateStyleDisplay(hideTriggerElements, "none");
    updateStyleDisplay(showTriggerElements, "block");
    for (i = 0; i < createdByToElements.length; i++) {
        createdByToElements[i].className = HIDE_SPECIAL_CONTAINER_CLASS;
    }
    for (i = 0; i < bottomlineElements.length; i++) {
        bottomlineElements[i].className = HIDE_BOTTOMLINE_CLASS;
    }
    hideTableOfContents();
    return false;
}

function showTableOfContents() {
    "use strict";
    updateStyleDisplay(hideTableofcontens, "inline");
    updateStyleDisplay(showTableofcontens, "");
    updateStyleDisplay(tableofcontentsElement, "");
    return false;
}

function hideTableOfContents() {
    "use strict";
    updateStyleDisplay(hideTableofcontens, "");
    updateStyleDisplay(showTableofcontens, "inline");
    updateStyleDisplay(tableofcontentsElement, "none");
    return false;
}

function toggleCollapseable(node) {
    "use strict";
    var collapseLinksContainer,
        collapseLinks,
        i;
    collapseLinksContainer = getElementsByClassFromNode("collapseLinks", node);
    if(collapseLinksContainer && collapseLinksContainer.length > 0) {
        collapseLinks = collapseLinksContainer[0].getElementsByTagName("A");
        for (i = 0; i < collapseLinks.length; i++) {
            if(collapseLinks[i].style.display === "block" || collapseLinks[i].style.display === "") {
                if(collapseLinks[i].className === SHOW_TRIGGER_CLASS) {
                    showCollapsed(collapseLinks[i]);
                } else {
                    hideCollapseable(collapseLinks[i]);
                }
                break;
            }
        }
    }
}

function jump(elementID) {
    "use strict";
    var collapseLinksContainer,
        collapseLinks,
        i,
        node;
    node = window.document.getElementById(elementID);
    collapseLinksContainer = getElementsByClassFromNode("collapseLinks", node);
    if(collapseLinksContainer && collapseLinksContainer.length > 0) {
        collapseLinks = collapseLinksContainer[0].getElementsByTagName("A");
        for (i = 0; i < collapseLinks.length; i++) {
            if(collapseLinks[i].style.display === "block" || collapseLinks[i].style.display === "") {
                if(collapseLinks[i].className === SHOW_TRIGGER_CLASS) {
                    showCollapsed(collapseLinks[i]);
                }
                break;
            }
        }
    }
}

/* init document */
window.onload = startWrapper;

function startWrapper() {
  start();
  printiconcontrol();
};

function start() {
    "use strict";
    var i = 0;
    //(javascript works) setup triggers, hide content

    // hide [-]
    hideTriggerElements = getElementsByClass(HIDE_TRIGGER_CLASS);
    updateStyleDisplay(hideTriggerElements, "none");

    showTriggerElements = getElementsByClass(SHOW_TRIGGER_CLASS);
    // show collapse triggers
    collapseLinkContainerElements = getElementsByClass(COLLAPSE_LINKS_CONTAINER_CLASS);
    updateStyleDisplay(collapseLinkContainerElements, "block");

    showAllElements = getElementsByClass(SHOW_ALL_TRIGGER_CLASS);
    updateStyleDisplay(showAllElements, "inline");

    // show table of contents button
    showTableofcontens = getElementsByClass(SHOW_TABLE_OF_CONTENTS_CLASS);
    updateStyleDisplay(showTableofcontens, "inline");

    hideAllElements = getElementsByClass(HIDE_ALL_TRIGGER_CLASS);
    hideTableofcontens = getElementsByClass(HIDE_TABLE_OF_CONTENTS_CLASS);

    /* hide all collapseable elements */
    collapseAllElements = getElementsByClass(COLLAPSEABLE_CONTAINER_CLASS);
    updateStyleDisplay(collapseAllElements, "none");

    createdByToElements = getElementsByClass(SPECIAL_CONTAINER_CLASS);
    for (i = 0; i < createdByToElements.length; i++) {
        createdByToElements[i].className = HIDE_SPECIAL_CONTAINER_CLASS;
    }

    bottomlineElements = getElementsByClass(SHOW_BOTTOMLINE_CLASS);
    for (i = 0; i < bottomlineElements.length; i++) {
        bottomlineElements[i].className = HIDE_BOTTOMLINE_CLASS;
    }

    tableofcontentsElement = getElementsByClass(TABLE_OF_CONTENTS_CLASS);
    updateStyleDisplay(tableofcontentsElement, "none");
};
]]>
</xsl:variable>

<xsl:variable name="b64decode">
<![CDATA[
    function decodeB64 (id,mimetype) {
        var e=document.getElementById (id);
        if (e) {
            var value=e.innerText.replace (/[^ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=]/g,"");
            var x=window.atob (value);
            var len=x.length;
            var b=new ArrayBuffer (len);
            var a=new Uint8Array (b);
            for (var k=0;k<len;k++) {
                a[k]=x.charCodeAt (k);
            }
            var d=new Blob ([a],{type:mimetype});
            if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                window.navigator.msSaveOrOpenBlob (d);
            } else {
                var u=window.URL.createObjectURL (d);
                window.open (u);
            }
        }
    }

    var generalOnLoad = window.onload;
    window.onload = function () {
        if (generalOnLoad) {
            generalOnLoad();
        }

        initInfoButton();
    };

  ]]>
</xsl:variable>

<xsl:variable name="jsprinticoncontrol">
  <xsl:choose>
    <xsl:when test="$printiconvisibility='1'">
      <![CDATA[
        function printiconcontrol() {
          "use strict";
          // show print button
          printElement = getElementsByClass(PRINT_BUTTON_CLASS);
          updateStyleDisplay(printElement, "inline");
        };
      ]]>
    </xsl:when>
    <xsl:otherwise>
       <![CDATA[
        function printiconcontrol() {
          "use strict";
          // hide print button
          printElement = getElementsByClass(PRINT_BUTTON_CLASS);
          updateStyleDisplay(printElement, "none");
        };
      ]]>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>


      <!-- Beginning of CDATA section -->
      <xsl:text disable-output-escaping="yes"><![CDATA[//<]]></xsl:text><xsl:text disable-output-escaping="yes">![CDATA[</xsl:text>

      <!-- original javascript -->
      <xsl:value-of  select="$javascript" disable-output-escaping="yes"/>

<xsl:value-of select="$b64decode" disable-output-escaping="yes"/>
      
      <xsl:value-of select="$jsprinticoncontrol" disable-output-escaping="yes" />

      <!-- End of CDATA section -->
      <xsl:text>//]]</xsl:text><xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>

        </script>
        
        <xsl:if test="$useexternalcss=1">
          <style type="text/css" media="screen">
            <xsl:value-of select="document($externalcssname)" />
          </style>
        </xsl:if>
        
      </head>

      <!--
        HTML Body
      -->
      <body>
      <div class="outerContainer" id="elgadocument">
        <div class="bodyContentContainer">
        
        <xsl:call-template name="documentstate" />
        
        <!-- document header -->
        
        <div class="header">
          <xsl:if test="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component/n1:section[n1:code/@code = 'BRIEFT']/n1:entry/n1:observationMedia">
            <div class="logo">
              <xsl:call-template name="renderLogo">
                <xsl:with-param name="logo" select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component/n1:section/n1:entry/n1:observationMedia" />
              </xsl:call-template>
            </div>
          </xsl:if>
          <div style="float: left; width: 573px;">
            <h1 class="tooltipTrigger margin_bottom">
              <b>
                <span class="title">
                  <xsl:value-of select="$title"/>
                </span>
              </b>
              <span class="tooltip">
                <xsl:call-template name="getHL7ATXDSDokumentenklassen">
                  <xsl:with-param name="code" select="/n1:ClinicalDocument/n1:code/@code" />
                </xsl:call-template>
              </span>
            </h1>
            <p class="subtitle_create">
              <xsl:text>Erzeugt am </xsl:text>
              <xsl:call-template name="formatDate">
                <xsl:with-param name="date" select="/n1:ClinicalDocument/n1:effectiveTime" />
                <xsl:with-param name="date_shortmode">false</xsl:with-param>
              </xsl:call-template>
              <xsl:text> | Version: </xsl:text><xsl:value-of select="/n1:ClinicalDocument/n1:versionNumber/@value" />
            </p>
          </div>
          <div class="clearer" />
            <hr />
            <div class="menu">
              <a class="show_tableofcontents" href="#" onclick="showTableOfContents(); return false;">
                Inhaltsverzeichnis ausklappen
                <span class="tooltipTrigger">
                  <div class="expandIcon" />
                  <span class="tooltip">
                    <span>ausklappen</span>
                  </span>
                </span>
              </a>
              <a class="hide_tableofcontents" href="#" onclick="hideTableOfContents(); return false;">
                Inhaltsverzeichnis einklappen
                <span class="tooltipTrigger">
                  <div class="collapseIcon" />
                  <span class="tooltip">
                    <span>einklappen</span>
                  </span>
                </span>
              </a>
              <a class="show_all" href="#" onclick="showAll(); return false;">
                Alle Inhalte ausklappen
                <span class="tooltipTrigger">
                  <div class="expandIcon" />
                  <span class="tooltip">
                    <span>ausklappen</span>
                  </span>
                </span>
              </a>
              <a class="hide_all" href="#" onclick="hideAll(); return false;">
                Alle Inhalte einklappen
                <span class="tooltipTrigger">
                  <div class="collapseIcon" />
                  <span class="tooltip">
                    <span>einklappen</span>
                  </span>
                </span>
              </a>
              <a class="print" href="#" onclick="javascript:window.print()">
                <img alt="Dokument drucken" src="data:image/gif;base64,R0lGODlhFAAUAKIEAENFRcHCwoKDgwQHB////wAAAAAAAAAAACH5BAEAAAQALAAAAAAUABQAAANbSDrcrjCSAYK9TcYh9CDAp02dJIYj5zmBFJbjJEIMnM5ByAB87+8dh3DoEBCPRUosxlEuPUaADMloNaWUixZjNQ4CqiUHLNCFmRmazdMyrU3tDbWqEdjv+Hs8AQA7" />
              </a>
            </div>
            <div style="clear: both;" />
        </div>
        <!-- END document header -->

        <!--
          table of contents
          if there is no javascript enabled it is shown as default
          else it is hidden and can be shown
          on click jump to the element (if needed opens the elemnt before)
        -->
        <div class="tableofcontents">
          <div class="left">
            <div class="container">
              <p>
                <a href="#IDPatientContainer" onclick="jump('IDPatientContainer');"><xsl:value-of select="$genderedpatient" /></a>
              </p>
              <xsl:if test="//n1:ClinicalDocument/n1:componentOf">
                <p>
                  <a href="#IDEncounterContainer" onclick="jump('IDEncounterContainer');">
                    <xsl:call-template name="getEncounter" />
                  </a>
                </p>
              </xsl:if>
              <xsl:text>-----</xsl:text>
              <xsl:choose>
                <xsl:when test="n1:component/n1:structuredBody">
                  <xsl:for-each select="//n1:section" >
                    <xsl:variable name="indent" select="count(ancestor::*/n1:section)-1" />
                    <xsl:choose>
                        <!-- do not show following titel -->
                        <xsl:when test="n1:code/@code = 'BRIEFT' "/>
                        <xsl:when test="n1:code/@code = 'ABBEM' "/>
                        <xsl:otherwise>
                            <xsl:variable name="anchor">
                                <xsl:choose>
                                    <xsl:when test="n1:code[(@code='51898-5' or @code='48765-2') and @codeSystem ='2.16.840.1.113883.6.1']">
                                        <xsl:text>#</xsl:text><xsl:value-of select="n1:code/@code" /><xsl:text>-</xsl:text><xsl:value-of select="../../n1:code/@code" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>#id</xsl:text><xsl:value-of select="n1:code/@code" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <p style="padding-left: {$indent}em;"><a href="{$anchor}">
                                <xsl:choose>
                                    <xsl:when test="n1:code[(@code='51898-5' or @code='48765-2') and @codeSystem ='2.16.840.1.113883.6.1']">
                                        <xsl:call-template name="getRiskTitle">
                                            <xsl:with-param name="code" select="n1:code/@code" />
                                        </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="n1:title" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </a></p>
                        </xsl:otherwise>
                    </xsl:choose>
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <p><a href="#IDBody"><xsl:text>Unstrukturierter Inhalt</xsl:text></a></p>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:text>-----</xsl:text>
              <p><a href="#IDResponsibleContact" onclick="jump('IDResponsibleContact');">Kontaktperson für Fragen</a></p>
              <p><a href="#IDAuthenticatorContainer" onclick="jump('IDAuthenticatorContainer');">Unterzeichnet von</a></p>
              <p><a href="#IDBottomline" onclick="jump('IDBottomline');">Zusätzliche Informationen über das Dokument</a></p>
            </div>
          </div>
          <div class="right" />
          <div class="clearer" />
        </div><!-- END table of contents -->


        <!--
          Patient element collapseable includes information about the stay
        -->
        <xsl:variable name="sex" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:administrativeGenderCode/@code"/>

        <xsl:variable name="sexName">
          <xsl:choose>
            <xsl:when test="$sex='M'">Männlich</xsl:when>
            <xsl:when test="$sex='F'">Weiblich</xsl:when>
            <xsl:when test="$sex='UN'">Divers</xsl:when>
            <xsl:when test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:administrativeGenderCode/@nullFlavor='NA'">
              offen
            </xsl:when>
            <xsl:when test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:administrativeGenderCode/@nullFlavor='UNK'">
              unbekannt
            </xsl:when>
            <xsl:otherwise>unbekannt</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:variable name="localizedSex">
          <xsl:choose>
            <xsl:when test="$sex='M'">M</xsl:when>
            <xsl:when test="$sex='F'">W</xsl:when>
            <xsl:when test="$sex='UN'">D</xsl:when>
            <xsl:otherwise>
              <xsl:text>unbekannt (</xsl:text>
              <xsl:value-of select="$sex" />
              <xsl:text>)</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:variable name="birthdate_short">
          <xsl:call-template name="formatDate">
            <xsl:with-param name="date" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:birthTime"/>
           <xsl:with-param name="date_shortmode">true</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="birthdate_long">
          <xsl:call-template name="formatDate">
            <xsl:with-param name="date" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:birthTime"/>
            <xsl:with-param name="date_shortmode">false</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="svnnumber">
          <xsl:choose>
            <xsl:when test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:id[@root='1.2.40.0.10.1.4.3.1']/@extension">
              <xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:id[@root='1.2.40.0.10.1.4.3.1']/@extension"/>
            </xsl:when>
            <xsl:otherwise>nicht angegeben</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <div class="patientContainer">
          <div class="collapseTrigger" onclick="toggleCollapseable(this);" id="IDPatientContainer">
            <div class="patientTitle">
              <h1>
                <b>
                  <xsl:value-of select="$genderedpatient"/>
                  <xsl:text>:</xsl:text>
                </b>
              </h1>
            </div>
            <div class="patientShortInfo">
              <h1 class="name">
                <xsl:call-template name="getName">
                  <xsl:with-param name="name" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:name"/>
                  <xsl:with-param name="printNameBold" select="string(true())" />
                </xsl:call-template>

                <xsl:if test="$sex != ''">
                  <xsl:text> (</xsl:text>
                  <span>
                    <xsl:value-of select="$localizedSex" />
                  </span>
                  <xsl:text>)</xsl:text>
                </xsl:if>

                <xsl:text> SVN: </xsl:text>
                <xsl:value-of select="$svnnumber"/>
                
                <xsl:if test="//n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:guardian">
                  <xsl:text> </xsl:text>
                  <span class="tooltipTrigger">
                    <xsl:call-template name="getPatientGuardianIconTitle" />
                    <span class="tooltip" style="width: 120px;">
                      <span>gesetzlicher Vertreter</span>
                    </span>
                  </span>
                </xsl:if>
                
              </h1>
            </div>
            <xsl:call-template name="collapseTrigger"/>
            <div class="clearer"/>
          </div>
          <div class="collapsable">

            <div class="boxLeft">
              <!-- allgemeine Daten -->
              <xsl:call-template name="getPatientInformationData">
                <xsl:with-param name="sexName" select="$sexName"/>
                <xsl:with-param name="birthdate_long" select="$birthdate_long"/>
                <xsl:with-param name="svnnumber" select="$svnnumber"/>
              </xsl:call-template>
            </div>
            <div class="boxRight">
              <!-- bekannte Adressen -->
              <xsl:call-template name="getPatientAdress"/>

              <!-- Sachwalter / Vormund -->
              <xsl:call-template name="getPatientGuardian"/>
            </div>

            <div class="clearer"/>

          </div>
        </div>
        <!-- END patient element -->

        <!-- Encounter / Aufenthalt -->
        <xsl:if test="//n1:ClinicalDocument/n1:componentOf">
          <div class="patientContainer">
            <div class="collapseTrigger" onclick="toggleCollapseable(this);" id="IDEncounterContainer">
              <div class="patientTitle">
                <h1>
                  <b>
                    <xsl:call-template name="getEncounter"/>
                    <xsl:text>:</xsl:text>
                  </b>
                </h1>
              </div>
              <div class="patientShortInfo">
                <h1>
                  <p class="subTitle">
                    <xsl:call-template name="getName">
                      <xsl:with-param name="name" select="/n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:serviceProviderOrganization/n1:name"/>
                    </xsl:call-template>
                  </p>
                  <p class="name">
                    <b>
                      <xsl:call-template name="getEncounterText" />
                    </b>
                  </p>
                </h1>
              </div>
              <xsl:call-template name="collapseTrigger"/>
              <div class="clearer"/>
            </div>
            <div class="collapsable">
              <xsl:call-template name="getPatientStay"/>
            </div>
          </div>
        </xsl:if>
        <!-- END encounter element -->

        <!-- START fullfillment element -->
        <xsl:if test="//n1:ClinicalDocument/n1:inFulfillmentOf">
          <div class="patientContainer">
            <div class="collapseTrigger" onclick="toggleCollapseable(this);" id="IDEncounterContainer">
              <div class="patientTitle">
                <h1>
                  <b>
                    <xsl:text>Auftraggeber(in):</xsl:text>
                  </b>
                </h1>
              </div>
              <div class="patientShortInfo">
                <h1>
                  <p class="name">
                    <b>
                      <xsl:choose>
                        <xsl:when test="//n1:ClinicalDocument/n1:participant[@typeCode='REF']/n1:associatedEntity/n1:scopingOrganization/n1:name">
                          <xsl:call-template name="getName">
                            <xsl:with-param name="name" select="//n1:ClinicalDocument/n1:participant[@typeCode='REF']/n1:associatedEntity/n1:scopingOrganization/n1:name"/>
                          </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>nicht angegeben</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </b>
                  </p>
                </h1>
              </div>
              <xsl:call-template name="collapseTrigger"/>
              <div class="clearer"/>
            </div>
            <div class="collapsable">
              <xsl:call-template name="getOrderingProvider"/>
            </div>
          </div>
        </xsl:if>
        <!-- END fullfillment element -->

    <!--
      Warn container
      displays urgent information like risk or alternative denial if the document is well structured with [!]
      if the document is not well structured, there may be such information [?]
    -->
        
    <xsl:variable name="isStructuredDoc">
      <xsl:choose>
        <xsl:when test="/n1:ClinicalDocument/n1:templateId/@root ='1.2.40.0.34.11.2.0.2' or /n1:ClinicalDocument/n1:templateId/@root ='1.2.40.0.34.11.2.0.3' or
                        /n1:ClinicalDocument/n1:templateId/@root ='1.2.40.0.34.11.3.0.2' or /n1:ClinicalDocument/n1:templateId/@root ='1.2.40.0.34.11.3.0.3' or
                        /n1:ClinicalDocument/n1:templateId/@root ='1.2.40.0.34.11.12.0.2' or /n1:ClinicalDocument/n1:templateId/@root ='1.2.40.0.34.11.12.0.3'">
          <xsl:value-of select="string(true())" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="string(false())" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

	<xsl:variable name="hasWarnings">
      <xsl:choose>
        <xsl:when test="(//*/n1:code/@code = '51898-5' and //*/n1:code/@codeSystem ='2.16.840.1.113883.6.1') or (//*/n1:code/@code = '48765-2' and //*/n1:code/@codeSystem ='2.16.840.1.113883.6.1')">
          <xsl:value-of select="string(true())" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="string(false())" />
        </xsl:otherwise>
      </xsl:choose>
	</xsl:variable>

	<xsl:variable name="isDischarge">
      <xsl:choose>
        <xsl:when test="/n1:ClinicalDocument/n1:templateId/@root ='1.2.40.0.34.11.2' or /n1:ClinicalDocument/n1:templateId/@root ='1.2.40.0.34.11.3'">
          <xsl:value-of select="string(true())" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="string(false())" />
        </xsl:otherwise>
      </xsl:choose>
	</xsl:variable>

    <xsl:choose>
      <xsl:when test="$hasWarnings='true'">
        <div class="warncontainer" id="IDWarnContainer">
          <div class="warncontainer_content">
            <xsl:for-each select="//*/n1:code[(@code='51898-5' or @code='48765-2') and @codeSystem ='2.16.840.1.113883.6.1']">
              <xsl:variable name="riskId">
                <xsl:value-of select="concat('#', @code, '-', ../../../n1:code/@code)"/>
              </xsl:variable>
              <p class="warning">
                <span class="collapseLinks tooltipTrigger">
                  <a href="{$riskId}" class="warningIcon" style="padding-left: 20px">
                    <b>
                      <xsl:call-template name="getRiskTitle">
                        <xsl:with-param name="code" select="@code"/>
                      </xsl:call-template>
                    </b>
                    <xsl:text>: </xsl:text>
                    <span class="tooltip risktooltip">
                      <xsl:text>Gehe zum: Risiko</xsl:text>
                    </span>
                  </a>
                </span>
                <div class="warningBody">
                  <xsl:apply-templates select="./../n1:text" />
                </div>
              </p>
            </xsl:for-each>
            <div style="clear: both;"></div>
          </div>
        </div>
      </xsl:when>
      <xsl:when test="$hasWarnings='false' and $isStructuredDoc='false' and $isDischarge='true'">
        <div class="warncontainer" id="IDWarnContainer">
          <div class="warncontainer_content">
            <p class="warning">
              <span class="warningIcon" style="padding-left: 20px;">
                <xsl:text>Für dieses Dokument wurden keine automatischen Hinweistexte erzeugt. Wichtige Informationen über Allergien, Risiken, Patientenverfügungen etc. sind möglicherweise im Befundtext enthalten.</xsl:text>
              </span>
            </p>
            <div style="clear: both;"></div>
          </div>
        </div>
      </xsl:when>
    </xsl:choose>

    <!--
      BODY
    -->
    <div class="body_section" id="IDBody">
      <!-- javascript is disabled -->
      <noscript>
        <div style="padding: 1em 0 1em 0">
          <b>Aktive Inhalte (in lokalen Dateien) werden in Ihrem Browser nicht zugelassen. Bitte treffen Sie die entsprechenden Einstellungen für eine optimale Darstellung.</b>
        </div>
      </noscript>
      <xsl:apply-templates select="n1:component/n1:structuredBody|n1:component/n1:nonXMLBody"/>
      <br/>
      <br/>
    </div>
    <!-- END body section -->

          <!--
              FOOTER
          -->
        <xsl:call-template name="bottomline"/>
        <div class="clearer"></div>

        <hr />
        <div class="footer">
          <a href="http://www.elga.gv.at" target="_blank">
            <img class="footer_logo" alt="" src="data:image/png;base64,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" />
          </a>
          <p>ELGA - Meine elektronische Gesundheitsakte <a href="http://www.gesundheit.gv.at" target="_blank">www.gesundheit.gv.at</a></p>

          <xsl:call-template name="documentstate" />
        </div>
        <div id="backToTopContainer">
          <span class="collapseLinks tooltipTrigger" style="display: block; float: right;">
            <a class="backlink" href="#elgadocument">

              <span class="tooltip backlinktooltip">
                <span>nach oben</span>
              </span>
            </a>
          </span>
        </div>
        <div style="clear: both;"></div>

        <div id="infoButtonPopUp" class="modal">
          <div class="modal-content">
            <div class="modal-header">
              <b>Information</b>
              <span id="modalClose" class="modal-close">&#215;</span>
            </div>
            <div class="modal-body">
              <p>Sie werden nun zu einer Informationsseite am öffentlichen Gesundheitsportal Österreichs weitergeleitet. Dieser Link ist nicht Teil des unterzeichneten Befundes. Er wurde nachträglich automatisch zur Anzeige hinzugefügt.</p>
            </div>
            <div class="modal-footer">
              <a id="eHealthPortalLinkAllowAlways" target="_blank" style="text-decoration: none; margin-right: 14px;"><span class="modal-ok">Immer erlauben</span></a>
              <a id="eHealthPortalLink" target="_blank" style="text-decoration: none;"><span class="modal-ok">Erlauben</span></a>
            </div>
          </div>
        </div>

        </div>
      </div>
        <script type="text/javascript">
          <xsl:variable name="javascriptpopup">
            <![CDATA[

              function initInfoButton() {
                var dialog = document.getElementById("infoButtonPopUp")
                var buttonOpenLink = document.getElementById("eHealthPortalLink")
                var buttonOpenLinkAllowAlways = document.getElementById("eHealthPortalLinkAllowAlways")
                var infoButtons = getElementsByClass("infoButton")
                for (var i=0; i<infoButtons.length; i++) {
                  infoButtons[i].onclick = function() {
                    if(getCookie("elgaSkipInfoButtonDialog") == "true") {
                      buttonOpenLinkAllowAlways.href = this.getAttribute("data-targetUrl")
                      buttonOpenLinkAllowAlways.click()
                    } else {
                      setUpInfoButtonRedirectButton(dialog, buttonOpenLink, this.getAttribute("data-targetUrl"), false)
                      setUpInfoButtonRedirectButton(dialog, buttonOpenLinkAllowAlways, this.getAttribute("data-targetUrl"), true)
                    }
                  }
                }

                var span = document.getElementById("modalClose")
                  span.onclick = function() {
                  hideModalDialog()
                }

                window.onclick = function(event) {
                  if (event.target == dialog) {
                    hideModalDialog()
                  }
                }

                var isChrome = /Chrome/.test(navigator.userAgent) && /Google Inc/.test(navigator.vendor);
                if (isChrome == true) {
                  buttonOpenLinkAllowAlways.style.display = "none"
                }
              }

              function hideModalDialog() {
                var dialog = document.getElementById("infoButtonPopUp")
                dialog.style.display = "none"
              }

              function setUpInfoButtonRedirectButton(dialog, button, targetUrl, savePreference) {
                dialog.style.display = "block";

                button.href = targetUrl
                button.onclick = function() {
                  setCookie("elgaSkipInfoButtonDialog", savePreference.toString())
                  hideModalDialog()
                }
              }

              function setCookie(cname, cvalue) {
                document.cookie = cname + "=" + cvalue + ";expires=Fri, 31 Dec 9999 23:59:59 GMT;path=/"
              }

              function getCookie(cname) {
                var name = cname + "="
                var decodedCookie = decodeURIComponent(document.cookie)
                var ca = decodedCookie.split(';')
                for(var i = 0; i <ca.length; i++) {
                  var c = ca[i]
                  while (c.charAt(0) == ' ') {
                    c = c.substring(1)
                  }
                  if (c.indexOf(name) == 0) {
                    return c.substring(name.length, c.length);
                  }
                }
                return ""
              }
            ]]>
          </xsl:variable>

          <xsl:text disable-output-escaping="yes"><![CDATA[//<]]></xsl:text><xsl:text disable-output-escaping="yes">![CDATA[</xsl:text>
          <xsl:value-of select="$javascriptpopup" disable-output-escaping="yes" />
          <xsl:text>//]]</xsl:text><xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>

        </script>
      </body>

    </html>
  </xsl:template>


  <!-- Print elements as separated list -->
  <xsl:template name="renderListItems">
    <xsl:param name="list" />

    <xsl:for-each select="$list">
      <xsl:if test="position()>1"><xsl:text>, </xsl:text></xsl:if>
      <xsl:value-of select="." />
    </xsl:for-each>
  </xsl:template>

  <!-- Get a Name -->
  <xsl:template name="getName">
    <xsl:param name="name"/>
    <xsl:param name="printNameBold" select="string(false())" />

    <xsl:variable name="nameValue" >
      <xsl:choose>
        <xsl:when test="$name/n1:family">
          <xsl:if test="$name/n1:prefix">
            <xsl:for-each select="$name/n1:prefix">
              <xsl:value-of select="."/>
              <xsl:text> </xsl:text>
            </xsl:for-each>
          </xsl:if>
          <xsl:for-each select="$name/n1:given">
            <xsl:value-of select="."/>
            <xsl:text> </xsl:text>
          </xsl:for-each>
          <xsl:for-each select="$name/n1:family[not(@qualifier)]">
            <xsl:if test="count($name/n1:family[not(@qualifier)]) &gt; 1 and position() &gt; 1">
              <xsl:text> </xsl:text>
            </xsl:if>
                <xsl:value-of select="."/>
          </xsl:for-each>
          <xsl:if test="$name/n1:suffix">
            <xsl:for-each select="$name/n1:suffix">
              <xsl:text>, </xsl:text>
              <xsl:value-of select="."/>
            </xsl:for-each>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$printNameBold='true'">
        <b><xsl:value-of select="$nameValue" /></b>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$nameValue" />
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!-- guardian -->
  <xsl:template match="n1:guardian">
    <div class="guardianContact">
      <p class="guardianName">
        <xsl:if test="n1:guardianPerson/n1:name">
          <xsl:call-template name="getName">
            <xsl:with-param name="name" select="n1:guardianPerson/n1:name"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:if test="n1:guardianOrganization/n1:name">
          <xsl:apply-templates select="n1:guardianOrganization/n1:name"/>
        </xsl:if>      
      </p>
      <xsl:call-template name="getContactInfo">
        <xsl:with-param name="contact" select="."/>
      </xsl:call-template>
      <xsl:if test="n1:guardianOrganization/n1:asOrganizationPartOf/n1:wholeOrganization">
        <xsl:call-template name="getOrganization">
          <xsl:with-param name="organization" select="n1:guardianOrganization/n1:asOrganizationPartOf/n1:wholeOrganization"/>
        </xsl:call-template>
      </xsl:if>
    </div>
  </xsl:template>

  <!--  Format Date
    outputs a date in day.month.year form
    e.g., 19991207  ==>  7. Dezember 1999
  -->
  <xsl:template name="formatDate">
    <xsl:param name="date"/>
    <!-- shortmode = true, display only the date, not the time -->
    <xsl:param name="date_shortmode" />

    <xsl:choose>
      <xsl:when test="not($date/@nullFlavor) and not($date/@nullFlavor='UNK') and $date">
        <xsl:call-template name="formateDateInternal">
          <xsl:with-param name="date" select="$date" />
          <xsl:with-param name="date_shortmode" select="$date_shortmode" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>unbekannt</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="formateDateInternal">
    <xsl:param name="date" />
    <xsl:param name="date_shortmode" />

    <xsl:choose>
      <xsl:when test="substring ($date/@value, 7, 1)='0'">
        <xsl:value-of select="substring ($date/@value, 8, 1)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring ($date/@value, 7, 2)"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>. </xsl:text>
    <xsl:variable name="month" select="substring ($date/@value, 5, 2)"/>
    <xsl:choose>
      <xsl:when test="$month='01'">
        <xsl:text>Januar </xsl:text>
      </xsl:when>
      <xsl:when test="$month='02'">
        <xsl:text>Februar </xsl:text>
      </xsl:when>
      <xsl:when test="$month='03'">
        <xsl:text>März </xsl:text>
      </xsl:when>
      <xsl:when test="$month='04'">
        <xsl:text>April </xsl:text>
      </xsl:when>
      <xsl:when test="$month='05'">
        <xsl:text>Mai </xsl:text>
      </xsl:when>
      <xsl:when test="$month='06'">
        <xsl:text>Juni </xsl:text>
      </xsl:when>
      <xsl:when test="$month='07'">
        <xsl:text>Juli </xsl:text>
      </xsl:when>
      <xsl:when test="$month='08'">
        <xsl:text>August </xsl:text>
      </xsl:when>
      <xsl:when test="$month='09'">
        <xsl:text>September </xsl:text>
      </xsl:when>
      <xsl:when test="$month='10'">
        <xsl:text>Oktober </xsl:text>
      </xsl:when>
      <xsl:when test="$month='11'">
        <xsl:text>November </xsl:text>
      </xsl:when>
      <xsl:when test="$month='12'">
        <xsl:text>Dezember </xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:value-of select="substring ($date/@value, 1, 4)"/>
    <xsl:if test="$date_shortmode != 'true'">
      <xsl:variable name="hour" select="substring($date/@value, 9, 2)"/>
        <xsl:if test="$hour != ''">
        <xsl:text> um </xsl:text>
        <xsl:call-template name="getTime">
          <xsl:with-param name="date" select="$date" />
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template name="getTime">
    <xsl:param name="date"/>

    <xsl:variable name="hour" select="substring($date/@value, 9, 2)"/>
    <xsl:if test="$hour != ''">
      <xsl:choose>
        <!-- print "00:00" Uhr as "0:00" Uhr -->
        <xsl:when test="$hour='00'">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring ($date/@value, 9, 2)"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>:</xsl:text>
      <xsl:value-of select="substring ($date/@value, 11, 2)"/>
      <xsl:text> Uhr </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="isDateTimeValid">
    <xsl:param name="date" />

    <xsl:choose>
      <xsl:when test="$date and $date/@value and not($date/n1:time/@nullFlavor)">
        <xsl:value-of select="string(true())" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="string(false())" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  
  <!-- StructuredBody -->
  <xsl:template match="n1:component/n1:structuredBody">
    <xsl:apply-templates select="n1:component/n1:section"/>
  </xsl:template>


  <!--
    Component/Section
  -->
  <xsl:template match="n1:component/n1:section">
    <!-- zeige TITEL der Sektion -->
    <xsl:choose>
      <!-- Briefkopf: zeige keinen Titel -->
      <xsl:when test="n1:code/@code = 'BRIEFT' "/>
      <!-- Abschließende Bemerkungen -->
      <xsl:when test="n1:code/@code = 'ABBEM' " />
      <!-- do not show section risk here -->
      <xsl:when test="n1:code/@code = '51898-5' and n1:code/@codeSystem ='2.16.840.1.113883.6.1' "/>
      <!-- do not show section allergic here -->
      <xsl:when test="n1:code/@code = '48765-2' and n1:code/@codeSystem = '2.16.840.1.113883.6.1' " />
      <xsl:otherwise>
        <xsl:apply-templates select="n1:title">
          <xsl:with-param name="code" select="n1:code"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>

    <!-- text of section -->
    <xsl:choose>
      <!-- salutation (Briefkopf: eigene Formatierung / BRIEFT ABBEM) -->
      <xsl:when test="n1:code/@code = 'BRIEFT' ">
        <div class="salutation"><xsl:apply-templates select="n1:text"/></div>
      </xsl:when>
      <xsl:when test="n1:code/@code = 'ABBEM'">
        <div class="leavetaking"><xsl:apply-templates select="n1:text"/></div>
      </xsl:when>
      <!-- rendering for risk -->
      <xsl:when test="(n1:code/@code = '51898-5' or n1:code/@code = '48765-2') and n1:code/@codeSystem ='2.16.840.1.113883.6.1' ">

        <div class="risk">

          <xsl:variable name="header">
            <xsl:choose>
              <xsl:when test="count(ancestor::*/n1:section) > 1">h3</xsl:when>
              <xsl:when test="count(ancestor::*/n1:section) > 2">h4</xsl:when>
              <xsl:otherwise>h2</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

          <xsl:element name="{$header}">
            <xsl:variable name="riskId" select="concat(n1:code/@code, '-', ../../n1:code/@code)"/>
            <a id="{$riskId}" />
            <span class="tooltipTrigger">
              <span class="warningIcon" style="padding-left: 20px;"> </span>
              <span class="tooltip">
                <span>Risiko</span>
              </span>
            </span>
            <span>
              <b>
                <xsl:call-template name="getRiskTitle">
                  <xsl:with-param name="code" select="n1:code/@code" />
                </xsl:call-template>
              </b>
              <xsl:text>: </xsl:text>
            </span>
          </xsl:element>

          <div class="warningBody">
            <xsl:apply-templates select="n1:text"/>
          </div>
        </div>
      </xsl:when>
      <xsl:otherwise>
<xsl:apply-templates select="n1:text"/>
      </xsl:otherwise>
    </xsl:choose>

    <!-- section is intended -->
    <xsl:if test="n1:component/n1:section">
      <div class="section_indent">
        <xsl:apply-templates select="n1:component/n1:section"/>
      </div>
    </xsl:if>

    <xsl:if test="/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.2' and n1:code/@code = 'ABBEM' and 
        (//n1:templateId/@root='1.2.40.0.34.11.2.2.13' or //n1:templateId/@root='1.2.40.0.34.11.2.2.14' or 
    	//n1:templateId/@root='1.2.40.0.34.11.2.2.18' or //n1:templateId/@root='1.2.40.0.34.11.2.2.19' or 
    	//n1:templateId/@root='1.2.40.0.34.11.2.2.19' or //n1:templateId/@root='1.2.40.0.34.11.2.2.20' or 
    	//n1:templateId/@root='1.2.40.0.34.11.2.2.21' or //n1:templateId/@root='1.2.40.0.34.11.2.2.22' or
    	//n1:templateId/@root='1.2.40.0.34.11.1.2.4' or //n1:templateId/@root='1.2.40.0.34.11.1.2.3')">
        <hr/>
    </xsl:if>
  </xsl:template>

  <!--   Title within a section from h2 to h4 -->
  <xsl:template match="n1:title">
    <xsl:param name="code" select="''"/>    
    <xsl:param name="idprefix" select="''"/>
    <xsl:variable name="header">
      <xsl:choose>
        <xsl:when test="count(ancestor::*/n1:section) > 1">h3</xsl:when>
        <xsl:when test="count(ancestor::*/n1:section) > 2">h4</xsl:when>
        <xsl:otherwise>h2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="{$header}"> 
      <xsl:attribute name="id">id<xsl:value-of select="concat($code/@code, $idprefix)"/></xsl:attribute>

      <xsl:if test="$header='h2'">
        <xsl:attribute name="class"><xsl:text>sectionTitle</xsl:text></xsl:attribute>
      </xsl:if>

      <xsl:if test="$header='h3'">
        <xsl:attribute name="class"><xsl:text>sectionSubTitle</xsl:text></xsl:attribute>
      </xsl:if>

      <!-- display icon: Patientenverfuegung-->
      <xsl:if test="$code/@code='42348-3' and $code/@codeSystem ='2.16.840.1.113883.6.1'">
        <span class="tooltipTrigger">
          <xsl:call-template name="getPatientLivingWillIcon" />
          <span class="tooltip" style="width: 180px;">
            <span>Patientenverfügung vorhanden</span>
          </span>
        </span>
        <xsl:text> </xsl:text>
      </xsl:if>

      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="getRiskTitle">
    <xsl:param name="code"/>

    <xsl:choose>
      <xsl:when test="$code='51898-5'">
        <xsl:text>Risiko</xsl:text>
      </xsl:when>
      <xsl:when test="$code='48765-2'">
        <xsl:text>Allergien, Unverträglichkeiten und Risiken</xsl:text>
      </xsl:when>
      <xsl:when test="$code='42348-3'">
        <xsl:text>Patientenverfügung vorhanden</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>unbekannter code (</xsl:text>
        <xsl:value-of select="$code"/>
        <xsl:text>)</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!--   footnoteref -->
  <xsl:template match="n1:footnote">
    <i>
      <xsl:apply-templates/>
    </i>
  </xsl:template>

  <!--   remark -->
  <xsl:template match="n1:remark">
  <tr>
    <td/>
    <td colspan="6" bgcolor="#ffff66" style="font-size:80%">
      <i>
        <xsl:apply-templates/>
      </i>
    </td>
  </tr>
  </xsl:template>

  <!--   Text   -->
  <xsl:template match="n1:text">
    <xsl:choose>
      <xsl:when test="count(ancestor::*/n1:section) > 1 and ./../n1:code[@code != '51898-5' and @code != '48765-2']">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <div class="section_text"><xsl:apply-templates/></div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--   paragraph  -->
  <xsl:template match="n1:paragraph">
    <p class="paragraph"><xsl:apply-templates/></p>
  </xsl:template>

  <!--   line break  -->
  <xsl:template match="n1:br">
    <xsl:apply-templates/>
    <br />
  </xsl:template>

  <!--   Content w/ deleted text is crossed out -->
  <xsl:template match="n1:content[@revised='delete']">
    <xsl:if test="$showrevisionmarks = 1">
      <span style="text-decoration:line-through;">
        <xsl:apply-templates />
      </span>
    </xsl:if>
  </xsl:template>

  <!-- Content w/ insert text is underlined and italic -->
  <xsl:template match="n1:content[@revised='insert']">
    <xsl:if test="$showrevisionmarks = 1">
      <span style="text-decoration: underline; font-style: italic;">
        <xsl:apply-templates />
      </span>
    </xsl:if>
    <xsl:if test="$showrevisionmarks = 0">
      <xsl:apply-templates />
    </xsl:if>
  </xsl:template>

  <!--   content  -->
  <xsl:template match="n1:content">
    <xsl:choose>
      <xsl:when test="@styleCode">
        <xsl:call-template name="applyStyleCode">
          <xsl:with-param name="transformed_stylecode" select="translate(@styleCode, $lc, $uc)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--   list  -->
  <xsl:template match="n1:list">
    
    <!-- Stylecode case sensitive processing --> 
    <xsl:variable name="transformed_stylecode" select="translate(@styleCode, $lc, $uc)" />
    <xsl:variable name="transformed_listtype" select="translate(@listType, $lc, $uc)" />

    <!-- caption -->
    <xsl:if test="n1:caption">
      <span style="font-weight:bold; ">
        <xsl:apply-templates select="n1:caption"/>
      </span>
    </xsl:if>
    <!-- item -->
    <xsl:choose>
      <xsl:when test="$transformed_listtype='ORDERED'">
        <xsl:choose>
          <xsl:when test="$transformed_stylecode='LITTLEROMAN'">
            <ol style="list-style-type: lower-roman">
              <xsl:for-each select="n1:item">
                <li>
                  <!-- list element-->
                  <xsl:apply-templates/>
                </li>
              </xsl:for-each>
            </ol>
          </xsl:when>
          <xsl:when test="$transformed_stylecode='BIGROMAN'">
            <ol style="list-style-type: upper-roman">
              <xsl:for-each select="n1:item">
                <li>
                  <!-- list element-->
                  <xsl:apply-templates/>
                </li>
              </xsl:for-each>
            </ol>
          </xsl:when> 
          <xsl:when test="$transformed_stylecode='LITTLEALPHA'">
            <ol style="list-style-type: lower-latin">
              <xsl:for-each select="n1:item">
                <li>
                  <!-- list element-->
                  <xsl:apply-templates/>
                </li>
              </xsl:for-each>
            </ol>
          </xsl:when>
          <xsl:when test="$transformed_stylecode='BIGALPHA'">
            <ol style="list-style-type: upper-latin">
              <xsl:for-each select="n1:item">
                <li>
                  <!-- list element-->
                  <xsl:apply-templates/>
                </li>
              </xsl:for-each>
            </ol>
          </xsl:when>
          <xsl:otherwise>
            <ol style="list-style-type: decimal">
              <xsl:for-each select="n1:item">
                <li>
                  <!-- list element-->
                  <xsl:apply-templates/>
                </li>
              </xsl:for-each>
            </ol>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- list is unordered -->
        <xsl:choose>
          <xsl:when test="$transformed_stylecode='CIRCLE'">
            <ul style="list-style-type: circle">
              <xsl:for-each select="n1:item">
                <li>
                  <!-- list element-->
                  <xsl:apply-templates/>
                </li>
              </xsl:for-each>
            </ul>           
          </xsl:when>
          <xsl:when test="$transformed_stylecode='SQUARE'">
            <ul style="list-style-type: square">
              <xsl:for-each select="n1:item">
                <li>
                  <!-- list element-->
                  <xsl:apply-templates/>
                </li>
              </xsl:for-each>
            </ul>           
          </xsl:when>
          <xsl:otherwise>
            <ul style="list-style-type: disc">
              <xsl:for-each select="n1:item">
                <li>
                  <!-- list element-->
                  <xsl:apply-templates/>
                </li>
              </xsl:for-each>
            </ul>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--   caption  -->
  <xsl:template match="n1:caption">
    <div class="caption">
      <xsl:apply-templates/>
      <xsl:text>: </xsl:text>
    </div>
  </xsl:template>
  <xsl:template match="n1:paragraph/n1:caption">
    <span class="caption">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

<xsl:template match="n1:table">

<xsl:variable name="tableMaxCellCount">
  <xsl:call-template name="getMaxCellsInRowFromTable">
    <xsl:with-param name="table" select="." />
  </xsl:call-template>
</xsl:variable>

<xsl:variable name="numHeaderCells">
  <xsl:call-template name="getNumHeaderCells">
    <xsl:with-param name="table" select="." />
  </xsl:call-template>
</xsl:variable>

<xsl:variable name="tableValid">
  <xsl:call-template name="checkTableValid">
    <xsl:with-param name="table" select="." />
    <xsl:with-param name="numHeaderCells" select="$numHeaderCells" />
  </xsl:call-template>
</xsl:variable>

<xsl:variable name="doesRowCountMatch">
  <xsl:call-template name="checkRowCountValid">
    <xsl:with-param name="table" select="." />
    <xsl:with-param name="numHeaderCells" select="$numHeaderCells" />
  </xsl:call-template>
</xsl:variable>

<xsl:variable name="showInfoButtonInTable">
  <xsl:if test="$enableInfoButton='1'">
    <xsl:call-template name="checkForInfoButtonInTable">
      <xsl:with-param name="table" select="." />
    </xsl:call-template>
  </xsl:if>
</xsl:variable>

<xsl:choose>
  <xsl:when test="$tableValid = ''">

    <xsl:if test="$doesRowCountMatch != ''">
      <div class="tableFormatExceptionInformation" style="margin-top: 0.5em;">
        <b>***** ACHTUNG: Die folgende Tabelle enthält ungültige Formatierungen! *****</b><br />
        Der Inhalt kann unter Umständen fehlerhaft interpretiert werden! <br />
        In der Originaltabelle fehlen die umrandeten Zellen, sie wurden automatisch eingefügt.<br />
        Bitte kontaktieren Sie den fachlichen Ansprechpartner oder Ersteller bei Unklarheiten.
      </div>
    </xsl:if>

    <table class="section_table" cellspacing="0" cellpadding="0">

      <xsl:call-template name="renderTableHeader">
        <xsl:with-param name="node" select="n1:thead" />
        <xsl:with-param name="maxCellCount" select="$tableMaxCellCount" />
        <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
      </xsl:call-template>

      <xsl:call-template name="renderTableBody">
        <xsl:with-param name="headerNode" select="n1:thead" />
        <xsl:with-param name="node" select="n1:tbody" />
        <xsl:with-param name="maxCellCount" select="$tableMaxCellCount" />
        <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
      </xsl:call-template>

      <xsl:call-template name="renderTableFooter">
        <xsl:with-param name="headerNode" select="n1:thead" />
        <xsl:with-param name="bodyNode" select="n1:tbody" />
        <xsl:with-param name="node" select="n1:tfoot" />
        <xsl:with-param name="maxCellCount" select="$tableMaxCellCount" />
        <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
      </xsl:call-template>

      <!-- fallback if no thead or tbody element exist -->
      <xsl:for-each select="n1:tr">
        <xsl:call-template name="renderTableRow">
          <xsl:with-param name="rowPosition" select="position()" />
          <xsl:with-param name="theadExist" select="0" />
          <xsl:with-param name="maxCellCount" select="$tableMaxCellCount" />
          <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
        </xsl:call-template>
      </xsl:for-each>

    </table>

    <xsl:if test="$doesRowCountMatch != ''">
      <div class="tableFormatExceptionInformation" style="margin-bottom: 0.5em;"><b>***** ENDE *****</b></div>
    </xsl:if>
  </xsl:when>
  <xsl:otherwise>
    <table class="section_table" cellspacing="0" cellpadding="0">
      <tr>
        <td style="padding: 1em; text-align: center;"><xsl:text>Die Tabelle kann wegen einer ungültigen Formatanweisung nicht dargestellt werden.</xsl:text></td>
      </tr>
    </table>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="renderTableHeader">
<xsl:param name="node" />
<xsl:param name="maxCellCount" />
<xsl:param name="showInfoButtonInTable" />

<xsl:if test="n1:thead">
  <thead>
    <xsl:for-each select="$node/n1:tr">
      <xsl:call-template name="renderTableRow">
        <xsl:with-param name="rowPosition" select="position()" />
        <xsl:with-param name="cellWidthCalculated" select="1" />
        <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
        <xsl:with-param name="maxCellCount" select="$maxCellCount" />
        <xsl:with-param name="cssFirstCell"><xsl:text>border-left: 0px none;</xsl:text></xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>
  </thead>
</xsl:if>
</xsl:template>

<xsl:template name="renderTableBody">
<xsl:param name="node" />
<xsl:param name="headerNode" />
<xsl:param name="maxCellCount" />
<xsl:param name="showInfoButtonInTable" />

<xsl:variable name="cellWidthCalculated">
  <xsl:choose>
    <xsl:when test="$headerNode"><xsl:text>1</xsl:text></xsl:when>
    <xsl:otherwise><xsl:text>0</xsl:text></xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:if test="n1:tbody">
  <tbody>
    <xsl:for-each select="$node/n1:tr">
      <xsl:call-template name="renderTableRow">
        <xsl:with-param name="rowPosition" select="position()" />
        <xsl:with-param name="cellWidthCalculated" select="$cellWidthCalculated" />
        <xsl:with-param name="maxCellCount" select="$maxCellCount" />
        <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
      </xsl:call-template>
    </xsl:for-each>
  </tbody>
</xsl:if>
</xsl:template>

<xsl:template name="renderTableFooter">
<xsl:param name="node" />
<xsl:param name="headerNode" />
<xsl:param name="bodyNode" />
<xsl:param name="maxCellCount" />
<xsl:param name="showInfoButtonInTable" />

<xsl:if test="n1:tfoot">

  <xsl:variable name="theadExist">
    <xsl:choose>
      <xsl:when test="$headerNode"><xsl:text>1</xsl:text></xsl:when>
      <xsl:otherwise><xsl:text>0</xsl:text></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="cellWidthCalculated">
    <xsl:choose>
      <xsl:when test="$bodyNode and $theadExist=1"><xsl:text>1</xsl:text></xsl:when>
      <xsl:otherwise><xsl:text>0</xsl:text></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <tfoot>
    <xsl:for-each select="$node/n1:tr">

      <xsl:variable name="cellCountInCurrentRow">
        <xsl:call-template name="calculateCellCount">
          <xsl:with-param name="cells" select="./n1:td" />
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="colspanWithWithInfoButton">
        <xsl:choose>
          <xsl:when test="$showInfoButtonInTable != ''">
            <xsl:value-of select="$maxCellCount - $cellCountInCurrentRow + 2" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$maxCellCount - $cellCountInCurrentRow + 1" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:call-template name="renderTableRow">
        <xsl:with-param name="rowPosition" select="1" /> <!-- force white rowbg -->
        <xsl:with-param name="cellWidthCalculated" select="$cellWidthCalculated" />
        <xsl:with-param name="firstColspan" select="$colspanWithWithInfoButton" />
        <xsl:with-param name="maxCellCount" select="$maxCellCount" />
        <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
        <xsl:with-param name="isTFootElement" select="1" />
      </xsl:call-template>
    </xsl:for-each>
  </tfoot>
</xsl:if>
</xsl:template>

<xsl:template name="renderTableRow">
  <xsl:param name="rowPosition" />
  <xsl:param name="cellWidthCalculated" select="0" />
  <xsl:param name="colspan" select="1" />
  <xsl:param name="firstColspan" select="0" />
  <xsl:param name="maxCellCount" />
  <xsl:param name="showInfoButtonInTable" />
  <xsl:param name="isTFootElement" select="0" />
  <xsl:param name="cssFirstCell" select="''" />

  <xsl:variable name="xELGA_blue">
    <xsl:if test="contains(translate(@styleCode, $lc, $uc), 'XELGA_BLUE')">
      <xsl:text>xblue</xsl:text>
    </xsl:if>
  </xsl:variable>
  <xsl:variable name="xELGA_red">
    <xsl:if test="contains(translate(@styleCode, $lc, $uc), 'XELGA_RED')">
      <xsl:text>xred</xsl:text>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="rowBG">
    <xsl:choose>
      <xsl:when test="$rowPosition mod 2 = 1"><xsl:text>odd</xsl:text></xsl:when>
      <xsl:otherwise><xsl:text>even</xsl:text></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="observationCode">
    <xsl:if test="$showInfoButtonInTable != ''">
      <xsl:choose>
        <xsl:when test="./n1:th or not(@ID)">
          <xsl:text />
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="obsID" select="concat('#', @ID)" />
          <xsl:variable name="observationIDEntry" select="//n1:text/n1:reference[@value=$obsID]" />
          <xsl:if test="$observationIDEntry/parent::*/parent::*/n1:code/@codeSystem='2.16.840.1.113883.6.1'">
            <xsl:value-of select="$observationIDEntry/../../n1:code/@code" />
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:variable>

  <tr class="{$rowBG} {$xELGA_blue} {$xELGA_red}">

    <xsl:if test="./n1:th">

      <xsl:variable name="cellCountInCurrentRow">
        <xsl:call-template name="calculateCellCount">
          <xsl:with-param name="cells" select="./n1:th" />
        </xsl:call-template>
      </xsl:variable>

      <xsl:for-each select="./n1:th">
        <xsl:call-template name="renderTableHeaderCell">
          <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
          <xsl:with-param name="maxCellCount" select="$maxCellCount" />
          <xsl:with-param name="cellCountInCurrentRow" select="$cellCountInCurrentRow" />
          <xsl:with-param name="cssFirstCell" select="$cssFirstCell" />
        </xsl:call-template>
      </xsl:for-each>

      <xsl:variable name="emptyBlockWidth">
        <xsl:call-template name="getCellWidth">
          <xsl:with-param name="parentRow" select="./n1:th" />
          <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
          <xsl:with-param name="maxCellCount" select="$maxCellCount" />
          <xsl:with-param name="cellCountInCurrentRow" select="$cellCountInCurrentRow" />
        </xsl:call-template>
      </xsl:variable>

      <xsl:call-template name="addEmptyBlocks">
        <xsl:with-param name="numberOfBlocks" select="$maxCellCount - $cellCountInCurrentRow" />
        <xsl:with-param name="element">th</xsl:with-param>
        <xsl:with-param name="width" select="$emptyBlockWidth" />
      </xsl:call-template>

      <xsl:call-template name="renderInfoButtonInTableHeader">
        <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
      </xsl:call-template>

    </xsl:if>

    <xsl:if test="./n1:td">

      <xsl:variable name="cellCountInCurrentRow">
        <xsl:call-template name="calculateCellCount">
          <xsl:with-param name="cells" select="./n1:td" />
        </xsl:call-template>
      </xsl:variable>

      <xsl:for-each select="./n1:td">

        <xsl:variable name="colSpanForPosition">
          <xsl:choose>
            <xsl:when test="$isTFootElement = 1 and position() = 1">
              <xsl:value-of select="$firstColspan" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$colspan" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:call-template name="renderTableBodyCell">
          <xsl:with-param name="rowPosition" select="$rowPosition" />
          <xsl:with-param name="cellWidthCalculated" select="$cellWidthCalculated" />
          <xsl:with-param name="colspan" select="$colSpanForPosition" />
          <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
          <xsl:with-param name="maxCellCount" select="$maxCellCount" />
          <xsl:with-param name="cellCountInCurrentRow" select="$cellCountInCurrentRow" />
        </xsl:call-template>
      </xsl:for-each>

      <xsl:if test="$isTFootElement = 0">
        <xsl:variable name="emptyBlockWidth">
          <xsl:if test="$rowPosition=1 and $cellWidthCalculated=0">
            <xsl:call-template name="getCellWidth">
              <xsl:with-param name="parentRow" select="./n1:td" />
              <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
              <xsl:with-param name="maxCellCount" select="$maxCellCount" />
              <xsl:with-param name="cellCountInCurrentRow" select="$cellCountInCurrentRow" />
            </xsl:call-template>
          </xsl:if>
        </xsl:variable>

        <xsl:call-template name="addEmptyBlocks">
          <xsl:with-param name="numberOfBlocks" select="$maxCellCount - $cellCountInCurrentRow" />
          <xsl:with-param name="element">td</xsl:with-param>
          <xsl:with-param name="width" select="$emptyBlockWidth"/>
        </xsl:call-template>

        <xsl:call-template name="renderInfoButtonInTableRow">
          <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
          <xsl:with-param name="row" select="." />
          <xsl:with-param name="isTFootElement" select="$isTFootElement" />
          <xsl:with-param name="observationCode" select="$observationCode" />
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </tr>

</xsl:template>

<xsl:template name="renderTableHeaderCell">
<xsl:param name="showInfoButtonInTable" />
<xsl:param name="maxCellCount" />
<xsl:param name="cellCountInCurrentRow" />
<xsl:param name="cssFirstCell" />

<xsl:variable name="width">
  <xsl:call-template name="getCellWidth">
    <xsl:with-param name="parentRow" select="../n1:th" />
    <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
    <xsl:with-param name="maxCellCount" select="$maxCellCount" />
    <xsl:with-param name="cellCountInCurrentRow" select="$cellCountInCurrentRow" />
  </xsl:call-template>
</xsl:variable>

<xsl:variable name="colspan">
  <xsl:choose>
    <xsl:when test="@colspan">
      <xsl:value-of select="@colspan" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>1</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="rowspan">
  <xsl:choose>
    <xsl:when test="@rowspan">
      <xsl:value-of select="@rowspan" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>1</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- create th element -->
<xsl:element name="th">
  <xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
  <xsl:attribute name="colspan"><xsl:value-of select="$colspan"/></xsl:attribute>
  <xsl:attribute name="rowspan"><xsl:value-of select="$rowspan"/></xsl:attribute>
  <xsl:if test="position() = 1">
    <xsl:attribute name="style"><xsl:value-of select="$cssFirstCell" /> </xsl:attribute>
  </xsl:if>
  <xsl:apply-templates/>
</xsl:element>

</xsl:template>


<xsl:template name="renderTableBodyCell">
<xsl:param name="rowPosition" />
<xsl:param name="cellWidthCalculated" />
<xsl:param name="colspan" select="0" />
<xsl:param name="showInfoButtonInTable" />
<xsl:param name="maxCellCount" />
<xsl:param name="cellCountInCurrentRow" />

<xsl:variable name="transformed_stylecode" select="translate(@styleCode, $lc, $uc)" />

<xsl:variable name="tdStyleCode_Style">
  <xsl:if test="contains($transformed_stylecode, 'LRULE')">
    <xsl:text>text-align: left;</xsl:text>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode, 'RRULE')">
    <xsl:text>text-align: right;</xsl:text>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode, 'TOPRULE')">
    <xsl:text>vertical-align: top;</xsl:text>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode, 'BOTRULE')">
    <xsl:text>vertical-align: bottom;</xsl:text>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode, 'BOLD')">
    <xsl:text>font-weight: bold;</xsl:text>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode, 'UNDERLINE')">
    <xsl:text>text-decoration: underline</xsl:text>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode, 'ITALICS')">
    <xsl:text>font-style: italic;</xsl:text>
  </xsl:if>
</xsl:variable>

<xsl:variable name="tdStyleCodeClass">
  <xsl:text>table_cell</xsl:text>
  <xsl:if test="contains($transformed_stylecode, 'EMPHASIS')">
    <xsl:text> smallcaps </xsl:text>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode, 'XELGA_BLUE')">
    <xsl:text> xblue </xsl:text>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode, 'XELGA_RED')">
    <xsl:text> xred </xsl:text>
  </xsl:if>
</xsl:variable>

<xsl:variable name="cellColspan">
  <xsl:choose>
    <xsl:when test="@colspan">
      <xsl:value-of select="@colspan" />
    </xsl:when>
    <xsl:when test="not(@colspan) and $colspan">
      <xsl:value-of select="$colspan" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>1</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="rowspan">
  <xsl:choose>
    <xsl:when test="@rowspan">
      <xsl:value-of select="@rowspan" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>1</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="width">
  <xsl:if test="$rowPosition=1 and $cellWidthCalculated=0">
    <xsl:call-template name="getCellWidth">
      <xsl:with-param name="parentRow" select="../n1:td" />
      <xsl:with-param name="showInfoButtonInTable" select="$showInfoButtonInTable" />
      <xsl:with-param name="maxCellCount" select="$maxCellCount" />
      <xsl:with-param name="cellCountInCurrentRow" select="$cellCountInCurrentRow" />
    </xsl:call-template>
  </xsl:if>
</xsl:variable>

<xsl:element name="td">
  <xsl:if test="$width != ''">
    <xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
  </xsl:if>
  <xsl:attribute name="colspan"><xsl:value-of select="$cellColspan"/></xsl:attribute>
  <xsl:attribute name="rowspan"><xsl:value-of select="$rowspan"/></xsl:attribute>
  <xsl:attribute name="class"><xsl:value-of select="$tdStyleCodeClass" /></xsl:attribute>
  <xsl:if test="$tdStyleCode_Style != ''">
    <xsl:attribute name="style"><xsl:value-of select="$tdStyleCode_Style" /></xsl:attribute>
  </xsl:if>

  <xsl:apply-templates/>

</xsl:element>

</xsl:template>

<xsl:template name="renderInfoButtonInTableHeader">
<xsl:param name="showInfoButtonInTable" />

<xsl:if test="$showInfoButtonInTable != ''">
  <!-- 3.84 = 100 / 104 * 4 -->
  <th colspan="1" rowspan="1" width="3.84%" /> <!-- empty header for info button -->
</xsl:if>

</xsl:template>

<xsl:template name="addEmptyBlocks">

<xsl:param name="numberOfBlocks" />
<xsl:param name="blocksAdded" select="0" />
<xsl:param name="element" />
<xsl:param name="width" select="0" />

<xsl:if test="$blocksAdded &lt; $numberOfBlocks">

  <xsl:choose>
    <xsl:when test="$element='th'">
      <xsl:choose>
        <xsl:when test="$width != ''">
          <th colspan="1" rowspan="1" width="{$width}" class="emptyblock"></th>
        </xsl:when>
        <xsl:otherwise>
          <th colspan="1" rowspan="1" class="emptyblock"></th>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$width != ''">
          <td colspan="1" rowspan="1" width="{$width}" class="emptyblock"></td>
        </xsl:when>
        <xsl:otherwise>
          <td colspan="1" rowspan="1" class="emptyblock"></td>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>

  <xsl:call-template name="addEmptyBlocks">
    <xsl:with-param name="numberOfBlocks" select="$numberOfBlocks"/>
    <xsl:with-param name="blocksAdded" select="$blocksAdded + 1"/>
    <xsl:with-param name="element" select="$element" />
    <xsl:with-param name="width" select="$width" />
  </xsl:call-template>
</xsl:if>

</xsl:template>

<xsl:template name="renderInfoButtonInTableRow">
<xsl:param name="showInfoButtonInTable" />
<xsl:param name="row" />
<xsl:param name="isTFootElement" />
<xsl:param name="observationCode" />

<xsl:if test="$showInfoButtonInTable != '' and $isTFootElement=0">
  <td class="table_cell" colspan="1" rowspan="1" style="text-align: center">
    <xsl:choose>
      <xsl:when test="$observationCode != ''">

        <xsl:variable name="loincURL">
          <xsl:value-of select="concat($LOINCResolutionUrl, $observationCode)" />
        </xsl:variable>

          <xsl:element name="img">
            <xsl:attribute name="class">infoButton</xsl:attribute>
            <xsl:attribute name="data-targetUrl"><xsl:value-of select="$loincURL"/></xsl:attribute>
            <xsl:attribute name="src"><xsl:value-of select="translate(normalize-space($infoButtonIcon),'&#32;','')" /></xsl:attribute>
          </xsl:element>

      </xsl:when>
      <xsl:otherwise>
        <!-- loinc code not found -->
      </xsl:otherwise>
    </xsl:choose>
  </td>
</xsl:if>
</xsl:template>

<xsl:template name="checkForInfoButtonInTable">
  <xsl:param name="table" />

  <!-- show info button only if cda is instance of a "Laborbefund" document with eis full support -->
  <xsl:if test="/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.4.0.3'">
    <xsl:if test="$table/n1:tbody/n1:tr">
      <xsl:for-each select="$table/n1:tbody/n1:tr">
        <xsl:call-template name="checkForInfoButtonInRow">
          <xsl:with-param name="row" select="." />
        </xsl:call-template>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="$table/n1:tr">
      <xsl:for-each select="$table/n1:tr">
        <xsl:call-template name="checkForInfoButtonInRow">
          <xsl:with-param name="row" select="." />
        </xsl:call-template>
      </xsl:for-each>
    </xsl:if>
  </xsl:if>
</xsl:template>

<xsl:template name="checkForInfoButtonInRow">
  <xsl:param name="row" />

  <xsl:if test="$row/@ID">

    <xsl:variable name="obsID" select="concat('#', $row/@ID)" />
    <xsl:variable name="observationIDEntry" select="//n1:text/n1:reference[@value=$obsID]" />
    <xsl:variable name="observationCode">
      <xsl:if test="$observationIDEntry/parent::*/parent::*/n1:code/@codeSystem='2.16.840.1.113883.6.1'">
        <xsl:value-of select="$observationIDEntry/../../n1:code/@code" />
      </xsl:if>
    </xsl:variable>

    <xsl:if test="$observationCode!=''">
      <xsl:text>1</xsl:text>
    </xsl:if>

  </xsl:if>
</xsl:template>

<xsl:template name="checkTableValid">
<xsl:param name="table" />
<xsl:param name="numHeaderCells" />

<xsl:if test="$isStrictModeDisabled = '0' or not($isStrictModeDisabled = '0' or $showTableInBestGuess = '1')">
  <xsl:call-template name="checkRowCountValid">
    <xsl:with-param name="table" select="$table" />
    <xsl:with-param name="numHeaderCells" select="$numHeaderCells" />
  </xsl:call-template>
</xsl:if>

<xsl:if test="$table/n1:tfoot/n1:tr/n1:th">
  <!-- th is not valid in tfoot -->
  <xsl:value-of select="-1" />
</xsl:if>

</xsl:template>

<xsl:template name="checkRowCountValid">
<xsl:param name="table" />
<xsl:param name="numHeaderCells" />

<xsl:choose>
  <xsl:when test="$table/n1:tbody/n1:tr">
    <xsl:for-each select="$table/n1:tbody/n1:tr">
      <xsl:variable name="currentRowCells">
        <xsl:call-template name="calculateCellCount">
          <xsl:with-param name="cells" select="./n1:td" />
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="$numHeaderCells != $currentRowCells">
        <xsl:value-of select="-1" />
      </xsl:if>
    </xsl:for-each>
  </xsl:when>
  <xsl:otherwise>
    <xsl:for-each select="$table/n1:tr">
      <xsl:variable name="currentRowCells">
        <xsl:call-template name="calculateCellCount">
          <xsl:with-param name="cells" select="./n1:td" />
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="$numHeaderCells != $currentRowCells">
        <xsl:value-of select="-1" />
      </xsl:if>
    </xsl:for-each>
  </xsl:otherwise>
</xsl:choose>

<!-- only one td element in each tfoot tr row is allowed -->
<xsl:for-each select="$table/n1:tfoot/n1:tr">
  <xsl:if test="count(./n1:td) != 1">
    <xsl:value-of select="-1" />
  </xsl:if>
</xsl:for-each>

</xsl:template>

<xsl:template name="getNumHeaderCells">
<xsl:param name="table" />

<xsl:choose>
  <xsl:when test="$table/n1:thead/n1:tr[position() = 1]/n1:th">
    <xsl:call-template name="calculateCellCount">
      <xsl:with-param name="cells" select="$table/n1:thead/n1:tr[position() = 1]/n1:th" />
    </xsl:call-template>
  </xsl:when>
  <xsl:when test="$table/n1:tbody/n1:tr[position() = 1]/n1:td">
    <xsl:call-template name="calculateCellCount">
      <xsl:with-param name="cells" select="$table/n1:tbody/n1:tr[position() = 1]/n1:td" />
    </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
    <xsl:call-template name="calculateCellCount">
      <xsl:with-param name="cells" select="$table/n1:tr[position() = 1]/n1:td" />
    </xsl:call-template>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

        <!-- recursive calculate cell count -->
<xsl:template name="calculateCellCount">
<xsl:param name="cells" />
<xsl:param name="totalCellCount" select="0" />

<xsl:variable name="currentCell" select="$cells[1]" />
<xsl:variable name="nextCell" select="$cells[position()>1]" />

<xsl:variable name="currentCellCount">
  <xsl:choose>
    <xsl:when test="$currentCell/@colspan">
      <xsl:value-of select="$currentCell/@colspan" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="1" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:choose>
  <xsl:when test="not($nextCell)">
    <xsl:value-of select="$currentCellCount + $totalCellCount" />
  </xsl:when>
  <xsl:otherwise>
    <xsl:call-template name="calculateCellCount">
      <xsl:with-param name="cells" select="$nextCell" />
      <xsl:with-param name="totalCellCount" select="$currentCellCount + $totalCellCount" />
    </xsl:call-template>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="calculateCellCountWithoutStyleCode">
<xsl:param name="cells" />
<xsl:param name="totalCellCount" select="0" />
<xsl:param name="emptyCells" />

<xsl:variable name="currentCell" select="$cells[1]" />
<xsl:variable name="nextCell" select="$cells[position()>1]" />

<xsl:variable name="currentCellCount">
  <xsl:choose>
    <xsl:when test="$currentCell[@styleCode]">
      <xsl:value-of select="0" />
    </xsl:when>
    <xsl:when test="$currentCell[not(@styleCode) and @colspan]">
      <xsl:value-of select="$currentCell/@colspan" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="1" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:choose>
  <xsl:when test="not($nextCell)">
    <xsl:value-of select="$currentCellCount + $totalCellCount + $emptyCells" />
  </xsl:when>
  <xsl:otherwise>
    <xsl:call-template name="calculateCellCountWithoutStyleCode">
      <xsl:with-param name="cells" select="$nextCell" />
      <xsl:with-param name="totalCellCount" select="$currentCellCount + $totalCellCount" />
      <xsl:with-param name="emptyCells" select="$emptyCells" />
    </xsl:call-template>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="getMaxCellsInRowFromTable">
  <xsl:param name="table" />
  <xsl:for-each select="$table//n1:tr">
    <xsl:sort select="count(./n1:td[not(@colspan)]) + sum(./n1:td/@colspan) + count(./n1:th[not(@colspan)]) + sum(./n1:th/@colspan)" order="descending" />
    <xsl:if test="position() = 1">
      <xsl:value-of select="count(./n1:td[not(@colspan)]) + sum(./n1:td/@colspan) + count(./n1:th[not(@colspan)]) + sum(./n1:th/@colspan)"/>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template match="n1:colgroup">
<colgroup>
  <xsl:apply-templates/>
</colgroup>
</xsl:template>

<xsl:template match="n1:col">
<col>
  <xsl:apply-templates/>
</col>
</xsl:template>

<xsl:template name="getCellWidth">
<xsl:param name="parentRow" />
<xsl:param name="showInfoButtonInTable" />
<xsl:param name="maxCellCount" />
<xsl:param name="cellCountInCurrentRow" />

<!-- sum up all given widths -->
<xsl:variable name="sum">
  <xsl:call-template name="sumgivenwidths">
    <xsl:with-param name="widths" select="$parentRow" />
  </xsl:call-template>
</xsl:variable>

<!-- calculate table width -->
<xsl:variable name="tablewidth">
  <xsl:call-template name="calctablewidth">
    <xsl:with-param name="widths" select="$parentRow" />
    <xsl:with-param name="parent" select="$parentRow" />
    <xsl:with-param name="sumgivenwidths" select="$sum" />
  </xsl:call-template>
</xsl:variable>

<!-- get cell count in row without stylecode-->
<xsl:variable name="cellCountWithoutStyleCode">
  <xsl:call-template name="calculateCellCountWithoutStyleCode">
    <xsl:with-param name="cells" select="$parentRow" />
    <xsl:with-param name="emptyCells" select="$maxCellCount - $cellCountInCurrentRow" />
  </xsl:call-template>
</xsl:variable>

<!-- override given width when sum of table width > 100 % -->
<xsl:variable name="overrideGivenWidth">
  <xsl:choose>
    <xsl:when test="$sum &gt; 100">
      <xsl:value-of select="1" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="0" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- get cell count in row -->
<xsl:variable name="cellCount">
  <xsl:value-of select="$maxCellCount" />
</xsl:variable>

<!-- width calculating -->
<xsl:variable name="cWidth">
  <xsl:choose>
    <xsl:when test="@styleCode != '' and $overrideGivenWidth=0">
      <xsl:choose>
        <xsl:when test="substring-after(@styleCode, ':') &lt; 0">
          <xsl:value-of select="substring-after(@styleCode, ':-')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-after(@styleCode, ':')" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="$overrideGivenWidth=1">
      <xsl:choose>
        <xsl:when test="@colspan">
          <xsl:value-of select="100 div $cellCount * @colspan" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="100 div $cellCount" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="@colspan">
          <xsl:value-of select="(100 - $sum) div $cellCountWithoutStyleCode * @colspan" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="(100 - $sum) div $cellCountWithoutStyleCode" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="cWidthWithoutPercentSign">
  <xsl:choose>
    <xsl:when test="contains($cWidth, '%')">
      <xsl:value-of select="substring-before($cWidth, '%')" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$cWidth" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- 100 percent scaling -->
<xsl:variable name="normalizedWidth">
  <xsl:choose>
    <xsl:when test="$overrideGivenWidth=0">
      <xsl:value-of select="$cWidthWithoutPercentSign * 100 div $tablewidth" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$cWidthWithoutPercentSign" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="normalizedWidthWithInfoButton">
  <xsl:choose>
    <xsl:when test="$showInfoButtonInTable != ''">
      <xsl:value-of select="100 div 104 * $normalizedWidth" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$normalizedWidth" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:value-of select="concat($normalizedWidthWithInfoButton, '%')" />

</xsl:template>

        <!-- recursive loop through all given widths -->
<xsl:template name="sumgivenwidths">
<xsl:param name="widths" />
<xsl:param name="sum" select="0" />

<xsl:variable name="current" select="$widths[1]" />
<xsl:variable name="next" select="$widths[position()>1]" />
<xsl:variable name="currentwidth">
  <xsl:choose>
    <xsl:when test="substring-after($current/@styleCode,'xELGA_colw:') != ''">
      <!-- absolute value -->
      <xsl:choose>
        <xsl:when test="substring-after($current/@styleCode, 'xELGA_colw:') &lt; 0">
          <xsl:value-of select="substring-after($current/@styleCode, 'xELGA_colw:') * -1" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-after($current/@styleCode, 'xELGA_colw:')" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="0" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:choose>
  <xsl:when test="not($next)">
    <xsl:value-of select="$currentwidth + $sum" />
  </xsl:when>
  <xsl:otherwise>
    <xsl:call-template name="sumgivenwidths">
      <xsl:with-param name="widths" select="$next" />
      <xsl:with-param name="sum" select="$currentwidth + $sum" />
    </xsl:call-template>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

        <!-- recursive calculation of table width -->
<xsl:template name="calctablewidth">
<xsl:param name="widths" />
<xsl:param name="parent" />
<xsl:param name="sumgivenwidths" />
<xsl:param name="sum" select="0" />

<xsl:variable name="current" select="$widths[1]" />
<xsl:variable name="next" select="$widths[position()>1]" />

<xsl:variable name="currentwidth">
  <xsl:choose>
    <xsl:when test="substring-after($current/@styleCode, 'xELGA_colw:') != ''">
      <!-- absolute value -->
      <xsl:choose>
        <xsl:when test="substring-after($current/@styleCode, 'xELGA_colw:') &lt; 0">
          <xsl:value-of select="substring-after($current/@styleCode, 'xELGA_colw:') * -1" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-after($current/@styleCode, 'xELGA_colw:')" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="(100 - $sumgivenwidths) div count($parent[not(@styleCode != '')])" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="currentwidthWithoutPercentSign">
  <xsl:choose>
    <xsl:when test="contains($currentwidth, '%')">
      <xsl:value-of select="substring-before($currentwidth, '%')" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$currentwidth" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:choose>
  <xsl:when test="not($next)">
    <xsl:value-of select="$currentwidthWithoutPercentSign + $sum" />
  </xsl:when>
  <xsl:otherwise>
    <xsl:call-template name="calctablewidth">
      <xsl:with-param name="widths" select="$next" />
      <xsl:with-param name="parent" select="$parent" />
      <xsl:with-param name="sumgivenwidths" select="$sumgivenwidths" />
      <xsl:with-param name="sum" select="$currentwidthWithoutPercentSign + $sum" />
    </xsl:call-template>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>


        <!--    Stylecode processing
          Supports Bold, Underline, Italics and xELGA_* display
          It also additionally supports Heading1 to Heading3
          -->
<xsl:template match="//n1:*[@styleCode and not(@listType) and local-name() != 'th' and local-name() != 'td' and local-name() != 'table' and local-name() != 'tr' and local-name() != 'content']">

<!-- Stylecode case sensitive processing -->

<xsl:variable name="transformed_stylecode" select="translate(@styleCode, $lc, $uc)" />

<xsl:if test="contains($transformed_stylecode,'COMMENT')">
  <xsl:if test="contains($transformed_stylecode,'REPORTCOMMENT')">
    <table width="100%" cellspacing="0" cellpadding="0">
      <tbody>
        <tr>
          <td>Befundkommentar: </td>
          <td>
            <xsl:apply-templates/>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:if>
</xsl:if>
<xsl:if test="contains($transformed_stylecode,'HEADING')">
  <xsl:if test="contains($transformed_stylecode,'HEADING1')">
    <xsl:element name="h1">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode,'HEADING2')">
    <xsl:element name="h2">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode,'HEADING3')">
    <xsl:element name="h3">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:if>
</xsl:if>
<xsl:if test="contains($transformed_stylecode,'XELGA_H')">
  <xsl:if test="contains($transformed_stylecode,'XELGA_H1')">
    <xsl:element name="h1">
      <b>
        <xsl:apply-templates/>
      </b>
    </xsl:element>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode,'XELGA_H2')">
    <xsl:element name="h2">
      <b>
        <xsl:apply-templates/>
      </b>
    </xsl:element>
  </xsl:if>
  <xsl:if test="contains($transformed_stylecode,'XELGA_H3')">
    <xsl:element name="h3">
      <b>
        <xsl:apply-templates/>
      </b>
    </xsl:element>
  </xsl:if>
</xsl:if>

<xsl:call-template name="applyStyleCode">
  <xsl:with-param name="transformed_stylecode" select="$transformed_stylecode" />
</xsl:call-template>

</xsl:template>

<xsl:template name="applyStyleCode">
  <xsl:param name="transformed_stylecode" />

  <!-- start ELGA styleCode processing  -->
  <xsl:choose>
    <xsl:when test="contains($transformed_stylecode,'XELGA_MONOSPACED')">
      <!-- monospaced can't be combined with other style attributes -->
      <xsl:element name="span">
        <xsl:attribute name="class">xMonoSpaced</xsl:attribute>
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:when>
    <xsl:otherwise>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:apply-templates/>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="span">
          <xsl:attribute name="class">xblue</xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="span">
          <xsl:attribute name="class">xred</xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="span">
          <xsl:attribute name="class">xblue</xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="span">
          <xsl:attribute name="class">smallcaps</xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="span">
          <xsl:attribute name="class">smallcaps</xsl:attribute>
          <xsl:element name="span">
            <xsl:attribute name="class">xblue</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="span">
          <xsl:attribute name="class">smallcaps</xsl:attribute>
          <xsl:element name="span">
            <xsl:attribute name="class">xred</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="span">
          <xsl:attribute name="class">smallcaps</xsl:attribute>
          <xsl:element name="span">
            <xsl:attribute name="class">xblue</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="u">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="u">
          <xsl:element name="span">
            <xsl:attribute name="class">xblue</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="u">
          <xsl:element name="span">
            <xsl:attribute name="class">xred</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="u">
          <xsl:element name="span">
            <xsl:attribute name="class">xblue</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="u">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="u">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="u">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:element name="span">
              <xsl:attribute name="class">xred</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="u">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="i">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="i">
          <xsl:element name="span">
            <xsl:attribute name="class">xblue</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="i">
          <xsl:element name="span">
            <xsl:attribute name="class">xred</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="i">
          <xsl:element name="span">
            <xsl:attribute name="class">xblue</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="i">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="i">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="i">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:element name="span">
              <xsl:attribute name="class">xred</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="i">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="i">
          <xsl:element name="u">
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="i">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="i">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">xred</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="i">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="i">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="i">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:element name="span">
                <xsl:attribute name="class">xblue</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="i">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:element name="span">
                <xsl:attribute name="class">xred</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and not(contains($transformed_stylecode, 'BOLD')) and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="i">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:element name="span">
                <xsl:attribute name="class">xblue</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="span">
            <xsl:attribute name="class">xblue</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="span">
            <xsl:attribute name="class">xred</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="span">
            <xsl:attribute name="class">xblue</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:element name="span">
              <xsl:attribute name="class">xred</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="span">
            <xsl:attribute name="class">smallcaps</xsl:attribute>
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="u">
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">xred</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:element name="span">
                <xsl:attribute name="class">xblue</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:element name="span">
                <xsl:attribute name="class">xred</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and not(contains($transformed_stylecode, 'ITALICS')) and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="u">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:element name="span">
                <xsl:attribute name="class">xblue</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="span">
              <xsl:attribute name="class">xred</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="span">
              <xsl:attribute name="class">xblue</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:element name="span">
                <xsl:attribute name="class">xblue</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:element name="span">
                <xsl:attribute name="class">xred</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and not(contains($transformed_stylecode, 'UNDERLINE')) and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="span">
              <xsl:attribute name="class">smallcaps</xsl:attribute>
              <xsl:element name="span">
                <xsl:attribute name="class">xblue</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="u">
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="u">
              <xsl:element name="span">
                <xsl:attribute name="class">xblue</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="u">
              <xsl:element name="span">
                <xsl:attribute name="class">xred</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and not(contains($transformed_stylecode, 'EMPHASIS')) and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="u">
              <xsl:element name="span">
                <xsl:attribute name="class">xblue</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="u">
              <xsl:element name="span">
                <xsl:attribute name="class">smallcaps</xsl:attribute>
                <xsl:apply-templates/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and not(contains($transformed_stylecode, 'XELGA_RED')) and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="u">
              <xsl:element name="span">
                <xsl:attribute name="class">smallcaps</xsl:attribute>
                <xsl:element name="span">
                  <xsl:attribute name="class">xblue</xsl:attribute>
                  <xsl:apply-templates/>
                </xsl:element>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and not(contains($transformed_stylecode, 'XELGA_BLUE'))">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="u">
              <xsl:element name="span">
                <xsl:attribute name="class">smallcaps</xsl:attribute>
                <xsl:element name="span">
                  <xsl:attribute name="class">xred</xsl:attribute>
                  <xsl:apply-templates/>
                </xsl:element>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(contains($transformed_stylecode, 'HEADING')) and not(contains($transformed_stylecode, 'XELGA_H')) and contains($transformed_stylecode, 'BOLD') and contains($transformed_stylecode, 'ITALICS') and contains($transformed_stylecode, 'UNDERLINE') and contains($transformed_stylecode, 'EMPHASIS') and contains($transformed_stylecode, 'XELGA_RED') and contains($transformed_stylecode, 'XELGA_BLUE')">
        <xsl:element name="strong">
          <xsl:element name="i">
            <xsl:element name="u">
              <xsl:element name="span">
                <xsl:attribute name="class">smallcaps</xsl:attribute>
                <xsl:element name="span">
                  <xsl:attribute name="class">xblue</xsl:attribute>
                  <xsl:apply-templates/>
                </xsl:element>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
  <!-- end ELGA styleCode processing -->
</xsl:template>

<!--   RenderMultiMedia -->
<xsl:template match="n1:renderMultiMedia">

<xsl:variable name="imageRef" select="@referencedObject"/>

<xsl:variable name="altText">
  <xsl:choose>
    <xsl:when test="./n1:caption">
      <xsl:value-of select="./n1:caption" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>Keine alternative Bildbeschreibung vorhanden.</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="titleText">
  <xsl:choose>
    <xsl:when test="./n1:caption">
      <xsl:value-of select="./n1:caption" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>Kein Titel vorhanden.</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:choose>
  <xsl:when test="//n1:regionOfInterest[@ID=$imageRef]">
    <!-- Here is where the Region of Interest image referencing goes -->
    <xsl:if test="//n1:regionOfInterest[@ID=$imageRef]//n1:observationMedia/n1:value[@mediaType='image/gif' or @mediaType='image/jpeg' or @mediaType='image/png']">
      <br class="clearer" ></br>
      <xsl:variable name="image-uri" select="//n1:regionOfInterest[@ID=$imageRef]//n1:observationMedia/n1:value/n1:reference/@value" />
      <xsl:choose>
        <xsl:when test="contains($image-uri, ':') or starts-with($image-uri, '\\')">
          <p>Externe Bildpfade sind nicht erlaubt.</p>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="img">
            <xsl:attribute name="alt"><xsl:value-of select="$altText"/></xsl:attribute>
            <xsl:attribute name="src"><xsl:value-of select="$image-uri"/></xsl:attribute>
          </xsl:element>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:when>
  <xsl:otherwise>
    <xsl:if test="//n1:observationMedia[@ID=$imageRef]/n1:value[@mediaType='image/gif' or @mediaType='image/jpeg' or @mediaType='image/png']">
      <xsl:choose>
        <!-- image data inline B64 coded -->
        <xsl:when test="//n1:observationMedia[@ID=$imageRef]/n1:value[@representation='B64']">
          <br class="clearer" ></br>
          <xsl:element name="img">
            <xsl:attribute name="alt"><xsl:value-of select="$altText"/></xsl:attribute>
            <xsl:attribute name="class">inlineimg</xsl:attribute>
            <xsl:attribute name="src">data:
              <xsl:value-of select="//n1:observationMedia[@ID=$imageRef]/n1:value/@mediaType"/>;base64,
              <xsl:value-of select="//n1:observationMedia[@ID=$imageRef]/n1:value"/></xsl:attribute>
          </xsl:element>
        </xsl:when>
        <!-- image ref -->
        <xsl:otherwise>
          <br class="clearer" ></br>
          <xsl:variable name="image-uri" select="//n1:observationMedia[@ID=$imageRef]/n1:value/n1:reference/@value" />
          <xsl:choose>
            <xsl:when test="contains($image-uri, ':') or starts-with($image-uri, '\\')">
              <p>Externe Bildpfade sind nicht erlaubt.</p>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$image-uri" />
              <xsl:element name="img">
                <xsl:attribute name="alt"><xsl:value-of select="$altText"/></xsl:attribute>
                <xsl:attribute name="src"><xsl:value-of select="$image-uri"/></xsl:attribute>
              </xsl:element>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <!-- PDF, Audio and Video download -->

    <xsl:if test="//n1:observationMedia[@ID=$imageRef]/n1:value/@mediaType='application/dicom'
                      or //n1:observationMedia[@ID=$imageRef]/n1:value/@mediaType='application/pdf'
                      or //n1:observationMedia[@ID=$imageRef]/n1:value/@mediaType='audio/mpeg'
                      or //n1:observationMedia[@ID=$imageRef]/n1:value/@mediaType='text/xml'
                      or //n1:observationMedia[@ID=$imageRef]/n1:value/@mediaType='video/mpeg'">
      <xsl:call-template name="generateMultimediaDownloadLink">
        <xsl:with-param name="text" select="//n1:observationMedia[@ID=$imageRef]/n1:value" />
        <xsl:with-param name="filename" select="$imageRef" />
      </xsl:call-template>
    </xsl:if>

  </xsl:otherwise>
</xsl:choose>

<xsl:if test="n1:caption">
  <div style="font-size: 14px;"><xsl:value-of select="n1:caption" /></div>
</xsl:if>

</xsl:template>

        <!-- linkHtml rendering -->
<xsl:template match="n1:linkHtml">
<xsl:variable name="url">
  <xsl:choose>
    <xsl:when test="contains(@href, 'http://') or contains(@href, 'https://')">
      <xsl:value-of select="@href" />
    </xsl:when>
    <xsl:otherwise>http://<xsl:value-of select="@href" /></xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<a>
  <xsl:attribute name="href">
    <xsl:value-of select="$url" />
  </xsl:attribute>
  <xsl:attribute name="target">
    <xsl:text>_blank</xsl:text>
  </xsl:attribute>
  <xsl:apply-templates/>
</a>
</xsl:template>

<xsl:template name="renderAuthenticatorContainer">

<xsl:variable name="title">
  <xsl:choose>
    <xsl:when test="//n1:ClinicalDocument/n1:code/@code='11502-2' or //n1:ClinicalDocument/n1:code/@code='18725-2'">
      <xsl:text>Validiert durch:</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>Unterzeichnet von:</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<div class="authenticatorContainer">
  <div class="collapseTrigger" onclick="toggleCollapseable(this);" id="IDAuthenticatorContainer">
    <div class="authenticatorTitle">
      <h1>
        <b>
          <xsl:value-of select="$title"/>
        </b>
      </h1>
    </div>
    <div class="authenticatorShortInfo">
      <xsl:for-each select="//n1:ClinicalDocument/n1:legalAuthenticator">
        <xsl:call-template name="renderAuthenticatorHead">
          <xsl:with-param name="node" select="." />
        </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//n1:ClinicalDocument/n1:authenticator">
        <xsl:call-template name="renderAuthenticatorHead">
          <xsl:with-param name="node" select="." />
        </xsl:call-template>
      </xsl:for-each>
    </div>
    <xsl:call-template name="collapseTrigger"/>
    <div class="clearer" />
  </div>
  <div class="collapsable authenticatorContainerNoPadding">
    <xsl:for-each select="//n1:ClinicalDocument/n1:legalAuthenticator">
      <xsl:call-template name="renderAuthenticatorCollapsable">
        <xsl:with-param name="node" select="." />
      </xsl:call-template>
    </xsl:for-each>
    <xsl:for-each select="//n1:ClinicalDocument/n1:authenticator">
      <xsl:call-template name="renderAuthenticatorCollapsable">
        <xsl:with-param name="node" select="." />
      </xsl:call-template>
    </xsl:for-each>
  </div>
</div>
</xsl:template>

<xsl:template name="renderAuthenticatorCollapsable">
  <xsl:param name="node" />

  <div class="leftsmall">
    <p class="name">
      <xsl:call-template name="getName">
        <xsl:with-param name="name" select="$node/n1:assignedEntity/n1:assignedPerson/n1:name"/>
        <xsl:with-param name="printNameBold" select="string(true())" />
      </xsl:call-template>
    </p>
    <xsl:call-template name="getContactInfo">
      <xsl:with-param name="contact" select="$node/n1:assignedEntity"/>
    </xsl:call-template>
  </div>
  <div class="leftwide">
    <p class="organisationName">
      <xsl:call-template name="getName">
        <xsl:with-param name="name" select="$node/n1:assignedEntity/n1:representedOrganization/n1:name"/>
      </xsl:call-template>
    </p>
    <xsl:call-template name="getContactInfo">
      <xsl:with-param name="contact" select="$node/n1:assignedEntity/n1:representedOrganization"/>
    </xsl:call-template>
  </div>
  <div class="clearer" />
  <div class="authenticatorContainerDivider" />

</xsl:template>

<xsl:template name="renderAuthenticatorHead">
  <xsl:param name="node" />

  <p class="name">
    <xsl:call-template name="getName">
      <xsl:with-param name="name" select="$node/n1:assignedEntity/n1:assignedPerson/n1:name"/>
    </xsl:call-template>

    <xsl:if test="$node/n1:time and not($node/n1:time/@nullFlavor)">
      <xsl:text> am </xsl:text>
      <xsl:call-template name="formatDate">
        <xsl:with-param name="date" select="$node/n1:time"/>
      </xsl:call-template>
    </xsl:if>
  </p>

</xsl:template>

<!-- nonXMLBody -->
<xsl:template match="n1:component/n1:nonXMLBody">
<hr />
<xsl:variable name="simple-sanitizer-match"><xsl:text>&#10;&#13;&#34;&#39;&#58;&#59;&#63;&#96;&#123;&#125;&#8220;&#8221;&#8222;&#8218;&#8217;</xsl:text></xsl:variable>
<xsl:variable name="simple-sanitizer-replace" select="'***************'"/>
<xsl:choose>
  <!-- if there is a reference, use that in an IFRAME -->
  <xsl:when test="n1:text/n1:reference">
    <xsl:variable name="source" select="string(n1:text/n1:reference/@value)"/>
    <xsl:variable name="lcSource" select="translate($source, $uc, $lc)"/>
    <xsl:variable name="scrubbedSource" select="translate($source, $simple-sanitizer-match, $simple-sanitizer-replace)"/>
    <xsl:choose>
      <xsl:when test="contains($lcSource,'javascript')">
        <p>Eingebettete Inhalte mit Javascript können nicht dargestellt werden.</p>
      </xsl:when>
      <xsl:when test="not($source = $scrubbedSource)">
        <p>Eingebettete Inhalte mit Javascript können nicht dargestellt werden. <xsl:value-of select="$scrubbedSource" /></p>
      </xsl:when>
      <xsl:otherwise>
        <IFRAME name='nonXMLBody' id='nonXMLBody' WIDTH='80%' HEIGHT='600' src='{$source}'/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:when>
  <xsl:when test="n1:text/@mediaType='text/plain'">
    <pre>
      <xsl:value-of select="n1:text/text()"/>
    </pre>
  </xsl:when>
  <!-- create PDF link -->
  <xsl:when test="n1:text/@mediaType='application/pdf'">
    <xsl:call-template name="generateMultimediaDownloadLink">
      <xsl:with-param name="text" select="n1:text" />
      <xsl:with-param name="filename"><xsl:text>ELGA-Dokument</xsl:text></xsl:with-param>
    </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
    <CENTER>Cannot display the text</CENTER>
  </xsl:otherwise>
</xsl:choose>
<hr />
</xsl:template>

<!-- Generate Multimedia download link -->
<xsl:template name="generateMultimediaDownloadLink">
<xsl:param name="text" />
<xsl:param name="filename" />

    <xsl:variable name="documentReference">
      <xsl:choose>
        <xsl:when test="not($filename)">
          <xsl:value-of select="'ELGADokument'" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$filename"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="documentTitle">
      <xsl:choose>
        <xsl:when test="not($filename)">
          <xsl:value-of select="'ELGA-Dokument'" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$filename"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$text/@mediaType='application/dicom'">
        <a href="#{$documentReference}" style="cursor:pointer" onclick="decodeB64('{$documentReference}_64','{$text/@mediaType}')">
          <img class="attachmentIcon" src="{$variousIcon}" />
          <xsl:value-of select="$documentTitle"/>
          <div id="{$documentReference}_64" style="display:none"><xsl:value-of select="$text"/></div>
        </a>
      </xsl:when>
      <xsl:when test="$text/@mediaType='application/pdf'">
        <a href="#{$documentReference}" style="cursor:pointer" onclick="decodeB64('{$documentReference}_64','{$text/@mediaType}')">
          <img class="attachmentIcon" src="{$pdfIcon}" />
          <xsl:value-of select="$documentTitle"/>
          <div id="{$documentReference}_64" style="display:none"><xsl:value-of select="$text"/></div>
        </a>
      </xsl:when>
      <xsl:when test="$text/@mediaType='audio/mpeg'">
        <a href="#{$documentReference}" style="cursor:pointer" onclick="decodeB64('{$documentReference}_64','{$text/@mediaType}')">
          <img class="attachmentIcon" src="{$audioIcon}" />
          <xsl:value-of select="$documentTitle"/>
          <div id="{$documentReference}_64" style="display:none"><xsl:value-of select="$text"/></div>
        </a>
      </xsl:when>
      <xsl:when test="$text/@mediaType='text/xml'">
        <a href="#{$documentReference}" style="cursor:pointer" onclick="decodeB64('{$documentReference}_64','{$text/@mediaType}')">
          <img class="attachmentIcon" src="{$variousIcon}" />
          <xsl:value-of select="$documentTitle"/>
          <div id="{$documentReference}_64" style="display:none"><xsl:value-of select="$text"/></div>
        </a>
      </xsl:when>
      <xsl:when test="$text/@mediaType='video/mpeg'">
        <a href="#{$documentReference}" style="cursor:pointer" onclick="decodeB64('{$documentReference}_64','{$text/@mediaType}')">
          <img class="attachmentIcon" src="{$videoIcon}" />
          <xsl:value-of select="$documentTitle"/>
          <div id="{$documentReference}_64" style="display:none"><xsl:value-of select="$text"/></div>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>Unbekannter Medientyp: </xsl:text><xsl:value-of select="$text/@mediaType" />
      </xsl:otherwise>
    </xsl:choose>

</xsl:template>

<xsl:template name="checkDocumentValid">
  <xsl:for-each select="//n1:table">
    <xsl:variable name="numHeaderCells">
      <xsl:call-template name="getNumHeaderCells">
        <xsl:with-param name="table" select="." />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="tableValid">
      <xsl:call-template name="checkTableValid">
        <xsl:with-param name="table" select="." />
        <xsl:with-param name="numHeaderCells" select="$numHeaderCells" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="$tableValid" />
  </xsl:for-each>
</xsl:template>


<xsl:variable name="videoIcon">data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAACXBIWXMAAC4jAAAuIwF4pT92AAAKsWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIiB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgeG1wOkNyZWF0ZURhdGU9IjIwMTgtMDctMjlUMTc6NDA6MTIrMDI6MDAiIHhtcDpNZXRhZGF0YURhdGU9IjIwMTgtMTAtMDhUMDE6MTM6NDkrMDI6MDAiIHhtcDpNb2RpZnlEYXRlPSIyMDE4LTEwLTA4VDAxOjEzOjQ5KzAyOjAwIiBkYzpmb3JtYXQ9ImltYWdlL3BuZyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpjMWYwMGE4OS0zZTM2LTRmNTUtYjg3Zi05ZTVhMTE3ODM3M2MiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDoxNGIyYjdhNy1lYmFmLTg2NDUtYjhjOS1iYWViMDI5MTlkMmMiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo0MTEzMDRhNy0yNGMzLTRiZTUtYmJkNC02ZjAxM2MyOGYzNDkiIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgdGlmZjpPcmllbnRhdGlvbj0iMSIgdGlmZjpYUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpZUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpSZXNvbHV0aW9uVW5pdD0iMiIgZXhpZjpDb2xvclNwYWNlPSIxIiBleGlmOlBpeGVsWERpbWVuc2lvbj0iNjQiIGV4aWY6UGl4ZWxZRGltZW5zaW9uPSI2NCI+IDx4bXBNTTpIaXN0b3J5PiA8cmRmOlNlcT4gPHJkZjpsaSBzdEV2dDphY3Rpb249ImNyZWF0ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5IiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQwOjEyKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ODA1YWFlMTktOWE5OC00YzFlLWE4YjMtM2FmNzI1MjJjNTAzIiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQ2OjA0KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ODM5ODBjNTEtODI2NS00Nzg2LThlOTYtOWY1NzA0OTg5ZWY3IiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA4VDAxOjEzOjQ5KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY29udmVydGVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJmcm9tIGFwcGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJkZXJpdmVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJjb252ZXJ0ZWQgZnJvbSBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wIHRvIGltYWdlL3BuZyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6YzFmMDBhODktM2UzNi00ZjU1LWI4N2YtOWU1YTExNzgzNzNjIiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA4VDAxOjEzOjQ5KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6ODM5ODBjNTEtODI2NS00Nzg2LThlOTYtOWY1NzA0OTg5ZWY3IiBzdFJlZjpkb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6YTFhYzMwMmYtMWEyZS0yMTQ4LTkwZmQtMTUwNTY5M2E3YzRiIiBzdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+Mg9LUAAAAKxJREFUSMdjYKADUATiw0D8B4hLkMS5gPgFEP8H4iIkcW4gfolFnAeIX0HFkTHDTiTOS6gBMFAEFX8BtRAGSqDiz4GYE0m8DJsFX9EEypA0cEIN+U+G7+AWoNv4CupdGMgn03c4LQDhCjRfPCXTdzgtoCYetWCQWcBPpdKBZB8I0jqIGEYtoJsFA5aKBndG+0VDw0FmMxygoQUgsxmUoJU+NX0CakAch5pNWwAArtOrc7bd1usAAAAASUVORK5CYII=</xsl:variable>

<xsl:variable name="audioIcon">data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAACXBIWXMAAC4jAAAuIwF4pT92AAALT2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIiB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgeG1wOkNyZWF0ZURhdGU9IjIwMTgtMDctMjlUMTc6NDA6MTIrMDI6MDAiIHhtcDpNZXRhZGF0YURhdGU9IjIwMTgtMTAtMDhUMDA6NDA6MDErMDI6MDAiIHhtcDpNb2RpZnlEYXRlPSIyMDE4LTEwLTA4VDAwOjQwOjAxKzAyOjAwIiBkYzpmb3JtYXQ9ImltYWdlL3BuZyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo3MGUzN2ZmZS1jMjc1LTRiYjEtYTJkMi1mNzU4MTUwYzI3OGEiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDozMzc3OWQ4NS0xYjY1LWY4NDEtOGRlZC1iNDc5MTVhNmEwMWQiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo0MTEzMDRhNy0yNGMzLTRiZTUtYmJkNC02ZjAxM2MyOGYzNDkiIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgdGlmZjpPcmllbnRhdGlvbj0iMSIgdGlmZjpYUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpZUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpSZXNvbHV0aW9uVW5pdD0iMiIgZXhpZjpDb2xvclNwYWNlPSIxIiBleGlmOlBpeGVsWERpbWVuc2lvbj0iNjQiIGV4aWY6UGl4ZWxZRGltZW5zaW9uPSI2NCI+IDx4bXBNTTpIaXN0b3J5PiA8cmRmOlNlcT4gPHJkZjpsaSBzdEV2dDphY3Rpb249ImNyZWF0ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5IiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQwOjEyKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ODA1YWFlMTktOWE5OC00YzFlLWE4YjMtM2FmNzI1MjJjNTAzIiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQ2OjA0KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ZWYzN2Y1YTMtZDQ0OS00YTM2LWFjY2MtYmE2ZjllYmZmMzY1IiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA4VDAwOjQwOjAxKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY29udmVydGVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJmcm9tIGFwcGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJkZXJpdmVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJjb252ZXJ0ZWQgZnJvbSBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wIHRvIGltYWdlL3BuZyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NzBlMzdmZmUtYzI3NS00YmIxLWEyZDItZjc1ODE1MGMyNzhhIiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA4VDAwOjQwOjAxKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6ZWYzN2Y1YTMtZDQ0OS00YTM2LWFjY2MtYmE2ZjllYmZmMzY1IiBzdFJlZjpkb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6YTFhYzMwMmYtMWEyZS0yMTQ4LTkwZmQtMTUwNTY5M2E3YzRiIiBzdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5Ii8+IDxwaG90b3Nob3A6RG9jdW1lbnRBbmNlc3RvcnM+IDxyZGY6QmFnPiA8cmRmOmxpPmFkb2JlOmRvY2lkOnBob3Rvc2hvcDpmMjNiYzhhOC1kYjFhLTk2NDgtYTMyMC04YmU2ZDk2MTNmMzM8L3JkZjpsaT4gPC9yZGY6QmFnPiA8L3Bob3Rvc2hvcDpEb2N1bWVudEFuY2VzdG9ycz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz53iMQ3AAABD0lEQVRIDWNgGOSAidoGMgJxLRL/DRDPAGJlahjOBsSLgfg/kth/KP4NxJ1AzEqu4UJAfADJQBgA+eYRkvhBIOYi1XCQ928hGfIfTZ4biCcgyW2DBiVRwAaIX6MZ/h+H2gok+WxiDI8E4h9YDEe2wA9Nz0aoPMhRnAxYIotYjKyvBYmvAsR/oeJJ1LIAhKOQxGCJYSM1LbiMJNYEFXtITQtAmA8qlgLl/6SmBX+hGZFmFpxAEmukRRD50TKSO4lJpthAFBEZzZ3YjIYL2ALxWyKLikpSiwoYUAPiO3gs4EEr7LaTUtjBgAgQH8NRXD9GEj9ETnENAxxAvApPhdNNSYWDXGV2YKkyVYdMpU8yAADDDtQtcObXnAAAAABJRU5ErkJggg==</xsl:variable>

<xsl:variable name="pdfIcon">data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAACXBIWXMAAC4jAAAuIwF4pT92AAAKsWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIiB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgeG1wOkNyZWF0ZURhdGU9IjIwMTgtMDctMjlUMTc6NDA6MTIrMDI6MDAiIHhtcDpNZXRhZGF0YURhdGU9IjIwMTgtMTAtMDhUMDE6NDU6NTgrMDI6MDAiIHhtcDpNb2RpZnlEYXRlPSIyMDE4LTEwLTA4VDAxOjQ1OjU4KzAyOjAwIiBkYzpmb3JtYXQ9ImltYWdlL3BuZyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo2ODc2NmViYi1mYWE0LTRiNDYtYWMwNi0wZDg0OGQwOGJiOGEiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDoyN2JmZjk5MS1lYzQ2LTQwNDMtYmQ5MS0xOWFjNjZmYjQ0ZGUiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo0MTEzMDRhNy0yNGMzLTRiZTUtYmJkNC02ZjAxM2MyOGYzNDkiIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgdGlmZjpPcmllbnRhdGlvbj0iMSIgdGlmZjpYUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpZUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpSZXNvbHV0aW9uVW5pdD0iMiIgZXhpZjpDb2xvclNwYWNlPSIxIiBleGlmOlBpeGVsWERpbWVuc2lvbj0iNjQiIGV4aWY6UGl4ZWxZRGltZW5zaW9uPSI2NCI+IDx4bXBNTTpIaXN0b3J5PiA8cmRmOlNlcT4gPHJkZjpsaSBzdEV2dDphY3Rpb249ImNyZWF0ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5IiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQwOjEyKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ODA1YWFlMTktOWE5OC00YzFlLWE4YjMtM2FmNzI1MjJjNTAzIiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQ2OjA0KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6MzNiY2YwNDAtNWRhOS00MGZjLWEyZjEtOTliM2FkYjcxYjg0IiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA4VDAxOjQ1OjU4KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY29udmVydGVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJmcm9tIGFwcGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJkZXJpdmVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJjb252ZXJ0ZWQgZnJvbSBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wIHRvIGltYWdlL3BuZyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6Njg3NjZlYmItZmFhNC00YjQ2LWFjMDYtMGQ4NDhkMDhiYjhhIiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA4VDAxOjQ1OjU4KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MzNiY2YwNDAtNWRhOS00MGZjLWEyZjEtOTliM2FkYjcxYjg0IiBzdFJlZjpkb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6YTFhYzMwMmYtMWEyZS0yMTQ4LTkwZmQtMTUwNTY5M2E3YzRiIiBzdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+wsEMggAAAPVJREFUSA1j+P//PwMIQ0EqEL8E4v8E8HcgXg3EIgyEAJoFz4kwHBlfAGJRUiwgxfB+KH0FiMVpYQE/ENdB2deAWIIWFjAgWXIDiKVoYQEI1EDFbgKxDC0sAIEqqPhdFEuoaAEIVEDlTlDDAnz4H60t+D8yLEAGJWhickC8A4s6XVItqATiViBmRRI7CsR+QCyMJAZywG5osUGSBdOQ2Mj0AzSxpeQGEcj1M4GYCc2Ch2gWVEJ98J3cOIggYAEMPCTVgh4gfocmBqLXAjEfNYJoGg5fgSqZzZRaMDQz2j9aW3CbSoa/xGWBDxA/odDwj0CcDjMQAHC58gE6siUEAAAAAElFTkSuQmCC</xsl:variable>

<xsl:variable name="variousIcon">data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAACXBIWXMAAC4jAAAuIwF4pT92AAAKsWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIiB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgeG1wOkNyZWF0ZURhdGU9IjIwMTgtMDctMjlUMTc6NDA6MTIrMDI6MDAiIHhtcDpNZXRhZGF0YURhdGU9IjIwMTgtMTAtMDhUMDA6MzI6NTYrMDI6MDAiIHhtcDpNb2RpZnlEYXRlPSIyMDE4LTEwLTA4VDAwOjMyOjU2KzAyOjAwIiBkYzpmb3JtYXQ9ImltYWdlL3BuZyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDphYmExZTMzMS04YjAwLTQxY2MtODgyZS0zNWU5ZThlYjE1OTgiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDpjY2YwZjRjMy0xNzVkLTAwNGItYmQwYS1iZjdkNzZhYTdjZDUiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo0MTEzMDRhNy0yNGMzLTRiZTUtYmJkNC02ZjAxM2MyOGYzNDkiIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgdGlmZjpPcmllbnRhdGlvbj0iMSIgdGlmZjpYUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpZUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpSZXNvbHV0aW9uVW5pdD0iMiIgZXhpZjpDb2xvclNwYWNlPSIxIiBleGlmOlBpeGVsWERpbWVuc2lvbj0iMjQiIGV4aWY6UGl4ZWxZRGltZW5zaW9uPSIyNCI+IDx4bXBNTTpIaXN0b3J5PiA8cmRmOlNlcT4gPHJkZjpsaSBzdEV2dDphY3Rpb249ImNyZWF0ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5IiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQwOjEyKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ODA1YWFlMTktOWE5OC00YzFlLWE4YjMtM2FmNzI1MjJjNTAzIiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQ2OjA0KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6MDhkYjFiMTMtZTQwZi00MjE4LTk3ZjAtNzgwZmU4ZjBlNDFhIiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA4VDAwOjMyOjU2KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY29udmVydGVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJmcm9tIGFwcGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJkZXJpdmVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJjb252ZXJ0ZWQgZnJvbSBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wIHRvIGltYWdlL3BuZyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6YWJhMWUzMzEtOGIwMC00MWNjLTg4MmUtMzVlOWU4ZWIxNTk4IiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA4VDAwOjMyOjU2KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MDhkYjFiMTMtZTQwZi00MjE4LTk3ZjAtNzgwZmU4ZjBlNDFhIiBzdFJlZjpkb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6ZjIzYmM4YTgtZGIxYS05NjQ4LWEzMjAtOGJlNmQ5NjEzZjMzIiBzdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+EPlkAQAAAfVJREFUSA3VwU1oDgAABuBnzDQpsxaNWSmjSO2iuOEwP41aOdhhisuWE2kuK6vlQFEUpUhIUuQgObjsQK3QcnHQDn4OEytrlmU23+uww8d8LcOB5/E/WIJd2Inl/qIluIQJBMEkbqLaHyjHYQwjCIIgCF5gkd+wFc8RBMEj7MEO3EMQnDQL9biNIAgG0YoyRXPxEME7v6ASxzCGIBjHCSzEOrT50SEEQY0ZtOAlgiC4j1WowllM4BNWKOpBECxQwlo8QBAEA2jGHBzAEIKggA5TGjCEoF8JnRhHEIyiCxXYiMcIgqAfm1CBoxhFELSZphtBUMAN1KEWl1FAEAyhHXOwHQMIguCMaTbgK4L3aDJlH4YRBBM4j8VYhbsIguA1WpRwHcEXbDBlCwoIgl40YiGO4zOCYAw9qFTCPIwhuKroKoKPaEUZWvEGQRDcwUrU4AI6TdOAIGhXdAvBW2xDL4IgeI4mlOMghhGMYKnvrEEQtCnajyAIgmAER1CBzXiGIAj6sNp3FmASwWlFZbiCICjgCmpRhxsoIAgGsR9lSuhF8AHL/Gg9WtCACnRhFEHwBadQZQa7EQRPUOtnzRhAEAQPsNYvuoYgGMY5dKATfQiC4BVazNJ83EIQBEEQBGPoRqU/sBdPEQTBCC6i3l9UjUasQbl/1Tc3E9A0XyyjzQAAAABJRU5ErkJggg==</xsl:variable>

<xsl:variable name="infoButtonIcon">data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAACXBIWXMAAC4jAAAuIwF4pT92AAAKsWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIiB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgeG1wOkNyZWF0ZURhdGU9IjIwMTgtMDctMjlUMTc6NDA6MTIrMDI6MDAiIHhtcDpNZXRhZGF0YURhdGU9IjIwMTgtMTAtMDhUMDI6MTA6MTArMDI6MDAiIHhtcDpNb2RpZnlEYXRlPSIyMDE4LTEwLTA4VDAyOjEwOjEwKzAyOjAwIiBkYzpmb3JtYXQ9ImltYWdlL3BuZyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDphMTM4ZDQwYi02Zjc2LTQ4NTQtOTVmYy02YWNlYWM4MWY5MDUiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDowMjM1M2JiNy1hZTFjLTUyNDEtYjFkMS01ZmJjMzM1MjFlMjUiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo0MTEzMDRhNy0yNGMzLTRiZTUtYmJkNC02ZjAxM2MyOGYzNDkiIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgdGlmZjpPcmllbnRhdGlvbj0iMSIgdGlmZjpYUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpZUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpSZXNvbHV0aW9uVW5pdD0iMiIgZXhpZjpDb2xvclNwYWNlPSIxIiBleGlmOlBpeGVsWERpbWVuc2lvbj0iNjQiIGV4aWY6UGl4ZWxZRGltZW5zaW9uPSI2NCI+IDx4bXBNTTpIaXN0b3J5PiA8cmRmOlNlcT4gPHJkZjpsaSBzdEV2dDphY3Rpb249ImNyZWF0ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5IiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQwOjEyKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ODA1YWFlMTktOWE5OC00YzFlLWE4YjMtM2FmNzI1MjJjNTAzIiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQ2OjA0KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NGM1Y2FjYzYtODhiOC00MzczLWJhNGItNDcyODYyZmY5MTk3IiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA4VDAyOjEwOjEwKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY29udmVydGVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJmcm9tIGFwcGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJkZXJpdmVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJjb252ZXJ0ZWQgZnJvbSBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wIHRvIGltYWdlL3BuZyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6YTEzOGQ0MGItNmY3Ni00ODU0LTk1ZmMtNmFjZWFjODFmOTA1IiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA4VDAyOjEwOjEwKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NGM1Y2FjYzYtODhiOC00MzczLWJhNGItNDcyODYyZmY5MTk3IiBzdFJlZjpkb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6YTFhYzMwMmYtMWEyZS0yMTQ4LTkwZmQtMTUwNTY5M2E3YzRiIiBzdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+st7aBgAAAQBJREFUSA1jYCAMzIC4EoiXAfFuKF4OFTNjIBMwAnE8EF8H4v8E8HWoWiZiDRcD4gNEGIyODwOxHCHDtYH4IRmGw/BzINbBZbgMED/Go/k9EL+D4vd41D0BYllsYb6fgOv4kdTzE1B7AGomHEQR4X1SLPgPNRMOLhOhQYxECy7DFOsTGYHIKUSISD0gsxmKyLBAjkg9ILMZ5tLQApDZDFtoaMEWulhA8yAqoqBoIISLQRYY0NACA1IyGqn4MiVFhRypRQUjEXUAsgUipBZ2DNAi9ikeTeuBeBUUr8ej7hm24pouFQ5ylXmQDMOPEFNlwgATtCK/SYTBN0mt9KnabAEAe2ODj95piEYAAAAASUVORK5CYII=</xsl:variable>

  <!-- Superscript -->
  <xsl:template match="n1:sup">
    <sup>
      <xsl:apply-templates/>
    </sup>
  </xsl:template>

  <!-- Subscript -->
  <xsl:template match="n1:sub">
    <sub>
      <xsl:apply-templates/>
    </sub>
  </xsl:template>


  <!--   RenderLogo
    only handles PNG's and JPEG's.  It could, however,
  media type  @ID  =$imageRef  referencedObject
    -->
  <xsl:template name="renderLogo">
    <xsl:param name="logo"/>

    <xsl:if test="$logo/n1:value[@mediaType='image/png' or @mediaType='image/jpg' or @mediaType='image/jpeg']">
      <!-- image data inline B64 coded -->
      <xsl:if test="$logo/n1:value/@representation='B64'">
        <xsl:element name="img">
          <xsl:attribute name="alt" />
          <xsl:attribute name="src">data:
          <xsl:value-of select="$logo/n1:value/@mediaType"/>;base64,
          <xsl:value-of select="$logo/n1:value"/></xsl:attribute>
        </xsl:element>
      </xsl:if>
    </xsl:if>
  </xsl:template>



  <!--
    Contact Information
  different rendering for telecom and addresses
  -->
  <xsl:template name="getContactInfo">
    <xsl:param name="contact"/>
    <xsl:apply-templates select="$contact/n1:addr"/>
    <xsl:apply-templates select="$contact/n1:telecom"/>
  </xsl:template>

  <xsl:template name="getContactAddress">
    <xsl:param name="contact"/>
    <div>
      <xsl:apply-templates select="$contact/n1:addr"/>
    </div>
  </xsl:template>

  <xsl:template name="getContactTelecom">
    <xsl:param name="contact"/>
    <xsl:apply-templates select="$contact/n1:telecom">
        <xsl:with-param name="asTable" select="false()" />
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template name="getContactTelecomTable">
    <xsl:param name="contact"/>
    <xsl:apply-templates select="$contact/n1:telecom">
        <xsl:with-param name="asTable" select="true()" />
    </xsl:apply-templates>
  </xsl:template>

  <!--
  get address
  -->
  <xsl:template match="n1:addr">
    <div class="address">
    <p class="addressRegion">
    <xsl:if test="@use">
      <!-- Wohnadresse etc. -->
      <xsl:call-template name="translateCode">
        <xsl:with-param name="code" select="@use"/>
      </xsl:call-template>
      <xsl:text>:</xsl:text>
    </xsl:if>
    </p>
    <xsl:for-each select="n1:streetAddressLine">
      <p class="streetAddress"><xsl:value-of select="."/></p>
    </xsl:for-each>
    <p class="street">
    <xsl:if test="n1:streetName">
      <xsl:value-of select="n1:streetName"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="n1:houseNumber"/>
    </xsl:if>
    </p>
    <p class="city">
    <xsl:value-of select="n1:postalCode"/>
    <xsl:text> </xsl:text>
    <xsl:variable name="uppercase" >
    <xsl:if test="n1:country != 'Österreich' and n1:country != 'A' and n1:country != 'Austria' and n1:country != 'Oesterreich' and n1:country != 'AUT' " >
      uppercase
    </xsl:if>
    </xsl:variable>
    <span class="{$uppercase}"><xsl:value-of select="n1:city"/></span>
    <xsl:if test="n1:state and not(n1:state/@nullFlavor)">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="n1:state"/>
    </xsl:if>
    </p>
    <xsl:if test="n1:country != 'Österreich' and n1:country != 'A' and n1:country != 'Austria' and n1:country != 'Oesterreich' and n1:country != 'AUT' ">
      <p class="country">

        <xsl:variable name="country">
          <xsl:call-template name="getCountryMapping">
            <xsl:with-param name="country" select="n1:country"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="translate($country, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>

      </p>
    </xsl:if>
    <xsl:value-of select="text()"/>
    </div>
  </xsl:template>

  <!--
    get telecom information (tel, www, ...)
  -->
  <xsl:template match="n1:telecom">
    <xsl:param name="asTable" />
    <xsl:variable name="type" select="substring-before(@value, ':')"/>
    <xsl:variable name="value" select="substring-after(@value, ':')"/>
    <xsl:if test="$type and not($asTable)">
      <p class="telecom">

        <xsl:if test="$type!='http' and $type!='mailto'">
          <xsl:choose>
            <xsl:when test="$type='tel' and @use='MC'">
              <xsl:call-template name="translateCode">
                <xsl:with-param name="code">
                  <xsl:text>MC</xsl:text>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="translateCode">
                <xsl:with-param name="code" select="$type"/>
              </xsl:call-template>
              <xsl:if test="@use">
                <span class="lighter"><xsl:text> (</xsl:text>
                  <xsl:call-template name="translateCode">
                    <xsl:with-param name="code" select="@use"/>
                  </xsl:call-template>
                  <xsl:text>)</xsl:text></span>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>  </xsl:text>
        </xsl:if>

        <xsl:choose>
          <!-- is url -->
          <xsl:when test="$type='http'">
            <a href="{@value}" target="_blank">
              <xsl:call-template name="uriDecode">
                <xsl:with-param name="uri" select="@value" />
              </xsl:call-template>
            </a>
          </xsl:when>
          <!-- is mail -->
          <xsl:when test="$type='mailto'">
            <a href="{@value}" target="_blank">
              <xsl:call-template name="uriDecode">
                <xsl:with-param name="uri" select="$value" />
              </xsl:call-template>
            </a>
          </xsl:when>
          <xsl:when test="$type='tel' or $type='fax'">
            <xsl:variable name="phoneNumber">
              <xsl:call-template name="uriDecode">
                <xsl:with-param name="uri" select="$value" />
              </xsl:call-template>
            </xsl:variable>

            <xsl:call-template name="string-replace-all">
              <xsl:with-param name="text" select="$phoneNumber" />
              <xsl:with-param name="replace" select="'.'" />
              <xsl:with-param name="by" select="' '" />
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="uriDecode">
              <xsl:with-param name="uri" select="$value" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </p>
    </xsl:if>
    <xsl:if test="$type and $asTable">
      <tr class="telecom">
        <td class="firstrow">

          <xsl:choose>
            <xsl:when test="$type='tel' and @use='MC'">
              <xsl:call-template name="translateCode">
                <xsl:with-param name="code">
                  <xsl:text>MC</xsl:text>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="translateCode">
                <xsl:with-param name="code" select="$type"/>
              </xsl:call-template>
              <xsl:if test="@use">
                <span class="lighter">
                  <xsl:text> (</xsl:text>
                  <xsl:call-template name="translateCode">
                    <xsl:with-param name="code" select="@use"/>
                  </xsl:call-template>
                  <xsl:text>)</xsl:text></span>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>  </xsl:text>
        </td>
        <td>
        <xsl:choose>
          <!-- is url -->
          <xsl:when test="$type='http'">
            <a href="{@value}" target="_blank">
              <xsl:call-template name="uriDecode">
                <xsl:with-param name="uri" select="@value" />
              </xsl:call-template>
            </a>
          </xsl:when>
          <!-- is mail -->
          <xsl:when test="$type='mailto'">
            <a href="{@value}" target="_blank">
              <xsl:call-template name="uriDecode">
                <xsl:with-param name="uri" select="$value" />
              </xsl:call-template>
            </a>
          </xsl:when>
          <xsl:when test="$type='tel'">
            <xsl:variable name="phoneNumber">
              <xsl:call-template name="uriDecode">
                <xsl:with-param name="uri" select="$value" />
              </xsl:call-template>
            </xsl:variable>

            <xsl:call-template name="string-replace-all">
              <xsl:with-param name="text" select="$phoneNumber" />
              <xsl:with-param name="replace" select="'.'" />
              <xsl:with-param name="by" select="' '" />
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="uriDecode">
              <xsl:with-param name="uri" select="$value" />
            </xsl:call-template>
          </xsl:otherwise>          
        </xsl:choose>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>

  <xsl:template name="getAddress">
    <xsl:param name="addr"/>
    <div class="address">
    <xsl:if test="$addr/n1:additionalLocator">
      <p class="locator"><xsl:value-of select="$addr/n1:additionalLocator"/></p>
    </xsl:if>
    <xsl:if test="$addr/n1:streetAddressLine">
      <p class="streetAddress"><xsl:value-of select="$addr/n1:streetAddressLine"/></p>
    </xsl:if>
    <p class="street">
    <xsl:if test="$addr/n1:streetName">
      <xsl:value-of select="$addr/n1:streetName"/>
    </xsl:if>
    <xsl:if test="$addr/n1:houseNumber">
      <xsl:text> </xsl:text>
      <xsl:value-of select="$addr/n1:houseNumber"/>
    </xsl:if>
    </p>
    <xsl:if test="$addr/n1:postalCode or $addr/n1:city">
      <p class="city">
      <xsl:value-of select="$addr/n1:postalCode"/>
      <xsl:text> </xsl:text>
    <xsl:variable name="uppercase" >
      <xsl:if test="$addr/n1:country != 'Österreich' and $addr/n1:country != 'A' and $addr/n1:country != 'Austria' and $addr/n1:country != 'Oesterreich' and n1:country != 'AUT' ">
      uppercase
      </xsl:if>
      </xsl:variable>
      <span class="{$uppercase}"><xsl:value-of select="$addr/n1:city"/></span>
      <xsl:if test="$addr/n1:state and not($addr/n1:state/@nullFlavor='UNK')">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="$addr/n1:state"/>
      </xsl:if>
      </p>
      <xsl:if test="$addr/n1:country != 'Österreich' and $addr/n1:country != 'A' and $addr/n1:country != 'Austria' and $addr/n1:country != 'Oesterreich' and n1:country != 'AUT' ">
      <p class="country">
        <xsl:value-of select="$addr/n1:country"/>
      </p>
      </xsl:if>
    </xsl:if>
    </div>
  </xsl:template>

  <xsl:template name="getAuthor">
    <xsl:param name="author"/>
    <xsl:if test="$author/n1:assignedPerson/n1:name">
      <xsl:call-template name="getName">
        <xsl:with-param name="name" select="$author/n1:assignedPerson/n1:name"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$author/../n1:time/@value">
        (am
        <xsl:call-template name="formatDate">
        <xsl:with-param name="date" select="$author/../n1:time"/>
      </xsl:call-template>)
      </xsl:if>
    <xsl:if test="$author/n1:addr">
      <xsl:call-template name="getAddress">
        <xsl:with-param name="addr" select="$author/n1:addr"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$author/n1:telecom">
      <xsl:apply-templates select="$author/n1:telecom"/>
    </xsl:if>
    <br/>
  </xsl:template>

  <xsl:template name="getOrganization">
    <xsl:param name="organization"/>
    <xsl:param name="showMore"><xsl:value-of select="0"/></xsl:param>
    <xsl:param name="printNameBold" select="string(false())" />

    <xsl:if test="$organization/n1:name">
      <xsl:choose>
        <xsl:when test="$printNameBold='true'">
          <p class="organisationName"><b><xsl:value-of select="$organization/n1:name"/></b></p>
        </xsl:when>
        <xsl:otherwise>
          <p class="organisationName"><xsl:value-of select="$organization/n1:name"/></p>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <xsl:if test="$organization/n1:addr">
      <xsl:call-template name="getAddress">
        <xsl:with-param name="addr" select="$organization/n1:addr"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$organization/n1:telecom">
      <xsl:apply-templates select="$organization/n1:telecom"/>
    </xsl:if>
    <xsl:if test="$organization/n1:asOrganizationPartOf/n1:wholeOrganization">
      <xsl:call-template name="getOrganization">
        <xsl:with-param name="organization" select="$organization/n1:asOrganizationPartOf/n1:wholeOrganization"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="count(/n1:ClinicalDocument/n1:author/n1:assignedAuthor[count(n1:assignedAuthoringDevice)=0]) &gt; 1">
      <xsl:if test="$showMore=1">
        <p class="telecom"><i>(mehrere Dokumentenverfasser)</i></p>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template name="getIntendedRecipient">
    <xsl:param name="recipient"/>
    <p class="organisationName">
      <xsl:text>z.H.: </xsl:text>
      <xsl:if test="$recipient/n1:informationRecipient/n1:name">
        <xsl:call-template name="getName">
          <xsl:with-param name="name" select="$recipient/n1:informationRecipient/n1:name"/>
        </xsl:call-template>
      </xsl:if>
    </p>
    <div class="recipient">
      <xsl:if test="$recipient/n1:addr">
        <xsl:call-template name="getAddress">
          <xsl:with-param name="addr" select="$recipient/n1:addr"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="$recipient/n1:telecom">
        <xsl:apply-templates select="$recipient/n1:telecom"/>
      </xsl:if>
    </div>
  </xsl:template>
  
  <!--
    code translations for encounter description 
  -->
  <xsl:template name="getEncounter">
    <xsl:variable name="codeName" select="/n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:code/@code" />
    <xsl:choose>
      <xsl:when test="$codeName = 'AMB' or $codeName = 'HH'">Besuch</xsl:when>
      <xsl:when test="$codeName = 'EMER' or $codeName = 'FLD' or $codeName = 'VR'">Behandlung</xsl:when>
      <xsl:when test="$codeName = 'IMP' or $codeName = 'ACUTE' or $codeName = 'NONAC' or $codeName = 'PRENC' or $codeName = 'SS'">Aufenthalt</xsl:when>    
      <xsl:otherwise> </xsl:otherwise>  
    </xsl:choose>
  </xsl:template>
  
  <!--
    code translations for encounter case number 
  -->
  <xsl:template name="getEncounterCaseNumber">
    <xsl:variable name="codeName" select="/n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:code/@code" />
    <xsl:choose>
      <xsl:when test="$codeName = 'AMB' or $codeName = 'HH' or $codeName = 'EMER' or $codeName = 'FLD' or $codeName = 'VR'">Fallzahl: </xsl:when>    
      <xsl:when test="$codeName = 'IMP' or $codeName = 'ACUTE' or $codeName = 'NONAC' or $codeName = 'PRENC' or $codeName = 'SS'">Aufnahmezahl: </xsl:when>    
      <xsl:otherwise> </xsl:otherwise>  
    </xsl:choose>
  </xsl:template>

  <xsl:template name="getEncounterType">
    <xsl:variable name="code" select="//n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:code/@code"/>
    <xsl:choose>
      <xsl:when test="$code = 'AMB'">Ambulant</xsl:when>
      <xsl:when test="$code = 'EMER'">Akutbehandlung</xsl:when>
      <xsl:when test="$code = 'FLD'">Notfall, Rettung, erste Hilfe</xsl:when>
      <xsl:when test="$code = 'HH'">Hausbesuch(e)</xsl:when>
      <xsl:when test="$code = 'IMP'">Stationär</xsl:when>
      <xsl:when test="$code = 'ACUTE'">Stationär</xsl:when>
      <xsl:when test="$code = 'NONAC'">Stationär</xsl:when>
      <xsl:when test="$code = 'PRENC'">Prästationär</xsl:when>
      <xsl:when test="$code = 'SS'">Tagesklinisch</xsl:when>
      <xsl:when test="$code = 'VR'">Behandlung</xsl:when>
      <xsl:otherwise>
        <xsl:text>unbekannter Aufenthaltscode (code: </xsl:text>
        <xsl:value-of select="$code"/>
        <xsl:text>)</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="getEncounterDurationFrom">
    <xsl:param name="useDateTimeFormat" select="string(false())"/>

    <xsl:variable name="shortMode">
      <xsl:choose>
        <xsl:when test="$useDateTimeFormat='true'">
          <xsl:text>false</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>true</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="formatDate">
      <xsl:with-param name="date" select="//n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/n1:low"/>
      <xsl:with-param name="date_shortmode" select="$shortMode" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="getEncounterDurationTo">
    <xsl:param name="useDateTimeFormat" select="string(false())"/>

    <xsl:variable name="shortMode">
      <xsl:choose>
        <xsl:when test="$useDateTimeFormat='true'">
          <xsl:text>false</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>true</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="formatDate">
      <xsl:with-param name="date" select="//n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/n1:high"/>
      <xsl:with-param name="date_shortmode" select="$shortMode" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="getEncounterText">
    <xsl:param name="format"><xsl:text>short</xsl:text></xsl:param>

    <xsl:call-template name="getEncounterType"/>

    <xsl:variable name="encounterType" select="//n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:code/@code"/>
    <xsl:choose>
      <xsl:when test="$encounterType='AMB'">
        <xsl:choose>
          <xsl:when test="$format='short'">
            <xsl:variable name="durationFrom">
              <xsl:call-template name="getEncounterDurationFrom"/>
            </xsl:variable>
            <xsl:variable name="durationTo">
              <xsl:call-template name="getEncounterDurationTo"/>
            </xsl:variable>
            <xsl:variable name="durationToValid">
              <xsl:call-template name="isDateTimeValid">
                <xsl:with-param name="date" select="//n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/n1:high" />
              </xsl:call-template>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="$durationFrom=$durationTo or $durationToValid='false'">
                <xsl:text> am </xsl:text>
                <xsl:value-of select="$durationFrom" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:text> vom </xsl:text>
                <xsl:value-of select="$durationFrom" />
                <xsl:text> bis </xsl:text>
                <xsl:value-of select="$durationTo" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="durationFrom">
              <xsl:call-template name="getEncounterDurationFrom"/>
            </xsl:variable>
            <xsl:variable name="durationTo">
              <xsl:call-template name="getEncounterDurationTo"/>
            </xsl:variable>
            <xsl:variable name="durationToValid">
              <xsl:call-template name="isDateTimeValid">
                <xsl:with-param name="date" select="//n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/n1:high" />
              </xsl:call-template>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="$durationFrom!=$durationTo and $durationToValid='true'">
                <xsl:text> vom </xsl:text>
                <xsl:call-template name="getEncounterDurationFrom">
                  <xsl:with-param name="useDateTimeFormat" select="string(true())" />
                </xsl:call-template>
                <xsl:text> bis </xsl:text>
                <xsl:call-template name="getEncounterDurationTo">
                  <xsl:with-param name="useDateTimeFormat" select="string(true())" />
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="$durationFrom=$durationTo and $durationToValid='true'">
                <xsl:text> am </xsl:text>
                <xsl:value-of select="$durationFrom" />
                <xsl:text> von </xsl:text>
                <xsl:call-template name="getTime">
                  <xsl:with-param name="date" select="//n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/n1:low" />
                </xsl:call-template>
                <xsl:text> bis </xsl:text>
                <xsl:call-template name="getTime">
                  <xsl:with-param name="date" select="//n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/n1:high" />
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text> am </xsl:text>
                <xsl:call-template name="getEncounterDurationFrom">
                  <xsl:with-param name="useDateTimeFormat" select="string(true())" />
                </xsl:call-template>
                <xsl:text> bis </xsl:text>
                <xsl:call-template name="getEncounterDurationTo">
                  <xsl:with-param name="useDateTimeFormat" select="string(true())" />
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$format='short'">
            <xsl:variable name="durationFrom">
              <xsl:call-template name="getEncounterDurationFrom"/>
            </xsl:variable>
            <xsl:if test="$durationFrom != ''">
              <xsl:text> vom </xsl:text>
              <xsl:value-of select="$durationFrom"/>
            </xsl:if>

            <xsl:variable name="durationTo">
              <xsl:call-template name="getEncounterDurationTo"/>
            </xsl:variable>
            <xsl:if test="$durationTo != ''">
              <xsl:text> bis </xsl:text>
              <xsl:value-of select="$durationTo"/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="durationFrom">
              <xsl:call-template name="getEncounterDurationFrom">
                <xsl:with-param name="useDateTimeFormat" select="string(true())" />
              </xsl:call-template>
            </xsl:variable>
            <xsl:text> vom </xsl:text>
            <xsl:value-of select="$durationFrom"/>

            <xsl:variable name="durationTo">
              <xsl:call-template name="getEncounterDurationTo">
                <xsl:with-param name="useDateTimeFormat" select="string(true())" />
              </xsl:call-template>
            </xsl:variable>
            <xsl:text> bis </xsl:text>
            <xsl:value-of select="$durationTo"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



    <!-- AUTO GENERATED TEMPLATE. DO NOT MODIFY! -->
    
    <xsl:template name="getELGAMaritalStatus">
        <xsl:param name="code" />
        
        <xsl:choose>
            <xsl:when test="$code='D'">Geschieden</xsl:when>
            <xsl:when test="$code='M'">Verheiratet</xsl:when>
            <xsl:when test="$code='S'">Ledig</xsl:when>
            <xsl:when test="$code='T'">In Lebenspartnerschaft</xsl:when>
            <xsl:when test="$code='W'">Verwitwet</xsl:when>
            <xsl:otherwise>unbekannter Ehestatus</xsl:otherwise>
        
        </xsl:choose>
    
    </xsl:template>
    


  <!--
    code translations for OIDs
  -->
  <xsl:template name="getNameFromOID">
    <xsl:for-each select="/n1:ClinicalDocument/n1:templateId">
      <xsl:variable name="oid">
        <xsl:value-of select="@root"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$oid = '1.2.40.0.34.11.1'">Allgemeiner Leitfaden</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.2'">, Entlassungsbrief (Ärztlich)</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.3'">, Entlassungsbrief (Pflege)</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.4'">, Laborbefund</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.5'">, Befund Bildgebende Diagnostik</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.8.1'">, e-Medikation (Rezept)</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.8.2'">, e-Medikation (Abgabe)</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.8.3'">, e-Medikation (Medikationsliste)</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.8.4'">, e-Medikation (Pharmazeutische Empfehlung)</xsl:when>
      </xsl:choose>
    </xsl:for-each>
    <xsl:if test="not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.1') and 
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.2') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.3') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.4') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.5') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.8.1') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.8.2') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.8.3') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.8.4')">
      <xsl:text>(keine)</xsl:text>
    </xsl:if>
  </xsl:template>

  <!--
    ELGA Interoperabilitätsstufe
  -->
  <xsl:template name="getEISFromOID">
    <xsl:for-each select="/n1:ClinicalDocument/n1:templateId">
      <xsl:variable name="oid">
        <xsl:value-of select="@root"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$oid = '1.2.40.0.34.11.2.0.1'">Basic/Structured</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.2.0.2'">Enhanced</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.2.0.3'">Full support</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.3.0.1'">Basic/Structured</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.3.0.2'">Enhanced</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.3.0.3'">Full support</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.4.0.1'">Basic/Structured</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.4.0.2'">Enhanced</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.4.0.3'">Full support</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.5.0.1'">Basic</xsl:when>
        <xsl:when test="$oid = '1.2.40.0.34.11.5.0.3'">Full support</xsl:when>
      </xsl:choose>
    </xsl:for-each>
    <xsl:if test="not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.2.0.1') and 
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.2.0.2') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.2.0.3') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.3.0.1') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.3.0.2') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.3.0.3') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.4.0.1') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.4.0.2') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.4.0.3') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.5.0.1') and
      not(/n1:ClinicalDocument/n1:templateId/@root='1.2.40.0.34.11.5.0.3')">
      <xsl:text>(keine)</xsl:text>
    </xsl:if>
  </xsl:template>



    <!-- AUTO GENERATED TEMPLATE. DO NOT MODIFY! -->
    
    <xsl:template name="getELGAMedikationRezeptart">
        <xsl:param name="code" />
        
        <xsl:choose>
            <xsl:when test="$code='KASSEN'">Kassenrezept</xsl:when>
            <xsl:when test="$code='PRIVAT'">Privatrezept</xsl:when>
            <xsl:when test="$code='SUBST'">Substitutionsrezept</xsl:when>
            <xsl:otherwise>Unbekannter Rezepttyp</xsl:otherwise>
        
        </xsl:choose>
    
    </xsl:template>
    


  <!-- ServiceEvents -->
  <xsl:template name="getServiceEvents">
    <ul class="serviceeventlist">
    <xsl:for-each select="*/n1:serviceEvent/n1:code">
      <li>
      	<xsl:choose>
      	  <xsl:when test="@displayName='Microbiology studies (set)'">
      	  	<xsl:text>Mikrobiologie</xsl:text>
      	  </xsl:when>
      	  <xsl:otherwise>
            <xsl:value-of select="@displayName" />
      	  </xsl:otherwise>
      	</xsl:choose>
    	</li>
    </xsl:for-each>
    </ul>
  </xsl:template>



    <!-- AUTO GENERATED TEMPLATE. DO NOT MODIFY! -->
    
    <xsl:template name="getHL7ATXDSDokumentenklassen">
        <xsl:param name="code" />
        
        <xsl:choose>
            <xsl:when test="$code='18842-5'">Entlassungsbrief</xsl:when>
            <xsl:when test="$code='11490-0'">Entlassungsbrief Ärztlich</xsl:when>
            <xsl:when test="$code='34745-0'">Entlassungsbrief Pflege</xsl:when>
            <xsl:when test="$code='18761-7'">Transferbericht (Verlegungsbericht)</xsl:when>
            <xsl:when test="$code='11502-2'">Laborbefund</xsl:when>
            <xsl:when test="$code='18748-4'">Befund bildgebende Diagnostik</xsl:when>
            <xsl:when test="$code='25045-6'">Computertomographie-Befund</xsl:when>
            <xsl:when test="$code='25056-3'">Magnetresonanztomographie-Befund</xsl:when>
            <xsl:when test="$code='25061-3'">Ultraschall-Befund</xsl:when>
            <xsl:when test="$code='49118-3'">Nuklearmedizinischer Befund</xsl:when>
            <xsl:when test="$code='44136-0'">Positronen-Emissions-Tomographie-Befund</xsl:when>
            <xsl:when test="$code='18745-0'">Herzkatheter-Befund</xsl:when>
            <xsl:when test="$code='42148-7'">Echokardiographie-Befund</xsl:when>
            <xsl:when test="$code='18782-3'">Radiologie-Befund</xsl:when>
            <xsl:when test="$code='18746-8'">Kolonoskopie-Befund</xsl:when>
            <xsl:when test="$code='18751-8'">Endoskopie-Befund</xsl:when>
            <xsl:when test="$code='11525-3'">Geburtshilfliche Ultraschalluntersuchung</xsl:when>
            <xsl:when test="$code='55113-5'">KOS Objekte</xsl:when>
            <xsl:when test="$code='52471-0'">Medikation</xsl:when>
            <xsl:when test="$code='57833-6'">Rezept</xsl:when>
            <xsl:when test="$code='60593-1'">Abgabe</xsl:when>
            <xsl:when test="$code='56445-0'">Medikationsliste</xsl:when>
            <xsl:when test="$code='61356-2'">Pharmazeutische Empfehlung</xsl:when>
            <xsl:when test="$code='11529-5'">Pathologiebefund</xsl:when>
            <xsl:when test="$code='18743-5'">Obduktionsbefund</xsl:when>
            <xsl:when test="$code='18725-2'">Mikrobiologie-Befund</xsl:when>
            <xsl:when test="$code='11504-8'">OP-Bericht</xsl:when>
            <xsl:when test="$code='57829-4'">Verordnung von Heilbehelfen und Hilfsmitteln</xsl:when>
            <xsl:when test="$code='64288-4'">Brillenverordnung</xsl:when>
            <xsl:when test="$code='75476-2'">Ärztlicher Befund</xsl:when>
            <xsl:when test="$code='34131-3'">Ärztlicher Statusbericht</xsl:when>
            <xsl:when test="$code='34764-1'">Allgemeinmedizinischer Befund</xsl:when>
            <xsl:when test="$code='77403-4'">Anästhesiologischer Befund</xsl:when>
            <xsl:when test="$code='34803-7'">Arbeitsmedizinischer Befund</xsl:when>
            <xsl:when test="$code='34807-8'">Augenbefund</xsl:when>
            <xsl:when test="$code='33720-4'">Immunhämatologischer Befund</xsl:when>
            <xsl:when test="$code='34847-4'">Chirurgischer Befund</xsl:when>
            <xsl:when test="$code='34758-3'">Dermatologiebefund</xsl:when>
            <xsl:when test="$code='34760-9'">Diabetologischer Befund</xsl:when>
            <xsl:when test="$code='34879-7'">Endokrinologiebefund</xsl:when>
            <xsl:when test="$code='34761-7'">Gastroenterologiebefund</xsl:when>
            <xsl:when test="$code='34853-2'">Gefäßchirurgischer Befund</xsl:when>
            <xsl:when test="$code='34776-5'">Geriatriebefund</xsl:when>
            <xsl:when test="$code='69438-0'">Gerichtsmedizinischer Befund</xsl:when>
            <xsl:when test="$code='34777-3'">Gynäkologie-Befund</xsl:when>
            <xsl:when test="$code='34816-9'">Hals-Nasen-Ohrenheilkunde-Befund</xsl:when>
            <xsl:when test="$code='34779-9'">Hämatologie-Befund</xsl:when>
            <xsl:when test="$code='80575-4'">Herzchirurgischer Befund</xsl:when>
            <xsl:when test="$code='77429-9'">Immunologischer Befund</xsl:when>
            <xsl:when test="$code='34781-5'">Infektiologiebefund</xsl:when>
            <xsl:when test="$code='85238-4'">Internistischer Befund</xsl:when>
            <xsl:when test="$code='34099-2'">Kardiologiebefund</xsl:when>
            <xsl:when test="$code='68881-2'">Kinder- und Jugendchirurgischer Befund</xsl:when>
            <xsl:when test="$code='68645-1'">Kinder- und Jugendpsychiatrischer Befund</xsl:when>
            <xsl:when test="$code='78254-0'">Medizinisch-Genetischer Befund</xsl:when>
            <xsl:when test="$code='34812-8'">Mund-, Kiefer- und Gesichtschirurgischer Befund</xsl:when>
            <xsl:when test="$code='34795-5'">Nephrologischer befund</xsl:when>
            <xsl:when test="$code='34798-9'">Neurochirurgischer Befund</xsl:when>
            <xsl:when test="$code='34797-1'">Neurologischer Befund</xsl:when>
            <xsl:when test="$code='34878-9'">Notfallmedizinischer Befund</xsl:when>
            <xsl:when test="$code='34805-2'">Onkologiebefund</xsl:when>
            <xsl:when test="$code='34814-4'">Orthopädischer/Orthopädisch-Chirurgischer Befund</xsl:when>
            <xsl:when test="$code='78726-7'">Pädiatrischer Befund</xsl:when>
            <xsl:when test="$code='78568-3'">Palliativmedizinischer Befund</xsl:when>
            <xsl:when test="$code='34820-1'">Pharmakologisch-Toxikologischer Befund</xsl:when>
            <xsl:when test="$code='34822-7'">Physikalisch-Medizinischer Befund</xsl:when>
            <xsl:when test="$code='34826-8'">Plastisch-Chirurgischer Befund</xsl:when>
            <xsl:when test="$code='67862-3'">Präoperativer Befund</xsl:when>
            <xsl:when test="$code='34788-0'">Psychiatrischer Befund</xsl:when>
            <xsl:when test="$code='34103-2'">Pulmologischer Befund</xsl:when>
            <xsl:when test="$code='82359-1'">Reproduktionsmedizinischer Befund</xsl:when>
            <xsl:when test="$code='34839-1'">Rheumatologischer Befund</xsl:when>
            <xsl:when test="$code='85866-2'">Schlafmedizinischer Befund</xsl:when>
            <xsl:when test="$code='78738-2'">Sportmedizinischer Befund</xsl:when>
            <xsl:when test="$code='34831-8'">Strahlentherapeutisch-Radioonkologischer Befund</xsl:when>
            <xsl:when test="$code='34849-0'">Thoraxchirurgischer Befund</xsl:when>
            <xsl:when test="$code='78732-5'">Unfallchirurgischer Befund</xsl:when>
            <xsl:when test="$code='34851-6'">Urologischer Befund</xsl:when>
            <xsl:when test="$code='34756-7'">Zahn-, Mund- und Kieferheilkunde-Befund</xsl:when>
            <xsl:when test="$code='28651-8'">Pflegesituationsbericht</xsl:when>
            <xsl:when test="$code='46215-0'">Wunddokumentation</xsl:when>
            <xsl:when test="$code='57016-8'">Patienteneinverständniserklärung</xsl:when>
            <xsl:when test="$code='42348-3'">Patientenverfügung</xsl:when>
            <xsl:when test="$code='64298-3'">Vorsorgevollmacht</xsl:when>
            <xsl:when test="$code='34855-7'">Ergotherapeutischer Bericht</xsl:when>
            <xsl:when test="$code='34845-8'">Logopädischer Bericht</xsl:when>
            <xsl:when test="$code='34841-7'">Sozialpädagogischer Bericht</xsl:when>
            <xsl:when test="$code='34791-4'">Psychologischer Bericht</xsl:when>
            <xsl:when test="$code='34800-3'">Diätologie-Bericht</xsl:when>
            <xsl:when test="$code='34824-3'">Physiotherapiebericht</xsl:when>
            <xsl:when test="$code='57057-2'">Geburtsbericht (ärztlich)</xsl:when>
            <xsl:when test="$code='59268-3'">Geburtsbericht (Hebamme)</xsl:when>
            <xsl:when test="$code='34810-2'">Optometrischer Bericht</xsl:when>
            <xsl:when test="$code='29749-9'">Dialysebericht</xsl:when>
            <xsl:when test="$code='72134-0'">Krebsregistermeldung</xsl:when>
            <xsl:when test="$code='57830-2'">Einweisungsbericht</xsl:when>
            <xsl:when test="$code='57834-4'">Anforderung für Patiententransport</xsl:when>
            <xsl:when test="$code='11524-6'">EKG-Bericht</xsl:when>
            <xsl:when test="$code='46209-3'">Anforderung / Auftrag</xsl:when>
            <xsl:when test="$code='11488-4'">Befund</xsl:when>
            <xsl:when test="$code='57831-0'">Antrag auf Anschlussheilverfahren</xsl:when>
            <xsl:when test="$code='60591-5'">Patient Summary</xsl:when>
            <xsl:when test="$code='34133-9'">Krankengeschichte</xsl:when>
            <xsl:when test="$code='11369-6'">Immunisierungsstatus</xsl:when>
            <xsl:when test="$code='82593-5'">Immunisierungsstatus - Zusammenfassung</xsl:when>
            <xsl:when test="$code='87273-9'">Update Immunisierungsstatus</xsl:when>
            <xsl:when test="$code='75496-0'">Telemedizin Bericht</xsl:when>
            <xsl:when test="$code='75497-8'">Telemedizin Fortschrittbericht</xsl:when>
            <xsl:when test="$code='75498-6'">Telemedizin Endbericht</xsl:when>
            <xsl:when test="$code='75500-9'">Triage-Dokumentation</xsl:when>
            <xsl:when test="$code='54094-8'">Triage der Notfallabteilung</xsl:when>
            <xsl:when test="$code='75499-4'">Hotline-Triage (Telefonkontakt)</xsl:when>
            <xsl:otherwise>unbestätigte Dokumentenklasse</xsl:otherwise>
        
        </xsl:choose>
    
    </xsl:template>
    



    <!-- AUTO GENERATED TEMPLATE. DO NOT MODIFY! -->
    
    <xsl:template name="getELGAReligiousAffiliation">
        <xsl:param name="religiousAffiliation" />
        
        <xsl:choose>
            <xsl:when test="$religiousAffiliation/@code='100'">Katholische Kirche (o.n.A.)</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='101'">Römisch-Katholisch</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='102'">Griechisch-Katholische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='103'">Armenisch-Katholische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='104'">Bulgarisch-Katholische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='105'">Rumänische griechisch-katholische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='106'">Russisch-Katholische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='107'">Syrisch-Katholische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='108'">Ukrainische Griechisch-Katholische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='109'">Katholische Ostkirche (ohne nähere Angabe)</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='110'">Griechisch-Orientalische Kirchen</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='111'">Orthodoxe Kirchen (o.n.A.)</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='112'">Griechisch-Orthodoxe Kirche (Hl.Dreifaltigkeit)</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='113'">Griechisch-Orthodoxe Kirche (Hl.Georg)</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='114'">Bulgarisch-Orthodoxe Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='115'">Rumänisch-griechisch-orientalische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='116'">Russisch-Orthodoxe Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='117'">Serbisch-griechisch-Orthodoxe Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='118'">Ukrainisch-Orthodoxe Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='119'">Orientalisch-Orthodoxe Kirchen</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='120'">Armenisch-apostolische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='121'">Syrisch-orthodoxe Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='122'">Syrisch-orthodoxe Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='123'">Koptisch-orthodoxe Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='124'">Armenisch-apostolische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='125'">Äthiopisch-Orthodoxe Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='126'">Evangelische Kirchen Österreich</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='127'">Evangelische Kirche (o.n.A.)</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='128'">Evangelische Kirche A.B.</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='129'">Evangelische Kirche H.B.</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='130'">Andere Christliche Kirchen</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='131'">Altkatholische Kirche Österreichs</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='132'">Anglikanische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='133'">Evangelisch-methodistische Kirche (EmK)</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='134'">Sonstige Christliche Gemeinschaften</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='135'">Baptisten</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='136'">Bund evangelikaler Gemeinden in Österreich</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='137'">Freie Christengemeinde/Pfingstgemeinde</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='138'">Mennonitische Freikirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='139'">Kirche der Siebenten-Tags-Adventisten</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='140'">Christengemeinschaft</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='141'">Jehovas Zeugen</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='142'">Neuapostolische Kirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='143'">Mormonen</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='144'">Sonstige Christliche Gemeinschaften (O.n.A.)</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='145'">ELAIA Christengemeinden</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='146'">Pfingstkirche Gemeinde Gottes</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='148'">Nicht-christliche Gemeinschaften</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='149'">Israelitische Religionsgesellschaft</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='150'">Islamische Glaubensgemeinschaft</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='151'">Alevitische Religionsgesellschaft</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='152'">Buddhistische Religionsgesellschaft</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='153'">Baha` i</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='154'">Hinduistische Religionsgesellschaft</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='155'">Sikh</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='156'">Shintoismus</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='157'">Vereinigungskirche</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='162'">Pastafarianismus</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='158'">Andere religiöse Bekenntnisgemeinschaften</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='159'">Konfessionslos, ohne Angabe</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='160'">Konfessionslos</xsl:when>
            <xsl:when test="$religiousAffiliation/@code='161'">Ohne Angabe</xsl:when>
            <xsl:otherwise><xsl:value-of select="$religiousAffiliation/@displayName" /></xsl:otherwise>
        
        </xsl:choose>
    
    </xsl:template>
    


  <xsl:key name="languageCodeGrouping" match="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:languageCommunication" use="n1:languageCode/@code" />

  <xsl:template name="getLanguageAbility">
  <xsl:param name="patient" />

  <xsl:if test="not($patient/n1:languageCommunication)">
    unbekannt
  </xsl:if>

  <xsl:for-each select="$patient/n1:languageCommunication[generate-id() = generate-id(key('languageCodeGrouping', n1:languageCode/@code))]">

    <xsl:call-template name="getELGAHumanLanguage">
      <xsl:with-param name="code" select="n1:languageCode/@code" />
    </xsl:call-template>
    <xsl:text> </xsl:text>

    <xsl:if test="contains(n1:languageCode/@code, '-')">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="n1:languageCode/@code" />
      <xsl:text>)</xsl:text>
    </xsl:if>

    <xsl:if test="n1:modeCode/@code or n1:proficiencyLevelCode/@code">

      <xsl:text> (</xsl:text>

      <xsl:call-template name="getLanguageAbilityForLanguage">
        <xsl:with-param name="code" select="n1:languageCode/@code" />
        <xsl:with-param name="patient" select="$patient" />
      </xsl:call-template>

      <xsl:text>)</xsl:text>

    </xsl:if>

    <xsl:if test="n1:preferenceInd/@value='true'">
      <xsl:text>, bevorzugt</xsl:text>
    </xsl:if>


    <br />
  </xsl:for-each>

  </xsl:template>

  <xsl:template name="getLanguageAbilityForLanguage">
  <xsl:param name="code" />
  <xsl:param name="patient" />

  <xsl:for-each select="$patient/n1:languageCommunication/n1:languageCode[@code=$code]">

    <xsl:if test="../n1:languageCode/@code=$code">

      <xsl:if test="../n1:modeCode/@code">
        <xsl:call-template name="getELGALanguageAbilityMode">
          <xsl:with-param name="code" select="../n1:modeCode/@code" />
        </xsl:call-template>
        <xsl:text>: </xsl:text>
      </xsl:if>

      <xsl:if test="../n1:proficiencyLevelCode/@code">
        <xsl:call-template name="getELGAProficiencyLevelCode">
          <xsl:with-param name="code" select="../n1:proficiencyLevelCode/@code" />
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="position() &lt; count($patient/n1:languageCommunication/n1:languageCode[@code=$code])">
        <xsl:text>, </xsl:text>
      </xsl:if>

    </xsl:if>
  </xsl:for-each>

  </xsl:template>



    <!-- AUTO GENERATED TEMPLATE. DO NOT MODIFY! -->
    
    <xsl:template name="getELGAProficiencyLevelCode">
        <xsl:param name="code" />
        
        <xsl:choose>
            <xsl:when test="$code='E'">ausgezeichnet</xsl:when>
            <xsl:when test="$code='F'">ausreichend</xsl:when>
            <xsl:when test="$code='G'">gut</xsl:when>
            <xsl:when test="$code='P'">mangelhaft</xsl:when>
            <xsl:otherwise>unbekannter Code (<xsl:value-of select="$code" />)</xsl:otherwise>
        
        </xsl:choose>
    
    </xsl:template>
    



    <!-- AUTO GENERATED TEMPLATE. DO NOT MODIFY! -->
    
    <xsl:template name="getELGALanguageAbilityMode">
        <xsl:param name="code" />
        
        <xsl:choose>
            <xsl:when test="$code='ESP'">spricht</xsl:when>
            <xsl:when test="$code='EWR'">schreibt</xsl:when>
            <xsl:when test="$code='RSP'">versteht gesprochen</xsl:when>
            <xsl:when test="$code='RWR'">versteht geschrieben</xsl:when>
            <xsl:otherwise>unbekannter Code (<xsl:value-of select="$code" />)</xsl:otherwise>
        
        </xsl:choose>
    
    </xsl:template>
    



    <!-- AUTO GENERATED TEMPLATE. DO NOT MODIFY! -->
    
    <xsl:template name="getELGAHumanLanguage">
        <xsl:param name="code" />
        
        <xsl:variable name="trimmedCode">
            <xsl:choose>
              <xsl:when test="contains($code, '-')">
                <xsl:value-of select="substring-before($code,'-')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$code" />
              </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$trimmedCode='aa'">Danakil-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ab'">Abchasisch</xsl:when>
            <xsl:when test="$trimmedCode='ace'">Aceh-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ach'">Acholi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ada'">Adangme-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ady'">Adygisch</xsl:when>
            <xsl:when test="$trimmedCode='ae'">Avestisch</xsl:when>
            <xsl:when test="$trimmedCode='af'">Afrikaans</xsl:when>
            <xsl:when test="$trimmedCode='afa'">Hamitosemitische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='afh'">Afrihili</xsl:when>
            <xsl:when test="$trimmedCode='ain'">Ainu-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ak'">Akan-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='akk'">Akkadisch</xsl:when>
            <xsl:when test="$trimmedCode='ale'">Aleutisch</xsl:when>
            <xsl:when test="$trimmedCode='alg'">Algonkin-Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='alt'">Altaisch</xsl:when>
            <xsl:when test="$trimmedCode='am'">Amharisch</xsl:when>
            <xsl:when test="$trimmedCode='an'">Aragonesisch</xsl:when>
            <xsl:when test="$trimmedCode='ang'">Altenglisch</xsl:when>
            <xsl:when test="$trimmedCode='anp'">Anga-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='apa'">Apachen-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='ar'">Arabisch</xsl:when>
            <xsl:when test="$trimmedCode='arc'">Aramäisch</xsl:when>
            <xsl:when test="$trimmedCode='arn'">Arauka-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='arp'">Arapaho-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='art'">Kunstsprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='arw'">Arawak-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='as'">Assamesisch</xsl:when>
            <xsl:when test="$trimmedCode='ast'">Asturisch</xsl:when>
            <xsl:when test="$trimmedCode='ath'">Athapaskische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='aus'">Australische Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='av'">Awarisch</xsl:when>
            <xsl:when test="$trimmedCode='awa'">Awadhi</xsl:when>
            <xsl:when test="$trimmedCode='ay'">Aymará-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='az'">Aserbeidschanisch</xsl:when>
            <xsl:when test="$trimmedCode='ba'">Baschkirisch</xsl:when>
            <xsl:when test="$trimmedCode='bad'">Banda-Sprachen (Ubangi-Sprachen)</xsl:when>
            <xsl:when test="$trimmedCode='bai'">Bamileke-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='bal'">Belutschisch</xsl:when>
            <xsl:when test="$trimmedCode='ban'">Balinesisch</xsl:when>
            <xsl:when test="$trimmedCode='bas'">Basaa-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='bat'">Baltische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='be'">Weißrussisch</xsl:when>
            <xsl:when test="$trimmedCode='bej'">Bedauye</xsl:when>
            <xsl:when test="$trimmedCode='bem'">Bemba-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ber'">Berbersprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='bg'">Bulgarisch</xsl:when>
            <xsl:when test="$trimmedCode='bh'">Bihari (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='bho'">Bhojpuri</xsl:when>
            <xsl:when test="$trimmedCode='bi'">Beach-la-mar</xsl:when>
            <xsl:when test="$trimmedCode='bik'">Bikol-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='bin'">Edo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='bla'">Blackfoot-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='bm'">Bambara-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='bn'">Bengali</xsl:when>
            <xsl:when test="$trimmedCode='bnt'">Bantusprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='bo'">Tibetisch</xsl:when>
            <xsl:when test="$trimmedCode='br'">Bretonisch</xsl:when>
            <xsl:when test="$trimmedCode='bra'">Braj-Bhakha</xsl:when>
            <xsl:when test="$trimmedCode='bs'">Bosnisch</xsl:when>
            <xsl:when test="$trimmedCode='btk'">Batak-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='bua'">Burjatisch</xsl:when>
            <xsl:when test="$trimmedCode='bug'">Bugi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='byn'">Bilin-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ca'">Katalanisch</xsl:when>
            <xsl:when test="$trimmedCode='cad'">Caddo-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='cai'">Indianersprachen, Zentralamerika (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='car'">Karibische Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='cau'">Kaukasische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='ce'">Tschetschenisch</xsl:when>
            <xsl:when test="$trimmedCode='ceb'">Cebuano</xsl:when>
            <xsl:when test="$trimmedCode='cel'">Keltische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='ch'">Chamorro-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='chb'">Chibcha-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='chg'">Tschagataisch</xsl:when>
            <xsl:when test="$trimmedCode='chk'">Trukesisch</xsl:when>
            <xsl:when test="$trimmedCode='chm'">Tscheremissisch</xsl:when>
            <xsl:when test="$trimmedCode='chn'">Chinook-Jargon</xsl:when>
            <xsl:when test="$trimmedCode='cho'">Choctaw-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='chp'">Chipewyan-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='chr'">Cherokee-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='chy'">Cheyenne-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='cmc'">Cham-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='co'">Korsisch</xsl:when>
            <xsl:when test="$trimmedCode='cop'">Koptisch</xsl:when>
            <xsl:when test="$trimmedCode='cpe'">Kreolisch-Englisch (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='cpf'">Kreolisch-Französisch (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='cpp'">Kreolisch-Portugiesisch (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='cr'">Cree-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='crh'">Krimtatarisch</xsl:when>
            <xsl:when test="$trimmedCode='crp'">Kreolische Sprachen, Pidginsprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='cs'">Tschechisch</xsl:when>
            <xsl:when test="$trimmedCode='csb'">Kaschubisch</xsl:when>
            <xsl:when test="$trimmedCode='cu'">Kirchenslawisch</xsl:when>
            <xsl:when test="$trimmedCode='cus'">Kuschitische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='cv'">Tschuwaschisch</xsl:when>
            <xsl:when test="$trimmedCode='cy'">Kymrisch</xsl:when>
            <xsl:when test="$trimmedCode='da'">Dänisch</xsl:when>
            <xsl:when test="$trimmedCode='dak'">Dakota-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='dar'">Darginisch</xsl:when>
            <xsl:when test="$trimmedCode='day'">Dajakisch</xsl:when>
            <xsl:when test="$trimmedCode='de'">Deutsch</xsl:when>
            <xsl:when test="$trimmedCode='del'">Delaware-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='den'">Slave-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='dgr'">Dogrib-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='din'">Dinka-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='doi'">Dogri</xsl:when>
            <xsl:when test="$trimmedCode='dra'">Drawidische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='dsb'">Niedersorbisch</xsl:when>
            <xsl:when test="$trimmedCode='dua'">Duala-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='dum'">Mittelniederländisch</xsl:when>
            <xsl:when test="$trimmedCode='dv'">Maledivisch</xsl:when>
            <xsl:when test="$trimmedCode='dyu'">Dyula-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='dz'">Dzongkha</xsl:when>
            <xsl:when test="$trimmedCode='ee'">Ewe-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='efi'">Efik</xsl:when>
            <xsl:when test="$trimmedCode='egy'">Ägyptisch</xsl:when>
            <xsl:when test="$trimmedCode='eka'">Ekajuk</xsl:when>
            <xsl:when test="$trimmedCode='el'">Neugriechisch</xsl:when>
            <xsl:when test="$trimmedCode='elx'">Elamisch</xsl:when>
            <xsl:when test="$trimmedCode='en'">Englisch</xsl:when>
            <xsl:when test="$trimmedCode='enm'">Mittelenglisch</xsl:when>
            <xsl:when test="$trimmedCode='eo'">Esperanto</xsl:when>
            <xsl:when test="$trimmedCode='es'">Spanisch</xsl:when>
            <xsl:when test="$trimmedCode='et'">Estnisch</xsl:when>
            <xsl:when test="$trimmedCode='eu'">Baskisch</xsl:when>
            <xsl:when test="$trimmedCode='ewo'">Ewondo</xsl:when>
            <xsl:when test="$trimmedCode='fa'">Persisch</xsl:when>
            <xsl:when test="$trimmedCode='fan'">Pangwe-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='fat'">Fante-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ff'">Ful</xsl:when>
            <xsl:when test="$trimmedCode='fi'">Finnisch</xsl:when>
            <xsl:when test="$trimmedCode='fil'">Pilipino</xsl:when>
            <xsl:when test="$trimmedCode='fiu'">Finnougrische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='fj'">Fidschi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='fo'">Färöisch</xsl:when>
            <xsl:when test="$trimmedCode='fon'">Fon-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='fr'">Französisch</xsl:when>
            <xsl:when test="$trimmedCode='frm'">Mittelfranzösisch</xsl:when>
            <xsl:when test="$trimmedCode='fro'">Altfranzösisch</xsl:when>
            <xsl:when test="$trimmedCode='frr'">Nordfriesisch</xsl:when>
            <xsl:when test="$trimmedCode='frs'">Ostfriesisch</xsl:when>
            <xsl:when test="$trimmedCode='fur'">Friulisch</xsl:when>
            <xsl:when test="$trimmedCode='fy'">Friesisch</xsl:when>
            <xsl:when test="$trimmedCode='ga'">Irisch</xsl:when>
            <xsl:when test="$trimmedCode='gaa'">Ga-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='gay'">Gayo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='gba'">Gbaya-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='gd'">Gälisch-Schottisch</xsl:when>
            <xsl:when test="$trimmedCode='gem'">Germanische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='gez'">Altäthiopisch</xsl:when>
            <xsl:when test="$trimmedCode='gil'">Gilbertesisch</xsl:when>
            <xsl:when test="$trimmedCode='gl'">Galicisch</xsl:when>
            <xsl:when test="$trimmedCode='gmh'">Mittelhochdeutsch</xsl:when>
            <xsl:when test="$trimmedCode='gn'">Guaraní-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='goh'">Althochdeutsch</xsl:when>
            <xsl:when test="$trimmedCode='gon'">Gondi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='gor'">Gorontalesisch</xsl:when>
            <xsl:when test="$trimmedCode='got'">Gotisch</xsl:when>
            <xsl:when test="$trimmedCode='grb'">Grebo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='grc'">Griechisch</xsl:when>
            <xsl:when test="$trimmedCode='gsw'">Schweizerdeutsch</xsl:when>
            <xsl:when test="$trimmedCode='gu'">Gujarati-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='gv'">Manx</xsl:when>
            <xsl:when test="$trimmedCode='gwi'">Kutchin-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ha'">Haussa-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='hai'">Haida-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='haw'">Hawaiisch</xsl:when>
            <xsl:when test="$trimmedCode='he'">Hebräisch</xsl:when>
            <xsl:when test="$trimmedCode='hi'">Hindi</xsl:when>
            <xsl:when test="$trimmedCode='hil'">Hiligaynon-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='him'">Himachali</xsl:when>
            <xsl:when test="$trimmedCode='hit'">Hethitisch</xsl:when>
            <xsl:when test="$trimmedCode='hmn'">Miao-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='ho'">Hiri-Motu</xsl:when>
            <xsl:when test="$trimmedCode='hr'">Kroatisch</xsl:when>
            <xsl:when test="$trimmedCode='hsb'">Obersorbisch</xsl:when>
            <xsl:when test="$trimmedCode='ht'">Haïtien (Haiti-Kreolisch)</xsl:when>
            <xsl:when test="$trimmedCode='hu'">Ungarisch</xsl:when>
            <xsl:when test="$trimmedCode='hup'">Hupa-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='hy'">Armenisch</xsl:when>
            <xsl:when test="$trimmedCode='hz'">Herero-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ia'">Interlingua</xsl:when>
            <xsl:when test="$trimmedCode='iba'">Iban-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='id'">Bahasa Indonesia</xsl:when>
            <xsl:when test="$trimmedCode='ie'">Interlingue</xsl:when>
            <xsl:when test="$trimmedCode='ig'">Ibo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ii'">Lalo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ijo'">Ijo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ik'">Inupik</xsl:when>
            <xsl:when test="$trimmedCode='ilo'">Ilokano-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='inc'">Indoarische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='ine'">Indogermanische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='inh'">Inguschisch</xsl:when>
            <xsl:when test="$trimmedCode='io'">Ido</xsl:when>
            <xsl:when test="$trimmedCode='ira'">Iranische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='iro'">Irokesische Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='is'">Isländisch</xsl:when>
            <xsl:when test="$trimmedCode='it'">Italienisch</xsl:when>
            <xsl:when test="$trimmedCode='iu'">Inuktitut</xsl:when>
            <xsl:when test="$trimmedCode='ja'">Japanisch</xsl:when>
            <xsl:when test="$trimmedCode='jbo'">Lojban</xsl:when>
            <xsl:when test="$trimmedCode='jpr'">Jüdisch-Persisch</xsl:when>
            <xsl:when test="$trimmedCode='jrb'">Jüdisch-Arabisch</xsl:when>
            <xsl:when test="$trimmedCode='jv'">Javanisch</xsl:when>
            <xsl:when test="$trimmedCode='ka'">Georgisch</xsl:when>
            <xsl:when test="$trimmedCode='kaa'">Karakalpakisch</xsl:when>
            <xsl:when test="$trimmedCode='kab'">Kabylisch</xsl:when>
            <xsl:when test="$trimmedCode='kac'">Kachin-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='kam'">Kamba-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='kar'">Karenisch</xsl:when>
            <xsl:when test="$trimmedCode='kaw'">Kawi</xsl:when>
            <xsl:when test="$trimmedCode='kbd'">Kabardinisch</xsl:when>
            <xsl:when test="$trimmedCode='kg'">Kongo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='kha'">Khasi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='khi'">Khoisan-Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='kho'">Sakisch</xsl:when>
            <xsl:when test="$trimmedCode='ki'">Kikuyu-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='kj'">Kwanyama-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='kk'">Kasachisch</xsl:when>
            <xsl:when test="$trimmedCode='kl'">Grönländisch</xsl:when>
            <xsl:when test="$trimmedCode='km'">Kambodschanisch</xsl:when>
            <xsl:when test="$trimmedCode='kmb'">Kimbundu-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='kn'">Kannada</xsl:when>
            <xsl:when test="$trimmedCode='ko'">Koreanisch</xsl:when>
            <xsl:when test="$trimmedCode='kok'">Konkani</xsl:when>
            <xsl:when test="$trimmedCode='kos'">Kosraeanisch</xsl:when>
            <xsl:when test="$trimmedCode='kpe'">Kpelle-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='kr'">Kanuri-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='krc'">Karatschaiisch-Balkarisch</xsl:when>
            <xsl:when test="$trimmedCode='krl'">Karelisch</xsl:when>
            <xsl:when test="$trimmedCode='kro'">Kru-Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='kru'">Oraon-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ks'">Kaschmiri</xsl:when>
            <xsl:when test="$trimmedCode='ku'">Kurdisch</xsl:when>
            <xsl:when test="$trimmedCode='kum'">Kumükisch</xsl:when>
            <xsl:when test="$trimmedCode='kut'">Kutenai-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='kv'">Komi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='kw'">Kornisch</xsl:when>
            <xsl:when test="$trimmedCode='ky'">Kirgisisch</xsl:when>
            <xsl:when test="$trimmedCode='la'">Latein</xsl:when>
            <xsl:when test="$trimmedCode='lad'">Judenspanisch</xsl:when>
            <xsl:when test="$trimmedCode='lah'">Lahnda</xsl:when>
            <xsl:when test="$trimmedCode='lam'">Lamba-Sprache (Bantusprache)</xsl:when>
            <xsl:when test="$trimmedCode='lb'">Luxemburgisch</xsl:when>
            <xsl:when test="$trimmedCode='lez'">Lesgisch</xsl:when>
            <xsl:when test="$trimmedCode='lg'">Ganda-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='li'">Limburgisch</xsl:when>
            <xsl:when test="$trimmedCode='ln'">Lingala</xsl:when>
            <xsl:when test="$trimmedCode='lo'">Laotisch</xsl:when>
            <xsl:when test="$trimmedCode='lol'">Mongo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='loz'">Rotse-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='lt'">Litauisch</xsl:when>
            <xsl:when test="$trimmedCode='lu'">Luba-Katanga-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='lua'">Lulua-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='lui'">Luiseño-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='lun'">Lunda-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='luo'">Luo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='lus'">Lushai-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='lv'">Lettisch</xsl:when>
            <xsl:when test="$trimmedCode='mad'">Maduresisch</xsl:when>
            <xsl:when test="$trimmedCode='mag'">Khotta</xsl:when>
            <xsl:when test="$trimmedCode='mai'">Maithili</xsl:when>
            <xsl:when test="$trimmedCode='mak'">Makassarisch</xsl:when>
            <xsl:when test="$trimmedCode='man'">Malinke-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='map'">Austronesische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='mas'">Massai-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='mdf'">Mokscha-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='mdr'">Mandaresisch</xsl:when>
            <xsl:when test="$trimmedCode='men'">Mende-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='mg'">Malagassi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='mga'">Mittelirisch</xsl:when>
            <xsl:when test="$trimmedCode='mh'">Marschallesisch</xsl:when>
            <xsl:when test="$trimmedCode='mi'">Maori-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='mic'">Micmac-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='min'">Minangkabau-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='mis'">Einzelne andere Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='mk'">Makedonisch</xsl:when>
            <xsl:when test="$trimmedCode='mkh'">Mon-Khmer-Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='ml'">Malayalam</xsl:when>
            <xsl:when test="$trimmedCode='mn'">Mongolisch</xsl:when>
            <xsl:when test="$trimmedCode='mnc'">Mandschurisch</xsl:when>
            <xsl:when test="$trimmedCode='mni'">Meithei-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='mno'">Manobo-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='moh'">Mohawk-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='mos'">Mossi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='mr'">Marathi</xsl:when>
            <xsl:when test="$trimmedCode='ms'">Malaiisch</xsl:when>
            <xsl:when test="$trimmedCode='mt'">Maltesisch</xsl:when>
            <xsl:when test="$trimmedCode='mul'">Mehrere Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='mun'">Mundasprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='mus'">Muskogisch</xsl:when>
            <xsl:when test="$trimmedCode='mwl'">Mirandesisch</xsl:when>
            <xsl:when test="$trimmedCode='mwr'">Marwari</xsl:when>
            <xsl:when test="$trimmedCode='my'">Birmanisch</xsl:when>
            <xsl:when test="$trimmedCode='myn'">Maya-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='myv'">Erza-Mordwinisch</xsl:when>
            <xsl:when test="$trimmedCode='na'">Nauruanisch</xsl:when>
            <xsl:when test="$trimmedCode='nah'">Nahuatl</xsl:when>
            <xsl:when test="$trimmedCode='nai'">Indianersprachen, Nordamerika (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='nap'">Neapel / Mundart</xsl:when>
            <xsl:when test="$trimmedCode='nb'">Bokmål</xsl:when>
            <xsl:when test="$trimmedCode='nd'">Ndebele-Sprache (Simbabwe)</xsl:when>
            <xsl:when test="$trimmedCode='nds'">Niederdeutsch</xsl:when>
            <xsl:when test="$trimmedCode='ne'">Nepali</xsl:when>
            <xsl:when test="$trimmedCode='new'">Newari</xsl:when>
            <xsl:when test="$trimmedCode='ng'">Ndonga</xsl:when>
            <xsl:when test="$trimmedCode='nia'">Nias-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='nic'">Nigerkordofanische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='niu'">Niue-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='nl'">Niederländisch</xsl:when>
            <xsl:when test="$trimmedCode='nn'">Nynorsk</xsl:when>
            <xsl:when test="$trimmedCode='no'">Norwegisch</xsl:when>
            <xsl:when test="$trimmedCode='nog'">Nogaisch</xsl:when>
            <xsl:when test="$trimmedCode='non'">Altnorwegisch</xsl:when>
            <xsl:when test="$trimmedCode='nqo'">N'Ko</xsl:when>
            <xsl:when test="$trimmedCode='nr'">Ndebele-Sprache (Transvaal)</xsl:when>
            <xsl:when test="$trimmedCode='nso'">Pedi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='nub'">Nubische Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='nv'">Navajo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='nwc'">Alt-Newari</xsl:when>
            <xsl:when test="$trimmedCode='ny'">Nyanja-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='nym'">Nyamwezi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='nyn'">Nkole-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='nyo'">Nyoro-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='nzi'">Nzima-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='oc'">Okzitanisch</xsl:when>
            <xsl:when test="$trimmedCode='oj'">Ojibwa-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='om'">Galla-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='or'">Oriya-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='os'">Ossetisch</xsl:when>
            <xsl:when test="$trimmedCode='osa'">Osage-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ota'">Osmanisch</xsl:when>
            <xsl:when test="$trimmedCode='oto'">Otomangue-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='pa'">Pandschabi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='paa'">Papuasprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='pag'">Pangasinan-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='pal'">Mittelpersisch</xsl:when>
            <xsl:when test="$trimmedCode='pam'">Pampanggan-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='pap'">Papiamento</xsl:when>
            <xsl:when test="$trimmedCode='pau'">Palau-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='peo'">Altpersisch</xsl:when>
            <xsl:when test="$trimmedCode='phi'">Philippinisch-Austronesisch (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='phn'">Phönikisch</xsl:when>
            <xsl:when test="$trimmedCode='pi'">Pali</xsl:when>
            <xsl:when test="$trimmedCode='pl'">Polnisch</xsl:when>
            <xsl:when test="$trimmedCode='pon'">Ponapeanisch</xsl:when>
            <xsl:when test="$trimmedCode='pra'">Prakrit</xsl:when>
            <xsl:when test="$trimmedCode='pro'">Altokzitanisch</xsl:when>
            <xsl:when test="$trimmedCode='ps'">Paschtu</xsl:when>
            <xsl:when test="$trimmedCode='pt'">Portugiesisch</xsl:when>
            <xsl:when test="$trimmedCode='qaa'">Reserviert für lokale Verwendung</xsl:when>
            <xsl:when test="$trimmedCode='qu'">Quechua-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='raj'">Rajasthani</xsl:when>
            <xsl:when test="$trimmedCode='rap'">Osterinsel-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='rar'">Rarotonganisch</xsl:when>
            <xsl:when test="$trimmedCode='rm'">Rätoromanisch</xsl:when>
            <xsl:when test="$trimmedCode='rn'">Rundi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ro'">Rumänisch</xsl:when>
            <xsl:when test="$trimmedCode='roa'">Romanische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='rom'">Romani (Sprache)</xsl:when>
            <xsl:when test="$trimmedCode='ru'">Russisch</xsl:when>
            <xsl:when test="$trimmedCode='rup'">Aromunisch</xsl:when>
            <xsl:when test="$trimmedCode='rw'">Rwanda-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='sa'">Sanskrit</xsl:when>
            <xsl:when test="$trimmedCode='sad'">Sandawe-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='sah'">Jakutisch</xsl:when>
            <xsl:when test="$trimmedCode='sai'">Indianersprachen, Südamerika (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='sal'">Salish-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='sam'">Samaritanisch</xsl:when>
            <xsl:when test="$trimmedCode='sas'">Sasak</xsl:when>
            <xsl:when test="$trimmedCode='sat'">Santali</xsl:when>
            <xsl:when test="$trimmedCode='sc'">Sardisch</xsl:when>
            <xsl:when test="$trimmedCode='scn'">Sizilianisch</xsl:when>
            <xsl:when test="$trimmedCode='sco'">Schottisch</xsl:when>
            <xsl:when test="$trimmedCode='sd'">Sindhi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='se'">Nordsaamisch</xsl:when>
            <xsl:when test="$trimmedCode='sel'">Selkupisch</xsl:when>
            <xsl:when test="$trimmedCode='sem'">Semitische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='sg'">Sango-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='sga'">Altirisch</xsl:when>
            <xsl:when test="$trimmedCode='sgn'">Zeichensprachen</xsl:when>
            <xsl:when test="$trimmedCode='shn'">Schan-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='si'">Singhalesisch</xsl:when>
            <xsl:when test="$trimmedCode='sid'">Sidamo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='sio'">Sioux-Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='sit'">Sinotibetische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='sk'">Slowakisch</xsl:when>
            <xsl:when test="$trimmedCode='sl'">Slowenisch</xsl:when>
            <xsl:when test="$trimmedCode='sla'">Slawische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='sm'">Samoanisch</xsl:when>
            <xsl:when test="$trimmedCode='sma'">Südsaamisch</xsl:when>
            <xsl:when test="$trimmedCode='smi'">Saamisch</xsl:when>
            <xsl:when test="$trimmedCode='smj'">Lulesaamisch</xsl:when>
            <xsl:when test="$trimmedCode='smn'">Inarisaamisch</xsl:when>
            <xsl:when test="$trimmedCode='sms'">Skoltsaamisch</xsl:when>
            <xsl:when test="$trimmedCode='sn'">Schona-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='snk'">Soninke-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='so'">Somali</xsl:when>
            <xsl:when test="$trimmedCode='sog'">Sogdisch</xsl:when>
            <xsl:when test="$trimmedCode='son'">Songhai-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='sq'">Albanisch</xsl:when>
            <xsl:when test="$trimmedCode='sr'">Serbisch</xsl:when>
            <xsl:when test="$trimmedCode='srn'">Sranantongo</xsl:when>
            <xsl:when test="$trimmedCode='srr'">Serer-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ss'">Swasi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ssa'">Nilosaharanische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='st'">Süd-Sotho-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='su'">Sundanesisch</xsl:when>
            <xsl:when test="$trimmedCode='suk'">Sukuma-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='sus'">Susu</xsl:when>
            <xsl:when test="$trimmedCode='sux'">Sumerisch</xsl:when>
            <xsl:when test="$trimmedCode='sv'">Schwedisch</xsl:when>
            <xsl:when test="$trimmedCode='sw'">Swahili</xsl:when>
            <xsl:when test="$trimmedCode='syc'">Syrisch</xsl:when>
            <xsl:when test="$trimmedCode='syr'">Neuostaramäisch</xsl:when>
            <xsl:when test="$trimmedCode='ta'">Tamil</xsl:when>
            <xsl:when test="$trimmedCode='tai'">Thaisprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='te'">Telugu-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='tem'">Temne-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ter'">Tereno-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='tet'">Tetum-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='tg'">Tadschikisch</xsl:when>
            <xsl:when test="$trimmedCode='th'">Thailändisch</xsl:when>
            <xsl:when test="$trimmedCode='ti'">Tigrinja-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='tig'">Tigre-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='tiv'">Tiv-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='tk'">Turkmenisch</xsl:when>
            <xsl:when test="$trimmedCode='tkl'">Tokelauanisch</xsl:when>
            <xsl:when test="$trimmedCode='tl'">Tagalog</xsl:when>
            <xsl:when test="$trimmedCode='tlh'">Klingonisch</xsl:when>
            <xsl:when test="$trimmedCode='tli'">Tlingit-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='tmh'">Tamaeq</xsl:when>
            <xsl:when test="$trimmedCode='tn'">Tswana-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='to'">Tongaisch</xsl:when>
            <xsl:when test="$trimmedCode='tog'">Tonga (Bantusprache, Sambia)</xsl:when>
            <xsl:when test="$trimmedCode='tpi'">Neumelanesisch</xsl:when>
            <xsl:when test="$trimmedCode='tr'">Türkisch</xsl:when>
            <xsl:when test="$trimmedCode='ts'">Tsonga-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='tsi'">Tsimshian-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='tt'">Tatarisch</xsl:when>
            <xsl:when test="$trimmedCode='tum'">Tumbuka-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='tup'">Tupi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='tut'">Altaische Sprachen (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='tvl'">Elliceanisch</xsl:when>
            <xsl:when test="$trimmedCode='tw'">Twi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ty'">Tahitisch</xsl:when>
            <xsl:when test="$trimmedCode='tyv'">Tuwinisch</xsl:when>
            <xsl:when test="$trimmedCode='udm'">Udmurtisch</xsl:when>
            <xsl:when test="$trimmedCode='ug'">Uigurisch</xsl:when>
            <xsl:when test="$trimmedCode='uga'">Ugaritisch</xsl:when>
            <xsl:when test="$trimmedCode='uk'">Ukrainisch</xsl:when>
            <xsl:when test="$trimmedCode='umb'">Mbundu-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='und'">Nicht zu entscheiden</xsl:when>
            <xsl:when test="$trimmedCode='ur'">Urdu</xsl:when>
            <xsl:when test="$trimmedCode='uz'">Usbekisch</xsl:when>
            <xsl:when test="$trimmedCode='vai'">Vai-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ve'">Venda-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='vi'">Vietnamesisch</xsl:when>
            <xsl:when test="$trimmedCode='vo'">Volapük</xsl:when>
            <xsl:when test="$trimmedCode='vot'">Wotisch</xsl:when>
            <xsl:when test="$trimmedCode='wa'">Wallonisch</xsl:when>
            <xsl:when test="$trimmedCode='wak'">Wakash-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='wal'">Walamo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='war'">Waray</xsl:when>
            <xsl:when test="$trimmedCode='was'">Washo-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='wen'">Sorbisch (Andere)</xsl:when>
            <xsl:when test="$trimmedCode='wo'">Wolof-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='xal'">Kalmückisch</xsl:when>
            <xsl:when test="$trimmedCode='xh'">Xhosa-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='yao'">Yao-Sprache (Bantusprache)</xsl:when>
            <xsl:when test="$trimmedCode='yap'">Yapesisch</xsl:when>
            <xsl:when test="$trimmedCode='yi'">Jiddisch</xsl:when>
            <xsl:when test="$trimmedCode='yo'">Yoruba-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='ypk'">Ypik-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='za'">Zhuang</xsl:when>
            <xsl:when test="$trimmedCode='zap'">Zapotekisch</xsl:when>
            <xsl:when test="$trimmedCode='zbl'">Bliss-Symbol</xsl:when>
            <xsl:when test="$trimmedCode='zen'">Zenaga</xsl:when>
            <xsl:when test="$trimmedCode='zgh'">Tamazight</xsl:when>
            <xsl:when test="$trimmedCode='zh'">Chinesisch</xsl:when>
            <xsl:when test="$trimmedCode='znd'">Zande-Sprachen</xsl:when>
            <xsl:when test="$trimmedCode='zu'">Zulu-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='zun'">Zuñi-Sprache</xsl:when>
            <xsl:when test="$trimmedCode='zxx'">Kein linguistischer Inhalt</xsl:when>
            <xsl:when test="$trimmedCode='zza'">Zazaki</xsl:when>
            <xsl:otherwise>unbekannter Code (<xsl:value-of select="$trimmedCode" />)</xsl:otherwise>
        
        </xsl:choose>
    
    </xsl:template>
    



    <!-- AUTO GENERATED TEMPLATE. DO NOT MODIFY! -->
    
    <xsl:template name="getCountryMapping">
        <xsl:param name="country" />
        
        <xsl:choose>
            <xsl:when test="$country='ABW'">Aruba</xsl:when>
            <xsl:when test="$country='AFG'">Afghanistan</xsl:when>
            <xsl:when test="$country='AGO'">Angola</xsl:when>
            <xsl:when test="$country='AIA'">Anguilla</xsl:when>
            <xsl:when test="$country='ALA'">Åland</xsl:when>
            <xsl:when test="$country='ALB'">Albanien</xsl:when>
            <xsl:when test="$country='AND'">Andorra</xsl:when>
            <xsl:when test="$country='ANT'">Niederländische Antillen</xsl:when>
            <xsl:when test="$country='ARE'">Vereinigte Arabische Emirate</xsl:when>
            <xsl:when test="$country='ARG'">Argentinien</xsl:when>
            <xsl:when test="$country='ARM'">Armenien</xsl:when>
            <xsl:when test="$country='ASC'">Ascension (verwaltet von St. Helena)</xsl:when>
            <xsl:when test="$country='ASM'">Amerikanisch-Samoa</xsl:when>
            <xsl:when test="$country='ATA'">Antarktis (Sonderstatus durch Antarktis-Vertrag)</xsl:when>
            <xsl:when test="$country='ATF'">Französische Süd- und Antarktisgebiete</xsl:when>
            <xsl:when test="$country='ATG'">Antigua und Barbuda</xsl:when>
            <xsl:when test="$country='AUS'">Australien</xsl:when>
            <xsl:when test="$country='AUT'">Österreich</xsl:when>
            <xsl:when test="$country='AZE'">Aserbaidschan</xsl:when>
            <xsl:when test="$country='BDI'">Burundi</xsl:when>
            <xsl:when test="$country='BEL'">Belgien</xsl:when>
            <xsl:when test="$country='BEN'">Benin</xsl:when>
            <xsl:when test="$country='BES'">Bonaire, Sint Eustatius und Saba (Niederlande</xsl:when>
            <xsl:when test="$country='BFA'">Burkina Faso</xsl:when>
            <xsl:when test="$country='BGD'">Bangladesch</xsl:when>
            <xsl:when test="$country='BGR'">Bulgarien</xsl:when>
            <xsl:when test="$country='BHR'">Bahrain</xsl:when>
            <xsl:when test="$country='BHS'">Bahamas</xsl:when>
            <xsl:when test="$country='BIH'">Bosnien und Herzegowina</xsl:when>
            <xsl:when test="$country='BLM'">Saint-Barthélemy</xsl:when>
            <xsl:when test="$country='BLR'">Belarus (Weißrussland)</xsl:when>
            <xsl:when test="$country='BLZ'">Belize</xsl:when>
            <xsl:when test="$country='BMU'">Bermuda</xsl:when>
            <xsl:when test="$country='BOL'">Bolivien</xsl:when>
            <xsl:when test="$country='BRA'">Brasilien</xsl:when>
            <xsl:when test="$country='BRB'">Barbados</xsl:when>
            <xsl:when test="$country='BRN'">Brunei Darussalam</xsl:when>
            <xsl:when test="$country='BTN'">Bhutan</xsl:when>
            <xsl:when test="$country='BUR'">Burma (jetzt Myanmar)</xsl:when>
            <xsl:when test="$country='BVT'">Bouvetinsel</xsl:when>
            <xsl:when test="$country='BWA'">Botsuana</xsl:when>
            <xsl:when test="$country='CAF'">Zentralafrikanische Republik</xsl:when>
            <xsl:when test="$country='CAN'">Kanada</xsl:when>
            <xsl:when test="$country='CCK'">Kokosinseln</xsl:when>
            <xsl:when test="$country='CHE'">Schweiz (Confoederatio Helvetica)</xsl:when>
            <xsl:when test="$country='CHL'">Chile</xsl:when>
            <xsl:when test="$country='CHN'">China</xsl:when>
            <xsl:when test="$country='CIV'">Côte dIvoire (Elfenbeinküste)</xsl:when>
            <xsl:when test="$country='CMR'">Kamerun</xsl:when>
            <xsl:when test="$country='COD'">Kongo</xsl:when>
            <xsl:when test="$country='COG'">Republik Kongo</xsl:when>
            <xsl:when test="$country='COK'">Cookinseln</xsl:when>
            <xsl:when test="$country='COL'">Kolumbien</xsl:when>
            <xsl:when test="$country='COM'">Komoren</xsl:when>
            <xsl:when test="$country='CPT'">Clipperton (reserviert für ITU)</xsl:when>
            <xsl:when test="$country='CPV'">Kap Verde</xsl:when>
            <xsl:when test="$country='CRI'">Costa Rica</xsl:when>
            <xsl:when test="$country='CSK'">Tschechoslowakei (ehemalig)</xsl:when>
            <xsl:when test="$country='CUB'">Kuba</xsl:when>
            <xsl:when test="$country='CUW'">Curaçao</xsl:when>
            <xsl:when test="$country='CXR'">Weihnachtsinsel</xsl:when>
            <xsl:when test="$country='CYM'">Kaimaninseln</xsl:when>
            <xsl:when test="$country='CYP'">Zypern</xsl:when>
            <xsl:when test="$country='CZE'">Tschechische Republik</xsl:when>
            <xsl:when test="$country='DEU'">Deutschland</xsl:when>
            <xsl:when test="$country='DGA'">Diego Garcia (reserviert für ITU)</xsl:when>
            <xsl:when test="$country='DJI'">Dschibuti</xsl:when>
            <xsl:when test="$country='DMA'">Dominica</xsl:when>
            <xsl:when test="$country='DNK'">Dänemark</xsl:when>
            <xsl:when test="$country='DOM'">Dominikanische Republik</xsl:when>
            <xsl:when test="$country='DZA'">Algerien</xsl:when>
            <xsl:when test="$country='ECU'">Ecuador</xsl:when>
            <xsl:when test="$country='EGY'">Ägypten</xsl:when>
            <xsl:when test="$country='ERI'">Eritrea</xsl:when>
            <xsl:when test="$country='ESH'">Westsahara</xsl:when>
            <xsl:when test="$country='ESP'">Spanien</xsl:when>
            <xsl:when test="$country='EST'">Estland</xsl:when>
            <xsl:when test="$country='ETH'">Äthiopien</xsl:when>
            <xsl:when test="$country='FIN'">Finnland</xsl:when>
            <xsl:when test="$country='FJI'">Fidschi</xsl:when>
            <xsl:when test="$country='FLK'">Falklandinseln</xsl:when>
            <xsl:when test="$country='FRA'">Frankreich</xsl:when>
            <xsl:when test="$country='FRO'">Färöer</xsl:when>
            <xsl:when test="$country='FSM'">Mikronesien</xsl:when>
            <xsl:when test="$country='FXX'">(europ. Frankreich ohne Übersee-Départements)</xsl:when>
            <xsl:when test="$country='GAB'">Gabun</xsl:when>
            <xsl:when test="$country='GBR'">Vereinigtes Königreich Großbritannien und Nordirland</xsl:when>
            <xsl:when test="$country='GEO'">Georgien</xsl:when>
            <xsl:when test="$country='GGY'">Guernsey (Kanalinsel)</xsl:when>
            <xsl:when test="$country='GHA'">Ghana</xsl:when>
            <xsl:when test="$country='GIB'">Gibraltar</xsl:when>
            <xsl:when test="$country='GIN'">Guinea</xsl:when>
            <xsl:when test="$country='GLP'">Guadeloupe</xsl:when>
            <xsl:when test="$country='GMB'">Gambia</xsl:when>
            <xsl:when test="$country='GNB'">Guinea-Bissau</xsl:when>
            <xsl:when test="$country='GNQ'">Äquatorialguinea</xsl:when>
            <xsl:when test="$country='GRC'">Griechenland</xsl:when>
            <xsl:when test="$country='GRD'">Grenada</xsl:when>
            <xsl:when test="$country='GRL'">Grönland</xsl:when>
            <xsl:when test="$country='GTM'">Guatemala</xsl:when>
            <xsl:when test="$country='GUF'">Französisch-Guayana</xsl:when>
            <xsl:when test="$country='GUM'">Guam</xsl:when>
            <xsl:when test="$country='GUY'">Guyana</xsl:when>
            <xsl:when test="$country='HKG'">Hongkong</xsl:when>
            <xsl:when test="$country='HMD'">Heard- und McDonald-Inseln</xsl:when>
            <xsl:when test="$country='HND'">Honduras</xsl:when>
            <xsl:when test="$country='HRV'">Kroatien</xsl:when>
            <xsl:when test="$country='HTI'">Haiti</xsl:when>
            <xsl:when test="$country='HUN'">Ungarn</xsl:when>
            <xsl:when test="$country='IDN'">Indonesien</xsl:when>
            <xsl:when test="$country='IMN'">Insel Man</xsl:when>
            <xsl:when test="$country='IND'">Indien</xsl:when>
            <xsl:when test="$country='IOT'">Britisches Territorium im Indischen Ozean</xsl:when>
            <xsl:when test="$country='IRL'">Irland</xsl:when>
            <xsl:when test="$country='IRN'">Iran</xsl:when>
            <xsl:when test="$country='IRQ'">Irak</xsl:when>
            <xsl:when test="$country='ISL'">Island</xsl:when>
            <xsl:when test="$country='ISR'">Israel</xsl:when>
            <xsl:when test="$country='ITA'">Italien</xsl:when>
            <xsl:when test="$country='JAM'">Jamaika</xsl:when>
            <xsl:when test="$country='JEY'">Jersey (Kanalinsel)</xsl:when>
            <xsl:when test="$country='JOR'">Jordanien</xsl:when>
            <xsl:when test="$country='JPN'">Japan</xsl:when>
            <xsl:when test="$country='KAZ'">Kasachstan</xsl:when>
            <xsl:when test="$country='KEN'">Kenia</xsl:when>
            <xsl:when test="$country='KGZ'">Kirgisistan</xsl:when>
            <xsl:when test="$country='KHM'">Kambodscha</xsl:when>
            <xsl:when test="$country='KIR'">Kiribati</xsl:when>
            <xsl:when test="$country='KNA'">St. Kitts und Nevis</xsl:when>
            <xsl:when test="$country='KOR'">Korea</xsl:when>
            <xsl:when test="$country='KOS'">Kosovo, Republik</xsl:when>
            <xsl:when test="$country='KWT'">Kuwait</xsl:when>
            <xsl:when test="$country='LAO'">Laos</xsl:when>
            <xsl:when test="$country='LBN'">Libanon</xsl:when>
            <xsl:when test="$country='LBR'">Liberia</xsl:when>
            <xsl:when test="$country='LBY'">Libysch-Arabische Dschamahirija (Libyen)</xsl:when>
            <xsl:when test="$country='LCA'">St. Lucia</xsl:when>
            <xsl:when test="$country='LIE'">Liechtenstein</xsl:when>
            <xsl:when test="$country='LKA'">Sri Lanka</xsl:when>
            <xsl:when test="$country='LSO'">Lesotho</xsl:when>
            <xsl:when test="$country='LTU'">Litauen</xsl:when>
            <xsl:when test="$country='LUX'">Luxemburg</xsl:when>
            <xsl:when test="$country='LVA'">Lettland</xsl:when>
            <xsl:when test="$country='MAC'">Macao</xsl:when>
            <xsl:when test="$country='MAF'">Saint-Martin (franz. Teil)</xsl:when>
            <xsl:when test="$country='MAR'">Marokko</xsl:when>
            <xsl:when test="$country='MCO'">Monaco</xsl:when>
            <xsl:when test="$country='MDA'">Moldawien (Republik Moldau)</xsl:when>
            <xsl:when test="$country='MDG'">Madagaskar</xsl:when>
            <xsl:when test="$country='MDV'">Malediven</xsl:when>
            <xsl:when test="$country='MEX'">Mexiko</xsl:when>
            <xsl:when test="$country='MHL'">Marshallinseln</xsl:when>
            <xsl:when test="$country='MKD'">Mazedonien</xsl:when>
            <xsl:when test="$country='MLI'">Mali</xsl:when>
            <xsl:when test="$country='MLT'">Malta</xsl:when>
            <xsl:when test="$country='MMR'">Myanmar (Burma)</xsl:when>
            <xsl:when test="$country='MNE'">Montenegro</xsl:when>
            <xsl:when test="$country='MNG'">Mongolei</xsl:when>
            <xsl:when test="$country='MNP'">Nördliche Marianen</xsl:when>
            <xsl:when test="$country='MOZ'">Mosambik</xsl:when>
            <xsl:when test="$country='MRT'">Mauretanien</xsl:when>
            <xsl:when test="$country='MSR'">Montserrat</xsl:when>
            <xsl:when test="$country='MTQ'">Martinique</xsl:when>
            <xsl:when test="$country='MUS'">Mauritius</xsl:when>
            <xsl:when test="$country='MWI'">Malawi</xsl:when>
            <xsl:when test="$country='MYS'">Malaysia</xsl:when>
            <xsl:when test="$country='MYT'">Mayotte</xsl:when>
            <xsl:when test="$country='NAM'">Namibia</xsl:when>
            <xsl:when test="$country='NCL'">Neukaledonien</xsl:when>
            <xsl:when test="$country='NER'">Niger</xsl:when>
            <xsl:when test="$country='NFK'">Norfolkinsel</xsl:when>
            <xsl:when test="$country='NGA'">Nigeria</xsl:when>
            <xsl:when test="$country='NIC'">Nicaragua</xsl:when>
            <xsl:when test="$country='NIU'">Niue</xsl:when>
            <xsl:when test="$country='NLD'">Niederlande</xsl:when>
            <xsl:when test="$country='NOR'">Norwegen</xsl:when>
            <xsl:when test="$country='NPL'">Nepal</xsl:when>
            <xsl:when test="$country='NRU'">Nauru</xsl:when>
            <xsl:when test="$country='NTZ'">Neutrale Zone (Saudi-Arabien und Irak)</xsl:when>
            <xsl:when test="$country='NZL'">Neuseeland</xsl:when>
            <xsl:when test="$country='OMN'">Oman</xsl:when>
            <xsl:when test="$country='PAK'">Pakistan</xsl:when>
            <xsl:when test="$country='PAN'">Panama</xsl:when>
            <xsl:when test="$country='PCN'">Pitcairninseln</xsl:when>
            <xsl:when test="$country='PER'">Peru</xsl:when>
            <xsl:when test="$country='PHL'">Philippinen</xsl:when>
            <xsl:when test="$country='PLW'">Palau</xsl:when>
            <xsl:when test="$country='PNG'">Papua-Neuguinea</xsl:when>
            <xsl:when test="$country='POL'">Polen</xsl:when>
            <xsl:when test="$country='PRI'">Puerto Rico</xsl:when>
            <xsl:when test="$country='PRK'">Korea</xsl:when>
            <xsl:when test="$country='PRT'">Portugal</xsl:when>
            <xsl:when test="$country='PRY'">Paraguay</xsl:when>
            <xsl:when test="$country='PSE'">Palästinensische Autonomiegebiete</xsl:when>
            <xsl:when test="$country='PYF'">Französisch-Polynesien</xsl:when>
            <xsl:when test="$country='QAT'">Katar</xsl:when>
            <xsl:when test="$country='REU'">Réunion</xsl:when>
            <xsl:when test="$country='ROU'">Rumänien</xsl:when>
            <xsl:when test="$country='RUS'">Russische Föderation</xsl:when>
            <xsl:when test="$country='RWA'">Ruanda</xsl:when>
            <xsl:when test="$country='SAU'">Saudi-Arabien</xsl:when>
            <xsl:when test="$country='SCG'">Serbien und Montenegro (ehemalig)</xsl:when>
            <xsl:when test="$country='SDN'">Sudan</xsl:when>
            <xsl:when test="$country='SEN'">Senegal</xsl:when>
            <xsl:when test="$country='SGP'">Singapur</xsl:when>
            <xsl:when test="$country='SGS'">Südgeorgien und die Südlichen Sandwichinseln</xsl:when>
            <xsl:when test="$country='SHN'">St. Helena</xsl:when>
            <xsl:when test="$country='SJM'">Svalbard und Jan Mayen</xsl:when>
            <xsl:when test="$country='SLB'">Salomonen</xsl:when>
            <xsl:when test="$country='SLE'">Sierra Leone</xsl:when>
            <xsl:when test="$country='SLV'">El Salvador</xsl:when>
            <xsl:when test="$country='SMR'">San Marino</xsl:when>
            <xsl:when test="$country='SOM'">Somalia</xsl:when>
            <xsl:when test="$country='SPM'">Saint-Pierre und Miquelon</xsl:when>
            <xsl:when test="$country='SRB'">Serbien</xsl:when>
            <xsl:when test="$country='SSD'">Südsudan</xsl:when>
            <xsl:when test="$country='STP'">São Tomé und Príncipe</xsl:when>
            <xsl:when test="$country='SUN'">UdSSR (jetzt: Russische Föderation)</xsl:when>
            <xsl:when test="$country='SUR'">Suriname</xsl:when>
            <xsl:when test="$country='SVK'">Slowakei</xsl:when>
            <xsl:when test="$country='SVN'">Slowenien</xsl:when>
            <xsl:when test="$country='SWE'">Schweden</xsl:when>
            <xsl:when test="$country='SWZ'">Swasiland</xsl:when>
            <xsl:when test="$country='SXM'">Sint Maarten (niederl. Teil)</xsl:when>
            <xsl:when test="$country='SYC'">Seychellen</xsl:when>
            <xsl:when test="$country='SYR'">Syrien</xsl:when>
            <xsl:when test="$country='TAA'">Tristan da Cunha (verwaltet von St. Helena)</xsl:when>
            <xsl:when test="$country='TCA'">Turks- und Caicosinseln</xsl:when>
            <xsl:when test="$country='TCD'">Tschad</xsl:when>
            <xsl:when test="$country='TGO'">Togo</xsl:when>
            <xsl:when test="$country='THA'">Thailand</xsl:when>
            <xsl:when test="$country='TJK'">Tadschikistan</xsl:when>
            <xsl:when test="$country='TKL'">Tokelau</xsl:when>
            <xsl:when test="$country='TKM'">Turkmenistan</xsl:when>
            <xsl:when test="$country='TLS'">Osttimor (Timor-Leste)</xsl:when>
            <xsl:when test="$country='TMP'">Osttimor (alt)</xsl:when>
            <xsl:when test="$country='TON'">Tonga</xsl:when>
            <xsl:when test="$country='TTO'">Trinidad und Tobago</xsl:when>
            <xsl:when test="$country='TUN'">Tunesien</xsl:when>
            <xsl:when test="$country='TUR'">Türkei</xsl:when>
            <xsl:when test="$country='TUV'">Tuvalu</xsl:when>
            <xsl:when test="$country='TWN'">Republik China (Taiwan)</xsl:when>
            <xsl:when test="$country='TZA'">Tansania</xsl:when>
            <xsl:when test="$country='UGA'">Uganda</xsl:when>
            <xsl:when test="$country='UKR'">Ukraine</xsl:when>
            <xsl:when test="$country='UMI'">United States Minor Outlying Islands</xsl:when>
            <xsl:when test="$country='URY'">Uruguay</xsl:when>
            <xsl:when test="$country='USA'">Vereinigte Staaten von Amerika</xsl:when>
            <xsl:when test="$country='UZB'">Usbekistan</xsl:when>
            <xsl:when test="$country='VAT'">Vatikanstadt</xsl:when>
            <xsl:when test="$country='VCT'">St. Vincent und die Grenadinen</xsl:when>
            <xsl:when test="$country='VEN'">Venezuela</xsl:when>
            <xsl:when test="$country='VGB'">Britische Jungferninseln</xsl:when>
            <xsl:when test="$country='VIR'">Amerikanische Jungferninseln</xsl:when>
            <xsl:when test="$country='VNM'">Vietnam</xsl:when>
            <xsl:when test="$country='VUT'">Vanuatu</xsl:when>
            <xsl:when test="$country='WLF'">Wallis und Futuna</xsl:when>
            <xsl:when test="$country='WSM'">Samoa</xsl:when>
            <xsl:when test="$country='XKS'">Kosovo</xsl:when>
            <xsl:when test="$country='XXA'">Staatenlos</xsl:when>
            <xsl:when test="$country='XXB'">Flüchtling gemäß Genfer Flüchtlingskonvention (GFK) von 1951</xsl:when>
            <xsl:when test="$country='XXC'">Anderer Flüchtling</xsl:when>
            <xsl:when test="$country='XXX'">Unbekannt</xsl:when>
            <xsl:when test="$country='YEM'">Jemen</xsl:when>
            <xsl:when test="$country='YUG'">Jugoslawien (ehemalig)</xsl:when>
            <xsl:when test="$country='ZAF'">Südafrika</xsl:when>
            <xsl:when test="$country='ZAR'">Zaire (jetzt Demokratische Republik Kongo)</xsl:when>
            <xsl:when test="$country='ZMB'">Sambia</xsl:when>
            <xsl:when test="$country='ZWE'">Simbabwe</xsl:when>
            <xsl:otherwise><xsl:value-of select="$country" /></xsl:otherwise>
        
        </xsl:choose>
    
    </xsl:template>
    


  <!--  Bottomline (additional information to the document)  -->
  <xsl:template name="bottomline">

<!-- responsible contact (Fachlicher Ansprechpartner) -->
<xsl:if test="//n1:ClinicalDocument/n1:participant[@typeCode = 'CALLBCK']">
    <div class="authenticatorContainer">
        <div class="collapseTrigger" onclick="toggleCollapseable(this);" id="IDResponsibleContact">
            <div class="authenticatorTitle">
                <xsl:call-template name="participantIdentification">
                    <xsl:with-param name="typecode" select="CALLBCK"/>
                    <xsl:with-param name="functioncode" select="//n1:ClinicalDocument/n1:participant[@typeCode = 'CALLBCK']/n1:functionCode/@code"/>
                    <xsl:with-param name="classcode" select="//n1:ClinicalDocument/n1:participant[@typeCode = 'CALLBCK']/n1:associatedEntity/@classCode"/>
                    <xsl:with-param name="participant" select="//n1:ClinicalDocument/n1:participant[@typeCode = 'CALLBCK']" />
                </xsl:call-template>
            </div>
            <div class="authenticatorShortInfo">
                <p class="name">
                    <xsl:call-template name="getName">
                        <xsl:with-param name="name" select="//n1:ClinicalDocument/n1:participant[@typeCode = 'CALLBCK']/n1:associatedEntity/n1:associatedPerson/n1:name"/>
                    </xsl:call-template>
                </p>
                <p class="name">
                <xsl:call-template name="getContactInfo">
                    <xsl:with-param name="contact" select="//n1:ClinicalDocument/n1:participant[@typeCode = 'CALLBCK']/n1:associatedEntity"/>
                </xsl:call-template>
                </p>
            </div>
            <xsl:call-template name="collapseTrigger"/>
            <div class="clearer" />
        </div>
        <div class="collapsable">
            <div class="leftsmall">
                <p class="name">
                    <xsl:call-template name="getName">
                        <xsl:with-param name="name" select="//n1:ClinicalDocument/n1:participant[@typeCode = 'CALLBCK']/n1:associatedEntity/n1:associatedPerson/n1:name"/>
                        <xsl:with-param name="printNameBold" select="string(true())" />
                    </xsl:call-template>
                </p>
                <xsl:call-template name="getContactInfo">
                    <xsl:with-param name="contact" select="//n1:ClinicalDocument/n1:participant[@typeCode = 'CALLBCK']/n1:associatedEntity"/>
                </xsl:call-template>
            </div>
            <div class="leftwide">
                <xsl:call-template name="getOrganization">
                    <xsl:with-param name="organization" select="//n1:ClinicalDocument/n1:participant[@typeCode = 'CALLBCK']/n1:associatedEntity/n1:scopingOrganization"/>
                </xsl:call-template>
            </div>
            <div class="clearer" />
        </div>
    </div>
</xsl:if>

<xsl:call-template name="renderAuthenticatorContainer" />

  <!--
  additional information about the document
  -->
  <div class="bottomline">
    <div class="collapseTrigger" onclick="toggleCollapseable(this);" id="IDBottomline">
      <h1 class="documentMetaTitle">
        <b>
          <xsl:text>Zusätzliche Informationen über dieses Dokument</xsl:text>
        </b>
      </h1>
      <xsl:call-template name="collapseTrigger"/>
      <div class="clearer" />
    </div>
    <div class="bottomline_data collapsable">
      <xsl:for-each select="/n1:ClinicalDocument/n1:author">
        <div class="element" onclick="toggleCollapseable(this);">
        <div class="bottomlineCollapseable">
          <div class="leftsmall">
            <h2>
              <xsl:choose>
                <xsl:when test="n1:assignedAuthor/n1:assignedAuthoringDevice/n1:manufacturerModelName or
                  n1:assignedAuthor/n1:assignedAuthoringDevice/n1:softwareName">
                  <xsl:text>Erzeugt mit:</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>Dokumentverfasser(in)</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </h2>
            <p class="date">
              <xsl:call-template name="formatDate">
                <xsl:with-param name="date" select="n1:time"/>
              </xsl:call-template>
            </p>
          </div>
          <div class="leftwide">
            <p class="organisationName">
              <xsl:if test="n1:assignedAuthor/n1:assignedPerson/n1:name">
                <xsl:call-template name="getName">
                  <xsl:with-param name="name" select="n1:assignedAuthor/n1:assignedPerson/n1:name"/>
                </xsl:call-template>
              </xsl:if>
            </p>

            <xsl:if test="n1:functionCode or n1:assignedAuthor/n1:code">
              <p class="telecom">
                <xsl:call-template name="getELGAAuthorSpeciality">
                  <xsl:with-param name="code" select="n1:assignedAuthor/n1:code/@code"/>
                </xsl:call-template>
                <xsl:if test="n1:functionCode/@displayName">
                  <xsl:text> (</xsl:text>
                  <xsl:value-of select="n1:functionCode/@displayName" />
                  <xsl:text>)</xsl:text>
                </xsl:if>
              </p>
            </xsl:if>
            
            <xsl:if test="n1:assignedAuthor/n1:telecom">
              <xsl:call-template name="getContactInfo">
                <xsl:with-param name="contact" select="n1:assignedAuthor"/>
              </xsl:call-template>
            </xsl:if>
            
            <xsl:if test="n1:assignedAuthor/n1:assignedAuthoringDevice/n1:manufacturerModelName">
              <p class="organisationName">
                Hersteller/Gerät: <xsl:value-of select="n1:assignedAuthor/n1:assignedAuthoringDevice/n1:manufacturerModelName"/>
              </p>
            </xsl:if>
            
            <xsl:if test="n1:assignedAuthor/n1:assignedAuthoringDevice/n1:softwareName">
              <p class="organisationName">
                Software: <xsl:value-of select="n1:assignedAuthor/n1:assignedAuthoringDevice/n1:softwareName"/>
              </p>
            </xsl:if>            
            
            <p class="organisationName">
              <xsl:call-template name="getName">
                <xsl:with-param name="name" select="n1:assignedAuthor/n1:representedOrganization/n1:name"/>
              </xsl:call-template>
            </p>
            <xsl:call-template name="getContactInfo">
              <xsl:with-param name="contact" select="n1:assignedAuthor/n1:representedOrganization"/>
            </xsl:call-template>
          </div>
          <xsl:call-template name="collapseTrigger"/>
        </div>
        <div class="clearer" />
        </div>
      </xsl:for-each>
      <xsl:for-each select="/n1:ClinicalDocument/n1:informant">
        <div class="element" onclick="toggleCollapseable(this);">
        <div class="bottomlineCollapseable">
          <xsl:call-template name="collapseTrigger"/>
          <div class="leftsmall">
            <h2><xsl:text>Informiert</xsl:text></h2>
          </div>
          <div class="leftwide">
            <xsl:if test="n1:assignedEntity/n1:assignedPerson|n1:relatedEntity/n1:relatedPerson">
              <p class="organisationName">
              <xsl:call-template name="getName">
                <xsl:with-param name="name" select="n1:assignedEntity/n1:assignedPerson/n1:name|n1:relatedEntity/n1:relatedPerson/n1:name"/>
              </xsl:call-template>
              <xsl:if test="n1:relatedEntity/n1:code">
                <xsl:text> (</xsl:text>
                <xsl:call-template name="translateCode">
                  <xsl:with-param name="code" select="n1:relatedEntity/n1:code"/>
                </xsl:call-template>
                <xsl:text>)</xsl:text>
              </xsl:if>
              </p>
            </xsl:if>
            <xsl:call-template name="getContactInfo">
              <xsl:with-param name="contact" select="n1:assignedEntity|n1:relatedEntity"/>
            </xsl:call-template>
          </div>
        </div>
        <div class="clearer"></div>
        </div>
      </xsl:for-each>

      <xsl:for-each select="/n1:ClinicalDocument/n1:dataEnterer">
        <div class="element" onclick="toggleCollapseable(this);">
        <div class="bottomlineCollapseable">
          <xsl:call-template name="collapseTrigger"/>
          <div class="leftsmall">
            <h2><xsl:text>Eingegeben von</xsl:text></h2>
            <p class="date">
              <xsl:call-template name="formatDate">
                <xsl:with-param name="date" select="n1:time"/>
              </xsl:call-template>
            </p>
          </div>
          <div class="leftwide">
            <p class="organisationName">
              <xsl:call-template name="getName">
                <xsl:with-param name="name" select="n1:assignedEntity/n1:assignedPerson/n1:name"/>
              </xsl:call-template>
            </p>
            <xsl:call-template name="getContactInfo">
              <xsl:with-param name="contact" select="n1:assignedEntity"/>
            </xsl:call-template>
            <xsl:if test="n1:assignedEntity/n1:representedOrganization">
            <xsl:call-template name="getOrganization">
              <xsl:with-param name="organization" select="n1:assignedEntity/n1:representedOrganization"/>
            </xsl:call-template>
            </xsl:if>
          </div>
        </div>
        <div class="clearer"></div>
        </div>
      </xsl:for-each>
      <xsl:for-each select="/n1:ClinicalDocument/n1:informationRecipient">
        <div class="element" onclick="toggleCollapseable(this);">
        <div class="bottomlineCollapseable">
          <xsl:call-template name="collapseTrigger"/>
          <div class="leftsmall">
            <h2>
              <xsl:choose>
                <xsl:when test="@typeCode = 'PRCP'">
                  <xsl:text>Empfänger</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>Kopie an</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </h2>
          </div>
          <div class="leftwide">
            <p class="organisationName">
            <xsl:if test="n1:intendedRecipient/n1:informationRecipient">
              <xsl:call-template name="getName">
                <xsl:with-param name="name" select="n1:intendedRecipient/n1:informationRecipient/n1:name"/>
              </xsl:call-template>
              <xsl:if test="n1:intendedRecipient/n1:receivedOrganization">
                <br/>
                <xsl:value-of select="n1:intendedRecipient/n1:receivedOrganization/n1:name"/>
              </xsl:if>
            </xsl:if>
            </p>
            <xsl:call-template name="getContactInfo">
              <xsl:with-param name="contact" select="n1:intendedRecipient/n1:receivedOrganization"/>
            </xsl:call-template>
          </div>
        </div>
        <div class="clearer"></div>
        </div>
      </xsl:for-each>

      <xsl:for-each select="/n1:ClinicalDocument/n1:participant">
        <!-- do not show signee and responsible contact again -->
        <xsl:if test="not(@typeCode = 'CALLBCK' and not(n1:functionCode/@code) and n1:associatedEntity/@classCode= 'PROV') ">

          <!-- do not show referrer again, when data is already shown in fulfillment container -->
          <xsl:if test="not(@typeCode= 'REF' and //n1:ClinicalDocument/n1:inFulfillmentOf)">
            <xsl:variable name="showFunctionCode">
              <xsl:if test="@typeCode = 'CON' and n1:associatedEntity/@classCode= 'PROV'">
                <!-- different layout for "weitere behandler" -->
                <xsl:value-of select="1" />
              </xsl:if>
            </xsl:variable>

            <xsl:call-template name="bottomlineElement" >
              <xsl:with-param name="participant" select="." />
              <xsl:with-param name="showFunctionCode" select="$showFunctionCode" />
            </xsl:call-template>
            </xsl:if>
        </xsl:if>
      </xsl:for-each>

      <div class="element" onclick="toggleCollapseable(this);">
      <div class="bottomlineCollapseable">
          <xsl:call-template name="collapseTrigger"/>
          <div class="leftsmall">
              <h2><xsl:text>Verwahrer des Dokuments</xsl:text></h2>
          </div>
          <div class="leftwide">
            <p class="organisationName">
              <xsl:call-template name="getName">
                <xsl:with-param name="name" select="/n1:ClinicalDocument/n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name"/>
              </xsl:call-template>
            </p>
            <xsl:call-template name="getContactInfo">
              <xsl:with-param name="contact" select="/n1:ClinicalDocument/n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization"/>
            </xsl:call-template>
          </div>
      </div>
      <div class="clearer"></div>
      </div>
      
      
      <xsl:if test="//n1:ClinicalDocument/n1:templateId[@root='1.2.40.0.34.11.8.1']">
        <div class="element" style="cursor: default;" onclick="toggleCollapseable(this);">
          <div class="bottomlineCollapseable">
            <div class="leftsmall">
              <h2>
                  <xsl:call-template name="getELGAMedikationRezeptart">
                      <xsl:with-param name="code" select="/n1:ClinicalDocument/n1:documentationOf/n1:serviceEvent/n1:code/@code" />
                  </xsl:call-template>
                  <xsl:text> gültig bis</xsl:text>
              </h2>
            </div>
            <div class="leftwide">
              <div class="address" style="display: block;">
		  	    <xsl:call-template name="formatDate">
			      <xsl:with-param name="date" select="*/n1:serviceEvent/n1:effectiveTime/n1:high" />
				  <xsl:with-param name="date_shortmode">false</xsl:with-param>
			    </xsl:call-template>
              </div>
            </div>
          </div>
          <div class="clearer"></div>
        </div>      
      </xsl:if>

      <div class="element" style="cursor: default;" onclick="toggleCollapseable(this);">
        <div class="bottomlineCollapseable">
          <div class="leftsmall">
            <h2><xsl:text>Schlagwörter (Services)</xsl:text></h2>
          </div>
          <div class="leftwide">
            <div class="address" style="display: block;">
              <xsl:call-template name="getServiceEvents" />
            </div>
          </div>
        </div>
        <div class="clearer"></div>
      </div>
      
      <div class="element" onclick="toggleCollapseable(this);">
        <div class="bottomlineCollapseable">
            <xsl:call-template name="collapseTrigger"/>
            <div class="leftsmall">
                <h2><xsl:text>Dokumentinformation</xsl:text></h2>
            </div>
            <div class="leftwide">
              <div class="telecom">
               <xsl:call-template name="getDocumentInformation" />
              </div>
            </div>
        </div>
        <div class="clearer"></div>
      </div>

    </div>
  </div>
  </xsl:template>

  <!--
  Element for participants shown in additional information of document
  -->
  <xsl:template name="bottomlineElement">
    <xsl:param name="participant" />
    <xsl:param name="showFunctionCode" select="0" />

    <div class="element" onclick="toggleCollapseable(this);">
      <div class="bottomlineCollapseable">
        <xsl:call-template name="collapseTrigger"/>
        <div class="leftsmall">
          <xsl:call-template name="participantIdentification">
            <xsl:with-param name="participant" select="$participant" />
          </xsl:call-template>
        </div>
        <div class="leftwide">
          <p class="organisationName">
          <!-- different insurance person -->
          <xsl:variable name="typecode" select="$participant/@typeCode" />
          <xsl:variable name="classcode" select="$participant/n1:associatedEntity/@classCode" />
          <xsl:variable name="code" select="$participant/n1:associatedEntity/n1:code/@code" />

          <xsl:if test="$typecode = 'HLD' and $classcode = 'POLHOLD' and $code = 'SELF'">
            <xsl:text>Versichert bei: </xsl:text>
          </xsl:if>
          <xsl:if test="$typecode = 'HLD' and $classcode = 'POLHOLD' and $code = 'FAMDEP'">
            <xsl:text>Mitversichert bei: </xsl:text>
          </xsl:if>
          <xsl:call-template name="getName">
            <xsl:with-param name="name" select="n1:associatedEntity/n1:associatedPerson/n1:name"/>
          </xsl:call-template>
          <!-- if urgency contact display relationship -->
          <xsl:if test="@typeCode='IND' and not(n1:functionCode/@code) and (n1:associatedEntity/@classCode='ECON' or n1:associatedEntity/@classCode='PRS') ">
            <span class="relationship"><xsl:text> (</xsl:text>
            <xsl:call-template name="getELGAPersonalRelationship" >
              <xsl:with-param name="participant" select="$participant" />
            </xsl:call-template>
            <xsl:text>)</xsl:text></span>
            </xsl:if>
          </p>
          <xsl:if test="$showFunctionCode='1'">
            <xsl:if test="n1:functionCode">
              <p class="organisationName">
                <xsl:call-template name="getELGAAuthorSpeciality">
                  <xsl:with-param name="code" select="n1:functionCode/@code"/>
                </xsl:call-template>
              </p>
            </xsl:if>
          </xsl:if>
          <xsl:call-template name="getContactInfo">
            <xsl:with-param name="contact" select="n1:associatedEntity"/>
          </xsl:call-template>
          <xsl:if test="n1:associatedEntity/n1:scopingOrganization">
            <xsl:call-template name="getOrganization">
            <xsl:with-param name="organization" select="n1:associatedEntity/n1:scopingOrganization"/>
          </xsl:call-template>
          </xsl:if>
        </div>
        <div class="clearer"></div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="getDocumentInformation">
    <p class="metaInformationLine">
      <xsl:call-template name="getHL7ATXDSDokumentenklassen">
        <xsl:with-param name="code" select="/n1:ClinicalDocument/n1:code/@code" />
      </xsl:call-template>
    </p>
    <p class="metaInformationLine">
      <xsl:text>Dokument erzeugt am </xsl:text>
      <xsl:call-template name="formatDate">
        <xsl:with-param name="date" select="/n1:ClinicalDocument/n1:effectiveTime" />
        <xsl:with-param name="date_shortmode">false</xsl:with-param>
      </xsl:call-template>
    </p>
    <xsl:choose>
      <xsl:when test="*/n1:serviceEvent/n1:effectiveTime/n1:low/@value != '' and */n1:serviceEvent/n1:effectiveTime/n1:high/@value != ''">
        <p>
          <xsl:text>Leistungszeitraum von </xsl:text>
          <xsl:call-template name="formatDate">
            <xsl:with-param name="date" select="*/n1:serviceEvent/n1:effectiveTime/n1:low" />
            <xsl:with-param name="date_shortmode">false</xsl:with-param>
          </xsl:call-template><xsl:text> bis </xsl:text>
          <xsl:call-template name="formatDate">
            <xsl:with-param name="date" select="*/n1:serviceEvent/n1:effectiveTime/n1:high" />
            <xsl:with-param name="date_shortmode">false</xsl:with-param>
          </xsl:call-template>
        </p>
      </xsl:when>
      <xsl:when test="*/n1:serviceEvent/n1:effectiveTime/n1:low/@value != ''">
        <p class="metaInformationLine">
          <xsl:text>Beginn der Leistung: </xsl:text>
          <xsl:call-template name="formatDate">
            <xsl:with-param name="date" select="*/n1:serviceEvent/n1:effectiveTime/n1:low" />
            <xsl:with-param name="date_shortmode">false</xsl:with-param>
          </xsl:call-template>
        </p>
      </xsl:when>
      <xsl:when test="*/n1:serviceEvent/n1:effectiveTime/n1:high/@value != ''">
        <p class="metaInformationLine">
          <xsl:text>Ende der Leistung: </xsl:text>
          <xsl:call-template name="formatDate">
            <xsl:with-param name="date" select="*/n1:serviceEvent/n1:effectiveTime/n1:high" />
            <xsl:with-param name="date_shortmode">false</xsl:with-param>
          </xsl:call-template>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <p class="metaInformationLine">
          <xsl:text>Leistungszeitraum nicht angegeben</xsl:text>
        </p>
      </xsl:otherwise>
    </xsl:choose>
    <p class="metaInformationLine">
      <xsl:text>Dokument-ID: </xsl:text>{<xsl:value-of select="/n1:ClinicalDocument/n1:id/@root" />}&#160;<xsl:value-of select="/n1:ClinicalDocument/n1:id/@extension" />
    </p>
    <p class="metaInformationLine">
      <xsl:text>Set ID: </xsl:text>
      <xsl:choose>
        <xsl:when test="/n1:ClinicalDocument/n1:setId/@root">
          {<xsl:value-of select="/n1:ClinicalDocument/n1:setId/@root" />}
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>unbekannt</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text> </xsl:text>
      <xsl:if test="/n1:ClinicalDocument/n1:setId/@extension">
        <xsl:value-of select="/n1:ClinicalDocument/n1:setId/@extension" />
      </xsl:if>
    </p>
    <p class="metaInformationLine">
      <xsl:text>Dokumentversion: </xsl:text><xsl:value-of select="/n1:ClinicalDocument/n1:versionNumber/@value" />
    </p>
    <p class="metaInformationLine">
      <xsl:text>Angezeigt mit </xsl:text><xsl:value-of select="document('')/xsl:stylesheet/@id" />
    </p>
    <p class="metaInformationLine">
      <xsl:text>Dieses Dokument entspricht den Vorgaben von: </xsl:text>
      <xsl:call-template name="getNameFromOID" /><xsl:text>; ELGA Interoperabilitätsstufe: </xsl:text><xsl:call-template name="getEISFromOID" />
    </p>
    <p class="metaInformationLine">
      <xsl:variable name="params">
        <xsl:call-template name="renderParamWithValue">
          <xsl:with-param name="paramName">showrevisionmarks</xsl:with-param>
          <xsl:with-param name="paramValue" select="$showrevisionmarks" />
          <xsl:with-param name="paramDefaultValue">0</xsl:with-param>
          <xsl:with-param name="displayText">Text-Revisionen anzeigen</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="renderParamWithValue">
          <xsl:with-param name="paramName">isStrictModeDisabled</xsl:with-param>
          <xsl:with-param name="paramValue" select="$isStrictModeDisabled" />
          <xsl:with-param name="paramDefaultValue">0</xsl:with-param>
          <xsl:with-param name="displayText">Fehlerhafte Tabellen darstellen</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="renderParamWithValue">
          <xsl:with-param name="paramName">useexternalcss</xsl:with-param>
          <xsl:with-param name="paramValue" select="$useexternalcss" />
          <xsl:with-param name="paramDefaultValue">0</xsl:with-param>
          <xsl:with-param name="displayText">Externes CSS verwenden</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="renderParamWithValue">
          <xsl:with-param name="paramName">externalcssname</xsl:with-param>
          <xsl:with-param name="paramValue" select="$externalcssname" />
          <xsl:with-param name="paramDefaultValue"/>
          <xsl:with-param name="displayText">Externe CSS-Datei</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="renderParamWithValue">
          <xsl:with-param name="paramName">printiconvisibility</xsl:with-param>
          <xsl:with-param name="paramValue" select="$printiconvisibility" />
          <xsl:with-param name="paramDefaultValue">0</xsl:with-param>
          <xsl:with-param name="displayText">Druck-Icon anzeigen</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="renderParamWithValue">
          <xsl:with-param name="paramName">isdeprecated</xsl:with-param>
          <xsl:with-param name="paramValue" select="$isdeprecated" />
          <xsl:with-param name="paramDefaultValue">0</xsl:with-param>
          <xsl:with-param name="displayText">Storniertes Dokument</xsl:with-param>
        </xsl:call-template>
<xsl:call-template name="renderParamWithValue">
    <xsl:with-param name="paramName">showTableInBestGuess</xsl:with-param>
    <xsl:with-param name="paramValue" select="$showTableInBestGuess" />
    <xsl:with-param name="paramDefaultValue">0</xsl:with-param>
    <xsl:with-param name="displayText">Ungültige Tabellen "so gut wie möglich" darstellen</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="renderParamWithValue">
    <xsl:with-param name="paramName">enableInfoButton</xsl:with-param>
    <xsl:with-param name="paramValue" select="$enableInfoButton" />
    <xsl:with-param name="paramDefaultValue">0</xsl:with-param>
    <xsl:with-param name="displayText">Info Button anzeigen</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="renderParamWithValue">
    <xsl:with-param name="paramName">LOINCResolutionUrl</xsl:with-param>
    <xsl:with-param name="paramValue" select="$LOINCResolutionUrl" />
    <xsl:with-param name="paramDefaultValue" select="'https://www.gesundheit.gv.at/linkaufloesung/applikation-flow?quelle=GHP&amp;flow=LO&amp;leistung=LA-GP-LO-'" />
    <xsl:with-param name="displayText">URL zur Auflösung der LOINC-Codes</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="renderParamWithValue">
    <xsl:with-param name="paramName">isSectionTitleWhiteBackgroundColor</xsl:with-param>
    <xsl:with-param name="paramValue" select="$isSectionTitleWhiteBackgroundColor" />
    <xsl:with-param name="paramDefaultValue">0</xsl:with-param>
    <xsl:with-param name="displayText">Weißer Hintergrund in Sektionsüberschriften</xsl:with-param>
</xsl:call-template>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$params != ''">
          <xsl:text>Dieses Dokument wurde mit folgenden Einstellungen erstellt: </xsl:text>
          <xsl:value-of select="substring($params, 1, string-length($params) - 2)" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>Dieses Dokument wurde mit den Standard-Einstellungen erstellt.</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </p>
  </xsl:template>

  <xsl:template name="renderParamWithValue">
    <xsl:param name="paramName" />
    <xsl:param name="paramValue" />
    <xsl:param name="paramDefaultValue" />
    <xsl:param name="displayText" />

    <xsl:if test="$paramValue != $paramDefaultValue">
      <xsl:value-of select="$displayText" />
      <xsl:text> (Parameter "</xsl:text>
      <xsl:value-of select="$paramName" />
      <xsl:text>"): </xsl:text>
      <xsl:value-of select="$paramValue" />
      <xsl:text>, </xsl:text>
    </xsl:if>

  </xsl:template>

  <!--
  collapse triggers [+] [-] for document
  -->
  <xsl:template name="collapseTrigger">
    <span class="collapseLinks tooltipTrigger">
      <a class="collapseHide" href="#" onclick="return false;">
        <span class="tooltip">einklappen</span>
      </a>
      <a class="collapseShow" href="#" onclick="return false;">
        <span class="tooltip">ausklappen</span>
      </a>
    </span>
  </xsl:template>

<xsl:template name="getPatientInformationData">
  <xsl:param name="sexName"/>
  <xsl:param name="birthdate_long"/>
  <xsl:param name="svnnumber"/>

  <div>
    <table cellpadding="0" cellspacing="0">
      <tr>
        <td width="210px" class="firstrow">
          <xsl:text>Geschlecht</xsl:text>
        </td>
        <td>
          <xsl:value-of select="$sexName"/>
        </td>
      </tr>

      <xsl:if test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:name/n1:family[@qualifier='SP']">
        <tr>
          <td class="firstrow">
            <xsl:text>Name vor Heirat</xsl:text>
          </td>
          <td>
            <xsl:call-template name="renderListItems">
              <xsl:with-param name="list" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:name/n1:family[@qualifier='SP']"/>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:name/n1:family[@qualifier='AD']">
        <tr>
          <td class="firstrow">
            <xsl:text>Name vor Adoption</xsl:text>
          </td>
          <td>
            <xsl:call-template name="renderListItems">
              <xsl:with-param name="list" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:name/n1:family[@qualifier='AD']"/>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:name/n1:family[@qualifier='BR']">
        <tr>
          <td class="firstrow">
            <xsl:text>Geburtsname</xsl:text>
          </td>
          <td>
            <xsl:call-template name="renderListItems">
              <xsl:with-param name="list" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:name/n1:family[@qualifier='BR']"/>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td class="firstrow">
          <xsl:text>Geburtsdatum</xsl:text>
        </td>
        <td>
          <xsl:value-of select="$birthdate_long"/>
        </td>
      </tr>
      <xsl:if test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:birthplace/n1:place/n1:addr">
        <tr>
          <td class="firstrow">
            <xsl:text>Geburtsort</xsl:text>
          </td>
          <td>
            <xsl:apply-templates select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:birthplace/n1:place/n1:addr"/>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td class="firstrow">
          <xsl:text>SV-Nr</xsl:text>
        </td>
        <td>
          <xsl:value-of select="$svnnumber"/>
        </td>
      </tr>
      <xsl:if test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:maritalStatusCode">
        <tr>
          <td class="firstrow">
            <xsl:text>Familienstand</xsl:text>
          </td>
          <td>
            <xsl:call-template name="getELGAMaritalStatus">
              <xsl:with-param name="code" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:maritalStatusCode/@code"/>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:religiousAffiliationCode">
        <tr>
          <td class="firstrow">
            <xsl:text>Religionsgemeinschaft</xsl:text>
          </td>
          <td>
            <xsl:call-template name="getELGAReligiousAffiliation">
              <xsl:with-param name="religiousAffiliation" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:religiousAffiliationCode"/>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:languageCommunication">
        <tr>
          <td class="firstrow">
            <xsl:text>Gesprochene Sprachen</xsl:text>
          </td>
          <td>
            <xsl:call-template name="getLanguageAbility">
              <xsl:with-param name="patient" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient"/>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:if>

      <xsl:if test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:telecom">
        <!-- add empty table row as a spacer -->
        <tr class="spacer">
          <td/>
          <td/>
        </tr>
        <xsl:call-template name="getContactTelecomTable">
          <xsl:with-param name="contact" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole"/>
        </xsl:call-template>
      </xsl:if>

    </table>
  </div>
</xsl:template>

<xsl:template name="getPatientAdress">
  <xsl:if test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:addr">
    <div>
      <xsl:call-template name="getContactAddress">
        <xsl:with-param name="contact" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole"/>
      </xsl:call-template>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template name="getPatientGuardian">
  <xsl:if test="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:guardian">
    <div>
      <b><xsl:text>Gesetzlicher Vertreter: Erwachsenenvertreter, Vormund, Obsorgeberechtigter</xsl:text></b>
      <xsl:apply-templates select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:guardian"/>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template name="getPatientStay">
  <div class="boxLeft">
    <xsl:call-template name="getOrganization">
      <xsl:with-param name="organization" select="/n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:serviceProviderOrganization "/>
      <xsl:with-param name="printNameBold" select="string(true())" />
    </xsl:call-template>
  </div>
  <div class="boxRight">
    <p>
      <b>
        <xsl:call-template name="getEncounterCaseNumber"/>
        <xsl:apply-templates select="/n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:id/@extension"/>
      </b>
    </p>
    <p>
      <xsl:call-template name="getEncounterText">
        <xsl:with-param name="format" select="'long'" />
      </xsl:call-template>
    </p>
  </div>
  <div class="clearer"/>
</xsl:template>

<xsl:template name="getOrderingProvider">

  <xsl:variable name="classStyle">
    <xsl:choose>
      <xsl:when test="//n1:ClinicalDocument/n1:participant[@typeCode='REF']/n1:associatedEntity/n1:scopingOrganization">
        <xsl:text>address</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <div class="boxLeft">
    <div class="{$classStyle}">
      <xsl:call-template name="getOrganization">
        <xsl:with-param name="organization" select="//n1:ClinicalDocument/n1:participant[@typeCode='REF']/n1:associatedEntity/n1:scopingOrganization"/>
        <xsl:with-param name="printNameBold" select="string(true())" />
      </xsl:call-template>
    </div>
    <p>
      <xsl:call-template name="getName">
        <xsl:with-param name="name" select="//n1:ClinicalDocument/n1:participant[@typeCode='REF']/n1:associatedEntity/n1:associatedPerson/n1:name"/>
      </xsl:call-template>
    </p>
    <p>
      <xsl:call-template name="getContactInfo">
        <xsl:with-param name="contact" select="//n1:ClinicalDocument/n1:participant[@typeCode='REF']/n1:associatedEntity"/>
      </xsl:call-template>
    </p>
  </div>
  <div class="boxRight">
    <p><b><xsl:text>Auftragsdaten:</xsl:text></b></p>
    <p>
      Auftragsnummer:
      <xsl:choose>
        <xsl:when test="/n1:ClinicalDocument/n1:inFulfillmentOf/n1:order/n1:id/@extension">
          <xsl:apply-templates select="/n1:ClinicalDocument/n1:inFulfillmentOf/n1:order/n1:id/@extension" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>nicht angegeben</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </p>
    <p>
      Auftragsdatum:
      <xsl:call-template name="formatDate">
        <xsl:with-param name="date" select="/n1:ClinicalDocument/n1:participant[@typeCode='REF']/n1:time" />
      </xsl:call-template>
    </p>
  </div>
  <div class="clearer"/>
</xsl:template>

 <!--
  code translations for participants
    most common used in bottom section of document for additional information
  includes tooltips
  -->
  <xsl:template name="participantIdentification">
    <xsl:param name="participant" />
    <xsl:variable name="typecode" select="$participant/@typeCode" />
    <xsl:variable name="functioncode" select="$participant/n1:functionCode/@code" />
    <xsl:variable name="classcode" select="$participant/n1:associatedEntity/@classCode" />
    <xsl:variable name="signaturecode" select="$participant/*/n1:signatureCode/@code" />
    <xsl:variable name="code" select="$participant/n1:associatedEntity/n1:code/@code" />

    <xsl:choose>
      <xsl:when test="$typecode = 'RCT'"><h2 class="tooltipTrigger"><xsl:value-of select="$genderedpatient"/><span class="tooltip"><xsl:value-of select="$genderedpatient"/></span></h2></xsl:when>
      <xsl:when test="$typecode = 'AUT'"><h2 class="tooltipTrigger">Verfasser des Dokuments<span class="tooltip">Autor</span></h2></xsl:when>
      <xsl:when test="$typecode = 'ENT'"><h2 class="tooltipTrigger">Schreibkraft<span class="tooltip">Schreibkraft</span></h2></xsl:when>
      <xsl:when test="$typecode = 'CST'"><h2 class="tooltipTrigger">Originaldokument ist verfügbar bei<span class="tooltip">Gibt die Organisation an, die das originale Befunddokument verwahrt.</span></h2></xsl:when>
      <xsl:when test="$typecode = 'INF'"><h2 class="tooltipTrigger">Auskunftsperson zum Patienten<span class="tooltip">Person, die weitere Informationen über den Patienten geben kann</span></h2></xsl:when>
      <xsl:when test="$typecode = 'PRCP'"><h2 class="tooltipTrigger">Empfänger:<span class="tooltip">Empfänger des Dokuments</span></h2></xsl:when>
      <xsl:when test="$typecode = 'TRC'"><h2 class="tooltipTrigger">Kopie an:<span class="tooltip">Weitere Empfänger des Dokuments</span></h2></xsl:when>
      <xsl:when test="$typecode = 'LA'"><h2 class="tooltipTrigger">Unterzeichner(in)<span class="tooltip">Person, die das Dokument unterzeichnet hat</span></h2></xsl:when>
      <xsl:when test="$typecode = 'LA' and $signaturecode='S'"><h2>Unterzeichner(in)</h2></xsl:when>
      <xsl:when test="$typecode = 'AUTHEN'"><h2 class="tooltipTrigger">Weitere Unterzeichner<span class="tooltip">Weitere Personen, die das Dokument unterzeichnet haben.</span></h2></xsl:when>
      <xsl:when test="$typecode = 'AUTHEN' and $signaturecode='S'"><h2>Weitere Unterzeichner</h2></xsl:when>
      <xsl:when test="$typecode = 'CALLBCK'"><h1 class="tooltipTrigger"><b>Bei Fragen kontaktieren Sie bitte:</b><span class="tooltip">Fachliche(r) Ansprechpartner(in) für dieses Dokument</span></h1></xsl:when>
      <xsl:when test="$typecode = 'REF'"><h2>Zuweiser(in)</h2></xsl:when>
      <xsl:when test="$typecode = 'REF' and $functioncode = 'ADMPHYS'"><h2>Einweisende(r)/Zuweisende(r) Arzt/Ärztin</h2></xsl:when>
      <xsl:when test="$typecode = 'IND'">
        <xsl:choose>
          <xsl:when test="$typecode = 'IND' and $functioncode = 'PCP'"><h2>Hausarzt/Hausärztin</h2></xsl:when>
          <xsl:when test="$typecode = 'IND' and $classcode = 'ECON'"><h2 class="tooltipTrigger">Notfall-Kontakt<span class="tooltip">Auskunftsberechtigte Person</span></h2></xsl:when>
          <xsl:when test="$typecode = 'IND' and $classcode = 'CAREGIVER'"><h2>Betreuende Organisation</h2></xsl:when>
          <xsl:when test="$typecode = 'IND' and $classcode = 'PRS'">
            <h2>Angehörige(r)</h2>
          </xsl:when>
          <xsl:otherwise><h2>Weitere Beteiligte</h2></xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$typecode = 'HLD' and $classcode = 'POLHOLD' and $code = 'SELF'"><h2>Versicherungsinhaber(in) und Versicherungsgesellschaft</h2></xsl:when>
      <xsl:when test="$typecode = 'HLD' and $classcode = 'POLHOLD' and $code = 'FAMDEP'"><h2>Versicherungsinhaber(in) und Versicherungsgesellschaft</h2></xsl:when>
      <xsl:when test="$typecode = 'CON' and $classcode = 'PROV'"><h2>Weitere Behandler</h2></xsl:when>
      <xsl:otherwise>-</xsl:otherwise>
    </xsl:choose>
  </xsl:template>




    <!-- AUTO GENERATED TEMPLATE. DO NOT MODIFY! -->
    
    <xsl:template name="getELGAPersonalRelationship">
        <xsl:param name="participant" />
        
        <xsl:variable name="code"><xsl:value-of select="$participant/*/n1:code/@code"/></xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$code='FAMMEMB'">Familienmitglied</xsl:when>
            <xsl:when test="$code='SPS'">Ehepartner</xsl:when>
            <xsl:when test="$code='HUSB'">Ehemann</xsl:when>
            <xsl:when test="$code='WIFE'">Ehefrau</xsl:when>
            <xsl:when test="$code='PRN'">Elternteil</xsl:when>
            <xsl:when test="$code='FTH'">Vater</xsl:when>
            <xsl:when test="$code='MTH'">Mutter</xsl:when>
            <xsl:when test="$code='NPRN'">leibliches Elternteil</xsl:when>
            <xsl:when test="$code='NFTH'">leiblicher Vater</xsl:when>
            <xsl:when test="$code='NMTH'">leibliche Mutter</xsl:when>
            <xsl:when test="$code='PRNINLAW'">Schwiegereltern</xsl:when>
            <xsl:when test="$code='FTHINLAW'">Schwiegervater</xsl:when>
            <xsl:when test="$code='MTHINLAW'">Schwiegermutter</xsl:when>
            <xsl:when test="$code='STPPRN'">Stiefelternteil</xsl:when>
            <xsl:when test="$code='STPFTH'">Stiefvater</xsl:when>
            <xsl:when test="$code='STPMTH'">Stiefmutter</xsl:when>
            <xsl:when test="$code='SIB'">Geschwister</xsl:when>
            <xsl:when test="$code='BRO'">Bruder</xsl:when>
            <xsl:when test="$code='SIS'">Schwester</xsl:when>
            <xsl:when test="$code='HSIB'">Halbgeschwister</xsl:when>
            <xsl:when test="$code='HBRO'">Halbbruder</xsl:when>
            <xsl:when test="$code='HSIS'">Halbschwester</xsl:when>
            <xsl:when test="$code='NSIB'">leibliche Geschwister</xsl:when>
            <xsl:when test="$code='NBRO'">leiblicher Bruder</xsl:when>
            <xsl:when test="$code='NSIS'">leibliche Schwester</xsl:when>
            <xsl:when test="$code='SIBINLAW'">Schwager/ Schwägerin</xsl:when>
            <xsl:when test="$code='BROINLAW'">Schwager</xsl:when>
            <xsl:when test="$code='SISINLAW'">Schwägerin</xsl:when>
            <xsl:when test="$code='STPSIB'">Stiefgeschwister</xsl:when>
            <xsl:when test="$code='STPBRO'">Stiefbruder</xsl:when>
            <xsl:when test="$code='STPSIS'">Stiefschwester</xsl:when>
            <xsl:when test="$code='CHILD'">Kind</xsl:when>
            <xsl:when test="$code='NCHILD'">leibliches Kind</xsl:when>
            <xsl:when test="$code='CHLDADOPT'">Adoptivkind</xsl:when>
            <xsl:when test="$code='CHLDFOST'">Pflegekind</xsl:when>
            <xsl:when test="$code='CHLDINLAW'">Schwiegerkind</xsl:when>
            <xsl:when test="$code='STPCHLD'">Stiefkind</xsl:when>
            <xsl:when test="$code='DAUC'">Tochter</xsl:when>
            <xsl:when test="$code='DAU'">leibliche Tochter</xsl:when>
            <xsl:when test="$code='DAUADOPT'">Adoptivtocher</xsl:when>
            <xsl:when test="$code='DAUFOST'">Pflegetochter</xsl:when>
            <xsl:when test="$code='DAUINLAW'">Schwiegertochter</xsl:when>
            <xsl:when test="$code='STPDAU'">Stieftochter</xsl:when>
            <xsl:when test="$code='SONC'">Sohn</xsl:when>
            <xsl:when test="$code='SON'">leiblicher Sohn</xsl:when>
            <xsl:when test="$code='SONADOPT'">Adoptivsohn</xsl:when>
            <xsl:when test="$code='SONFOST'">Pflegesohn</xsl:when>
            <xsl:when test="$code='SONINLAW'">Schwiegersohn</xsl:when>
            <xsl:when test="$code='STPSON'">Stiefsohn</xsl:when>
            <xsl:when test="$code='GRPRN'">Großelternteil</xsl:when>
            <xsl:when test="$code='GRFTH'">Großvater</xsl:when>
            <xsl:when test="$code='GRMTH'">Großmutter</xsl:when>
            <xsl:when test="$code='GGRPRN'">Urgroßelternteil</xsl:when>
            <xsl:when test="$code='GGRFTH'">Urgroßvater</xsl:when>
            <xsl:when test="$code='GGRMTH'">Urgroßmutter</xsl:when>
            <xsl:when test="$code='GRNDCHILD'">Enkelkind</xsl:when>
            <xsl:when test="$code='GRNDDAU'">Enkeltochter</xsl:when>
            <xsl:when test="$code='GRNDSON'">Enkelsohn</xsl:when>
            <xsl:when test="$code='AUNT'">Tante</xsl:when>
            <xsl:when test="$code='UNCLE'">Onkel</xsl:when>
            <xsl:when test="$code='NIENEPH'">Nichte/Neffe</xsl:when>
            <xsl:when test="$code='COUSN'">Cousine/Cousin</xsl:when>
            <xsl:when test="$code='FRND'">Bekannte/Bekannter</xsl:when>
            <xsl:when test="$code='SIGOTHR'">wichtige Bezugsperson (z.B. Lebensgefährte)</xsl:when>
            <xsl:when test="$code='ROOM'">MitbewohnerIn</xsl:when>
            <xsl:when test="$code='DOMPART'">LebenspartnerIn</xsl:when>
            <xsl:when test="$code='NBOR'">NachbarIn</xsl:when>
            <xsl:when test="$code='SPON'">Pflegeperson</xsl:when>
            <xsl:when test="$code='GUARD'">SachwalterIn</xsl:when>
            <xsl:when test="$code='SELF'">Patient selbst</xsl:when>
            <xsl:otherwise><xsl:value-of select="$code" />)</xsl:otherwise>
        
        </xsl:choose>
    
    </xsl:template>
    


  <!--
  code translations for telecom
  also found in addr tags
  -->
  <xsl:template name="translateCode">
    <xsl:param name="code"/>
    <xsl:choose>
      <!-- lookup table Telecom URI -->
      <xsl:when test="$code='fax'"><xsl:text>Fax</xsl:text></xsl:when>
      <xsl:when test="$code='file'"><xsl:text>Datei</xsl:text></xsl:when>
      <xsl:when test="$code='ftp'"><xsl:text>FTP</xsl:text></xsl:when>
      <xsl:when test="$code='http'"><xsl:text>Web</xsl:text></xsl:when>
      <xsl:when test="$code='mailto'"><xsl:text>Email</xsl:text></xsl:when>
      <xsl:when test="$code='me'"><xsl:text>ME</xsl:text></xsl:when>
      <xsl:when test="$code='mllp'"><xsl:text>MLLP</xsl:text></xsl:when>
      <xsl:when test="$code='modem'"><xsl:text>Modem</xsl:text></xsl:when>
      <xsl:when test="$code='nfs'"><xsl:text>NFS</xsl:text></xsl:when>
      <xsl:when test="$code='tel'"><xsl:text>Tel</xsl:text></xsl:when>
      <xsl:when test="$code='telnet'"><xsl:text>Telnet</xsl:text></xsl:when>
      <!-- addr oder telecom use -->
      <xsl:when test="$code='AS'"><xsl:text>Anrufbeantworter</xsl:text></xsl:when>
      <xsl:when test="$code='EC'"><xsl:text>Im Notfall erreichbar unter</xsl:text></xsl:when>
      <xsl:when test="$code='H'"><xsl:text>Wohnort</xsl:text></xsl:when>
      <xsl:when test="$code='HP'"><xsl:text>Hauptwohnsitz</xsl:text></xsl:when>
      <xsl:when test="$code='HV'"><xsl:text>Ferienwohnort</xsl:text></xsl:when>
      <xsl:when test="$code='MC'"><xsl:text>Mobil</xsl:text></xsl:when>
      <xsl:when test="$code='PG'"><xsl:text>Pager</xsl:text></xsl:when>
      <xsl:when test="$code='WP'"><xsl:text>Geschäftlich</xsl:text></xsl:when>
      <xsl:when test="$code='PUB'"><xsl:text>Geschäftlich</xsl:text></xsl:when>
      <xsl:when test="$code='TMP'"><xsl:text>Pflegeadresse</xsl:text></xsl:when>
      <xsl:otherwise><xsl:value-of select="$code" /></xsl:otherwise>
    </xsl:choose>
  </xsl:template>



    <!-- AUTO GENERATED TEMPLATE. DO NOT MODIFY! -->
    
    <xsl:template name="getELGAAuthorSpeciality">
        <xsl:param name="code" />
        
        <xsl:choose>
            <xsl:when test="$code='10'">Rollen für Personen</xsl:when>
            <xsl:when test="$code='100'">Ärztin/Arzt für Allgemeinmedizin</xsl:when>
            <xsl:when test="$code='101'">Approbierte Ärztin/Approbierter Arzt</xsl:when>
            <xsl:when test="$code='158'">Fachärztin/Facharzt</xsl:when>
            <xsl:when test="$code='102'">Fachärztin/Facharzt für Anästhesiologie und Intensivmedizin</xsl:when>
            <xsl:when test="$code='103'">Fachärztin/Facharzt für Anatomie</xsl:when>
            <xsl:when test="$code='104'">Fachärztin/Facharzt für Arbeitsmedizin</xsl:when>
            <xsl:when test="$code='105'">Fachärztin/Facharzt für Augenheilkunde und Optometrie</xsl:when>
            <xsl:when test="$code='106'">Fachärztin/Facharzt für Blutgruppenserologie und Transfusionsmedizin</xsl:when>
            <xsl:when test="$code='107'">Fachärztin/Facharzt für Chirurgie</xsl:when>
            <xsl:when test="$code='108'">Fachärztin/Facharzt für Frauenheilkunde und Geburtshilfe</xsl:when>
            <xsl:when test="$code='109'">Fachärztin/Facharzt für Gerichtsmedizin</xsl:when>
            <xsl:when test="$code='110'">Fachärztin/Facharzt für Hals-, Nasen- und Ohrenkrankheiten</xsl:when>
            <xsl:when test="$code='111'">Fachärztin/Facharzt für Haut- und Geschlechtskrankheiten</xsl:when>
            <xsl:when test="$code='112'">Fachärztin/Facharzt für Herzchirurgie</xsl:when>
            <xsl:when test="$code='113'">Fachärztin/Facharzt für Histologie und Embryologie</xsl:when>
            <xsl:when test="$code='114'">Fachärztin/Facharzt für Hygiene und Mikrobiologie</xsl:when>
            <xsl:when test="$code='115'">Fachärztin/Facharzt für Immunologie</xsl:when>
            <xsl:when test="$code='116'">Fachärztin/Facharzt für Innere Medizin</xsl:when>
            <xsl:when test="$code='117'">Fachärztin/Facharzt für Kinder- und Jugendchirurgie</xsl:when>
            <xsl:when test="$code='118'">Fachärztin/Facharzt für Kinder- und Jugendheilkunde</xsl:when>
            <xsl:when test="$code='119'">Fachärztin/Facharzt für Kinder- und Jugendpsychiatrie</xsl:when>
            <xsl:when test="$code='120'">Fachärztin/Facharzt für Lungenkrankheiten</xsl:when>
            <xsl:when test="$code='121'">Fachärztin/Facharzt für Medizinische Biologie</xsl:when>
            <xsl:when test="$code='122'">Fachärztin/Facharzt für Medizinische Biophysik</xsl:when>
            <xsl:when test="$code='123'">Fachärztin/Facharzt für Medizinische Genetik</xsl:when>
            <xsl:when test="$code='124'">Fachärztin/Facharzt für Medizinische und Chemische Labordiagnostik</xsl:when>
            <xsl:when test="$code='125'">Fachärztin/Facharzt für Medizinische Leistungsphysiologie</xsl:when>
            <xsl:when test="$code='126'">Fachärztin/Facharzt für Mikrobiologisch-Serologische Labordiagnostik</xsl:when>
            <xsl:when test="$code='127'">Fachärztin/Facharzt für Mund-, Kiefer- und Gesichtschirurgie</xsl:when>
            <xsl:when test="$code='128'">Fachärztin/Facharzt für Neurobiologie</xsl:when>
            <xsl:when test="$code='129'">Fachärztin/Facharzt für Neurochirurgie</xsl:when>
            <xsl:when test="$code='130'">Fachärztin/Facharzt für Neurologie</xsl:when>
            <xsl:when test="$code='131'">Fachärztin/Facharzt für Neurologie und Psychiatrie</xsl:when>
            <xsl:when test="$code='132'">Fachärztin/Facharzt für Neuropathologie</xsl:when>
            <xsl:when test="$code='133'">Fachärztin/Facharzt für Nuklearmedizin</xsl:when>
            <xsl:when test="$code='134'">Fachärztin/Facharzt für Orthopädie und Orthopädische Chirurgie</xsl:when>
            <xsl:when test="$code='135'">Fachärztin/Facharzt für Pathologie</xsl:when>
            <xsl:when test="$code='136'">Fachärztin/Facharzt für Pathophysiologie</xsl:when>
            <xsl:when test="$code='137'">Fachärztin/Facharzt für Pharmakologie und Toxikologie</xsl:when>
            <xsl:when test="$code='138'">Fachärztin/Facharzt für Physikalische Medizin und Allgemeine Rehabilitation</xsl:when>
            <xsl:when test="$code='139'">Fachärztin/Facharzt für Physiologie</xsl:when>
            <xsl:when test="$code='140'">Fachärztin/Facharzt für Plastische, Ästhetische und Rekonstruktive Chirurgie</xsl:when>
            <xsl:when test="$code='141'">Fachärztin/Facharzt für Psychiatrie</xsl:when>
            <xsl:when test="$code='142'">Fachärztin/Facharzt für Psychiatrie und Neurologie</xsl:when>
            <xsl:when test="$code='143'">Fachärztin/Facharzt für Psychiatrie und Psychotherapeutische Medizin</xsl:when>
            <xsl:when test="$code='144'">Fachärztin/Facharzt für Radiologie</xsl:when>
            <xsl:when test="$code='145'">Fachärztin/Facharzt für Sozialmedizin</xsl:when>
            <xsl:when test="$code='146'">Fachärztin/Facharzt für Spezifische Prophylaxe und Tropenmedizin</xsl:when>
            <xsl:when test="$code='147'">Fachärztin/Facharzt für Strahlentherapie-Radioonkologie</xsl:when>
            <xsl:when test="$code='148'">Fachärztin/Facharzt für Theoretische Sonderfächer</xsl:when>
            <xsl:when test="$code='149'">Fachärztin/Facharzt für Thoraxchirurgie</xsl:when>
            <xsl:when test="$code='150'">Fachärztin/Facharzt für Tumorbiologie</xsl:when>
            <xsl:when test="$code='151'">Fachärztin/Facharzt für Unfallchirurgie</xsl:when>
            <xsl:when test="$code='152'">Fachärztin/Facharzt für Urologie</xsl:when>
            <xsl:when test="$code='153'">Fachärztin/Facharzt für Virologie</xsl:when>
            <xsl:when test="$code='154'">Fachärztin/Facharzt für Zahn-, Mund- und Kieferheilkunde</xsl:when>
            <xsl:when test="$code='155'">Zahnärztin/Zahnarzt</xsl:when>
            <xsl:when test="$code='156'">Dentistin/Dentist</xsl:when>
            <xsl:when test="$code='200'">Psychotherapeutin/Psychotherapeut</xsl:when>
            <xsl:when test="$code='201'">Klinische Psychologin/Klinischer Psychologe</xsl:when>
            <xsl:when test="$code='202'">Gesundheitspsychologin/Gesundheitspsychologe</xsl:when>
            <xsl:when test="$code='203'">Musiktherapeutin/Musiktherapeut</xsl:when>
            <xsl:when test="$code='204'">Hebamme</xsl:when>
            <xsl:when test="$code='205'">Physiotherapeutin/Physiotherapeut</xsl:when>
            <xsl:when test="$code='206'">Biomedizinische Analytikerin/Biomedizinischer Analytiker</xsl:when>
            <xsl:when test="$code='207'">Radiologietechnologin/Radiologietechnologe</xsl:when>
            <xsl:when test="$code='208'">Diätologin/Diätologe</xsl:when>
            <xsl:when test="$code='209'">Ergotherapeutin/Ergotherapeut</xsl:when>
            <xsl:when test="$code='210'">Logopädin/Logopäde</xsl:when>
            <xsl:when test="$code='211'">Orthoptistin/Orthoptist</xsl:when>
            <xsl:when test="$code='212'">Diplomierte Gesundheits- und Krankenschwester/Diplomierter Gesundheits- und Krankenpfleger</xsl:when>
            <xsl:when test="$code='213'">Diplomierte Kinderkrankenschwester/Diplomierter Kinderkrankenpfleger</xsl:when>
            <xsl:when test="$code='214'">Diplomierte psychiatrische Gesundheits- und Krankenschwester/Diplomierter psychiatrischer Gesundheits- und Krankenpfleger</xsl:when>
            <xsl:when test="$code='215'">Heilmasseurin/Heilmasseur</xsl:when>
            <xsl:when test="$code='216'">Diplomierte Kardiotechnikerin/Diplomierter Kardiotechniker</xsl:when>
            <xsl:when test="$code='20'">Teil 2: Rollen für Organisationen</xsl:when>
            <xsl:when test="$code='300'">Allgemeine Krankenanstalt</xsl:when>
            <xsl:when test="$code='301'">Sonderkrankenanstalt</xsl:when>
            <xsl:when test="$code='302'">Pflegeanstalt</xsl:when>
            <xsl:when test="$code='303'">Sanatorium</xsl:when>
            <xsl:when test="$code='304'">Selbstständiges Ambulatorium</xsl:when>
            <xsl:when test="$code='305'">Pflegeeinrichtung</xsl:when>
            <xsl:when test="$code='306'">Mobile Pflege</xsl:when>
            <xsl:when test="$code='307'">Kuranstalt</xsl:when>
            <xsl:when test="$code='309'">Straf- und Maßnahmenvollzug</xsl:when>
            <xsl:when test="$code='310'">Untersuchungsanstalt</xsl:when>
            <xsl:when test="$code='311'">Öffentliche Apotheke</xsl:when>
            <xsl:when test="$code='312'">Gewebebank</xsl:when>
            <xsl:when test="$code='313'">Blutspendeeinrichtung</xsl:when>
            <xsl:when test="$code='314'">Augen- und Kontaktlinsenoptik</xsl:when>
            <xsl:when test="$code='315'">Hörgeräteakustik</xsl:when>
            <xsl:when test="$code='316'">Orthopädische Produkte</xsl:when>
            <xsl:when test="$code='317'">Zahntechnik</xsl:when>
            <xsl:when test="$code='318'">Rettungsdienst</xsl:when>
            <xsl:when test="$code='319'">Zahnärztliche Gruppenpraxis</xsl:when>
            <xsl:when test="$code='320'">Ärztliche Gruppenpraxis</xsl:when>
            <xsl:when test="$code='321'">Gewebeentnahmeeinrichtung</xsl:when>
            <xsl:when test="$code='322'">Arbeitsmedizinisches Zentrum</xsl:when>
            <xsl:when test="$code='400'">Gesundheitsmanagement</xsl:when>
            <xsl:when test="$code='401'">Öffentlicher Gesundheitsdienst</xsl:when>
            <xsl:when test="$code='403'">ELGA-Ombudsstelle</xsl:when>
            <xsl:when test="$code='404'">Widerspruchstelle</xsl:when>
            <xsl:when test="$code='405'">Patientenvertretung</xsl:when>
            <xsl:when test="$code='406'">Sozialversicherung</xsl:when>
            <xsl:when test="$code='407'">Krankenfürsorge</xsl:when>
            <xsl:when test="$code='408'">Gesundheitsversicherung</xsl:when>
            <xsl:when test="$code='500'">IKT-Gesundheitsservice</xsl:when>
            <xsl:when test="$code='501'">Verrechnungsservice</xsl:when>
            <xsl:otherwise>Fachrichtung unbekannt</xsl:otherwise>
        
        </xsl:choose>
    
    </xsl:template>
    



  
  <xsl:template name="documentstate">
    <xsl:if test="$isdeprecated=1">
      <div class="deprecated">
        STORNIERT
      </div>
    </xsl:if>
  </xsl:template>

  <!-- base64 encoded images which are used more often -->
  <xsl:template name="getWarningIcon">
    <img alt="" height="18" width="18" src="{$warningIcon}" />
  </xsl:template>

  <xsl:template name="getPatientLivingWillIcon">
    <img alt="" height="18" width="18" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAC4jAAAuIwF4pT92AAAKsWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIiB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgeG1wOkNyZWF0ZURhdGU9IjIwMTgtMDctMjlUMTc6NDA6MTIrMDI6MDAiIHhtcDpNZXRhZGF0YURhdGU9IjIwMTgtMDgtMDJUMDQ6NDM6NDMrMDI6MDAiIHhtcDpNb2RpZnlEYXRlPSIyMDE4LTA4LTAyVDA0OjQzOjQzKzAyOjAwIiBkYzpmb3JtYXQ9ImltYWdlL3BuZyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDphNjc3ZDc3MC03NGY0LTRjZGYtYjViNC01NGY0MDE5Y2FlMDYiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDphYzllM2U2ZC0wYTI1LTJiNDMtODU4Mi05ZDIyZTkwOGVjMDEiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo0MTEzMDRhNy0yNGMzLTRiZTUtYmJkNC02ZjAxM2MyOGYzNDkiIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgdGlmZjpPcmllbnRhdGlvbj0iMSIgdGlmZjpYUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpZUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpSZXNvbHV0aW9uVW5pdD0iMiIgZXhpZjpDb2xvclNwYWNlPSIxIiBleGlmOlBpeGVsWERpbWVuc2lvbj0iNjQiIGV4aWY6UGl4ZWxZRGltZW5zaW9uPSI2NCI+IDx4bXBNTTpIaXN0b3J5PiA8cmRmOlNlcT4gPHJkZjpsaSBzdEV2dDphY3Rpb249ImNyZWF0ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5IiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQwOjEyKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ODA1YWFlMTktOWE5OC00YzFlLWE4YjMtM2FmNzI1MjJjNTAzIiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQ2OjA0KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ZjNiZjIwODUtOTUxNC00YTkyLThhNzEtNGJmNjNhOWZiODAzIiBzdEV2dDp3aGVuPSIyMDE4LTA4LTAyVDA0OjQzOjQzKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY29udmVydGVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJmcm9tIGFwcGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJkZXJpdmVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJjb252ZXJ0ZWQgZnJvbSBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wIHRvIGltYWdlL3BuZyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6YTY3N2Q3NzAtNzRmNC00Y2RmLWI1YjQtNTRmNDAxOWNhZTA2IiBzdEV2dDp3aGVuPSIyMDE4LTA4LTAyVDA0OjQzOjQzKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6ZjNiZjIwODUtOTUxNC00YTkyLThhNzEtNGJmNjNhOWZiODAzIiBzdFJlZjpkb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6YTFhYzMwMmYtMWEyZS0yMTQ4LTkwZmQtMTUwNTY5M2E3YzRiIiBzdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+hT/qlQAAAm9JREFUeNrt2stKw0AUBuDgpSpSiqDoQutG3Ln17lN4AbEPIMVLEYrg2idREbGiS7XPoEsVXYh4qVu1Ra3V1DNwAlpzTyaZiSfwUyiZpPNZO2cmo1SrVeU/RyEAAiAAAiAAAiAAAvj1ZsSOoAEaIVnIOeSD3d9DXiEnkAVIvQwAMUjeY6eNcoDXFxpglVPnPSEECXDJGcAVQpAAnxw6fOwVIUgAHn/xDsieFwTZARI4suTcIkQBQPGCEBUAdjRAdp0iRAlAwYJoxwlC1AA0hG27CFEEcIQQVQANYUunzSGkkwfAvGAAGsKGTrs8DwDVAoEHQC+kzSLtkP2admUeAFULhKcA5gJOEucBYIYwIhhCgheAGcIo5DkKAHZuYIQwBnlx8YHfIHeQd1kAzBDGHSCwTs9AmrBtMyQFeZQBwAqhaKPz3Qb/cklIQQYAM4QJSMmk3bTFOJ+SBUBDGNDpxLLB+SUb8/kWHNOlAMg4HBWubZbYBRl+AzIu6oIiLnRI/Q1Q8SvutiiasgCYE70OWNL50MMOKkI2CnQZdL4Hci9yJbioc86Qi3L4FkcD7QeR1QOzkAdRS2EVn9fVHoMe5wKsErzBV2HnAkadF3E26DsA63za5/WACuQUFzXW8fkie93E9ysiAaR9WhH6wqc9k5BWi2vG8bx9bBcqgB9rgmypqt/l9Vm7I5kBcl42OuBRZ/BcQAqAPp92vSRlBfB16w8BEICco4DUhVAYW2TcRtXmFkECXAgEcBXGw9GsQABrYQDEHFZqvJL/udYYxlbZFciZjw847KSM98zWLrPRZmnaLk8ABEAABEAABEAABPA33y0MBL4dj7CbAAAAAElFTkSuQmCC" />
  </xsl:template>

  <xsl:template name="getPatientGuardianIconTitle">
    <img alt="Symbol für gesetzlicher Vertreter" height="18" width="18" style="vertical-align: text-top" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAC4jAAAuIwF4pT92AAAKsWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIiB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgeG1wOkNyZWF0ZURhdGU9IjIwMTgtMDctMjlUMTc6NDA6MTIrMDI6MDAiIHhtcDpNZXRhZGF0YURhdGU9IjIwMTgtMTAtMDdUMTk6NTQ6NTArMDI6MDAiIHhtcDpNb2RpZnlEYXRlPSIyMDE4LTEwLTA3VDE5OjU0OjUwKzAyOjAwIiBkYzpmb3JtYXQ9ImltYWdlL3BuZyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpiMWNkNmZiNC0zMjgzLTQwNDAtOWVjZi03NzE3Mzk0OWE1ZGQiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDozMGY3YWJmNi04MjZlLWMwNDQtYTMxNi1iMmM2YmM3ZGQ5ZjYiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo0MTEzMDRhNy0yNGMzLTRiZTUtYmJkNC02ZjAxM2MyOGYzNDkiIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgdGlmZjpPcmllbnRhdGlvbj0iMSIgdGlmZjpYUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpZUmVzb2x1dGlvbj0iMzAwMDAwMC8xMDAwMCIgdGlmZjpSZXNvbHV0aW9uVW5pdD0iMiIgZXhpZjpDb2xvclNwYWNlPSIxIiBleGlmOlBpeGVsWERpbWVuc2lvbj0iNjQiIGV4aWY6UGl4ZWxZRGltZW5zaW9uPSI2NCI+IDx4bXBNTTpIaXN0b3J5PiA8cmRmOlNlcT4gPHJkZjpsaSBzdEV2dDphY3Rpb249ImNyZWF0ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5IiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQwOjEyKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6ODA1YWFlMTktOWE5OC00YzFlLWE4YjMtM2FmNzI1MjJjNTAzIiBzdEV2dDp3aGVuPSIyMDE4LTA3LTI5VDE3OjQ2OjA0KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NDQ1ODU2MzMtMTU3NC00ZjIwLTlmNWQtYmFiZGZjOTA0YjkxIiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA3VDE5OjU0OjUwKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY29udmVydGVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJmcm9tIGFwcGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJkZXJpdmVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJjb252ZXJ0ZWQgZnJvbSBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wIHRvIGltYWdlL3BuZyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6YjFjZDZmYjQtMzI4My00MDQwLTllY2YtNzcxNzM5NDlhNWRkIiBzdEV2dDp3aGVuPSIyMDE4LTEwLTA3VDE5OjU0OjUwKzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NDQ1ODU2MzMtMTU3NC00ZjIwLTlmNWQtYmFiZGZjOTA0YjkxIiBzdFJlZjpkb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6YTFhYzMwMmYtMWEyZS0yMTQ4LTkwZmQtMTUwNTY5M2E3YzRiIiBzdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6NDExMzA0YTctMjRjMy00YmU1LWJiZDQtNmYwMTNjMjhmMzQ5Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+FcDnAwAAA71JREFUeNrtm0loFEEUhr+omWBwS4zLQXE3YNDEBQ9eBReUSBARXEBEUPCiiIILYvAgkuSgeFBEXA6KuBxUFA+KN+OCiCAqMTpiFhDN5hITY8bLG2mKnp7u6eolnS54hJm8qur3TfXren/NkEqlGMxGDCAGEAOIAcQAgrwAly0qABLABuAK0AB0AZ3AW+ASUAUMiyqA9cBnIJXF3gOrIgMAGAqcthG40fqB40BeFACccBi80Y4NaACylM0CqwbmAqOA0cBi4GiGlbBaOwCfWzlwSwKqByosfDcCrxQIjZkSoxMwXgCoAGolqGagR/7WA3UmgVYB82yMu9FkJawLE4DpwA1ZntkS2U3xd9rU2+FyWAAsBzocJrIOYIXDeRYoY7wOA4DlQF+O2bwPqHQwV7HSvy1oADNz+ORV+w7MtjnfcKVvd9AA7roMPm33bM43R+mXDBLAfE3Bp22RjTkPK32uBQmgRjOAuizzlQF/lT6bgwTwVDOAZxZzzQIeKv4tkhMCA/BVMwCzjD4JOCjJTvXfpEMncAOgVzOAPmX8TgvfC7qEEjcAPmsG0GwYO8/C76JVDeAngMeaAdQbxp5s8v8WYKtuqSxMT4Faw9iV8l4n8ADYCYzwQit0A6BCM4CFyo5vpB9i6UDbCYYOwAwPaoFRUipPAYqA/DADAFimsRocB7QrPn9EEb4D7BeZLFQA0iVxu0s9IE+CtNO3AdhrlSeCUoSu21SEbpgoQtU5rKBvwHZgSBg1wcdAk2xjm+R1bQbxcx/wQ1ZREvgAfHKwqh4C48MCwEkbIvJ3gYVPviTbKqkYWzNASErRNKAA5NKKgQNyfqhCaAKmRR1Auk2VnKNCeAkUBAUgASwBdgFngEfAG0lWxpK2Xd5rFB3gNnAK2A0sBcY4mPOcCYQaPwEUyAHF9QzLMtf9wXPRAuycH1xU+vcCpX4AKAe+aK4JVPsLXBUF2qq9UMtmPwAUeRy80X4BOyyuZYvi3wOU+HELdPkIIQUcsriWJ4rvNq8BjPQ5+PROclWG69mjnh16DWBtAACsjsbL1LNDLwEkJFOnArI1JtdUqPj89ArAMOB8AEF/EnlsunwApoWg0XQAKDVMlgBWmiQbP+y+iCVZpQDdAN7Js7jNhfDh1j5K0UQQAH4HeJ//f5w5UcN0A0iFwCYOZgD9bjZmUVkBYx0A6IgigJM5AmiNCoBuB0djPYZ+Z6MCIP1t8UIHSTAJTIgSgHRJfCTLamgQ9bkk6ppgqE6GogEg/tFUDCAGEAOIAQwy+wcuhHvnbACgGQAAAABJRU5ErkJggg==" />
  </xsl:template>

  <xsl:variable name="warningIcon">data:image/png;base64,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</xsl:variable>

  <xsl:variable name="warningIconHover" select="$warningIcon" />

  <xsl:variable name="collapseIconHover">data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDIzLjAuMywgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IgoJIHZpZXdCb3g9IjAgMCA0MCAyMCIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNDAgMjA7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIj4KCS5zdDB7ZmlsbC1ydWxlOmV2ZW5vZGQ7Y2xpcC1ydWxlOmV2ZW5vZGQ7fQo8L3N0eWxlPgo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNNi43LDIwTDIwLDYuN0wzMy4zLDIwSDQwTDIwLDBMMCwyMEg2Ljd6Ii8+Cjwvc3ZnPgo=</xsl:variable>

  <xsl:variable name="collapseIcon">data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDIzLjAuMywgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IgoJIHZpZXdCb3g9IjAgMCA0MCAyMCIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNDAgMjA7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIj4KCS5zdDB7ZmlsbC1ydWxlOmV2ZW5vZGQ7Y2xpcC1ydWxlOmV2ZW5vZGQ7ZmlsbDojMDU1MzgyO30KPC9zdHlsZT4KPHBhdGggY2xhc3M9InN0MCIgZD0iTTYuNywyMEwyMCw2LjdMMzMuMywyMEg0MEwyMCwwTDAsMjBMNi43LDIweiIvPgo8L3N2Zz4K</xsl:variable>

  <xsl:variable name="expandIcon">data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDIzLjAuMywgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IgoJIHZpZXdCb3g9IjAgMCA0MCAyMCIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNDAgMjA7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIj4KCS5zdDB7ZmlsbC1ydWxlOmV2ZW5vZGQ7Y2xpcC1ydWxlOmV2ZW5vZGQ7ZmlsbDojMDU1MzgyO30KPC9zdHlsZT4KPHBhdGggY2xhc3M9InN0MCIgZD0iTTYuNywwTDIwLDEzLjNMMzMuMywwSDQwTDIwLDIwTDAsMEw2LjcsMHoiLz4KPC9zdmc+Cg==</xsl:variable>

  <xsl:variable name="expandIconHover">data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDIzLjAuMywgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IgoJIHZpZXdCb3g9IjAgMCA0MCAyMCIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNDAgMjA7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIj4KCS5zdDB7ZmlsbC1ydWxlOmV2ZW5vZGQ7Y2xpcC1ydWxlOmV2ZW5vZGQ7fQo8L3N0eWxlPgo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNNi43LDBMMjAsMTMuM0wzMy4zLDBINDBMMjAsMjBMMCwwSDYuN3oiLz4KPC9zdmc+Cg==</xsl:variable>

  <xsl:variable name="toTopIcon">data:image/png;base64,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</xsl:variable>

  <xsl:variable name="toTopIconHover">data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC8AAAArCAYAAAGfseEsAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAKT2lDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVNnVFPpFj333vRCS4iAlEtvUhUIIFJCi4AUkSYqIQkQSoghodkVUcERRUUEG8igiAOOjoCMFVEsDIoK2AfkIaKOg6OIisr74Xuja9a89+bN/rXXPues852zzwfACAyWSDNRNYAMqUIeEeCDx8TG4eQuQIEKJHAAEAizZCFz/SMBAPh+PDwrIsAHvgABeNMLCADATZvAMByH/w/qQplcAYCEAcB0kThLCIAUAEB6jkKmAEBGAYCdmCZTAKAEAGDLY2LjAFAtAGAnf+bTAICd+Jl7AQBblCEVAaCRACATZYhEAGg7AKzPVopFAFgwABRmS8Q5ANgtADBJV2ZIALC3AMDOEAuyAAgMADBRiIUpAAR7AGDIIyN4AISZABRG8lc88SuuEOcqAAB4mbI8uSQ5RYFbCC1xB1dXLh4ozkkXKxQ2YQJhmkAuwnmZGTKBNA/g88wAAKCRFRHgg/P9eM4Ors7ONo62Dl8t6r8G/yJiYuP+5c+rcEAAAOF0ftH+LC+zGoA7BoBt/qIl7gRoXgugdfeLZrIPQLUAoOnaV/Nw+H48PEWhkLnZ2eXk5NhKxEJbYcpXff5nwl/AV/1s+X48/Pf14L7iJIEyXYFHBPjgwsz0TKUcz5IJhGLc5o9H/LcL//wd0yLESWK5WCoU41EScY5EmozzMqUiiUKSKcUl0v9k4t8s+wM+3zUAsGo+AXuRLahdYwP2SycQWHTA4vcAAPK7b8HUKAgDgGiD4c93/+8//UegJQCAZkmScQAAXkQkLlTKsz/HCAAARKCBKrBBG/TBGCzABhzBBdzBC/xgNoRCJMTCQhBCCmSAHHJgKayCQiiGzbAdKmAv1EAdNMBRaIaTcA4uwlW4Dj1wD/phCJ7BKLyBCQRByAgTYSHaiAFiilgjjggXmYX4IcFIBBKLJCDJiBRRIkuRNUgxUopUIFVIHfI9cgI5h1xGupE7yAAygvyGvEcxlIGyUT3UDLVDuag3GoRGogvQZHQxmo8WoJvQcrQaPYw2oefQq2gP2o8+Q8cwwOgYBzPEbDAuxsNCsTgsCZNjy7EirAyrxhqwVqwDu4n1Y8+xdwQSgUXACTYEd0IgYR5BSFhMWE7YSKggHCQ0EdoJNwkDhFHCJyKTqEu0JroR+cQYYjIxh1hILCPWEo8TLxB7iEPENyQSiUMyJ7mQAkmxpFTSEtJG0m5SI+ksqZs0SBojk8naZGuyBzmULCAryIXkneTD5DPkG+Qh8lsKnWJAcaT4U+IoUspqShnlEOU05QZlmDJBVaOaUt2ooVQRNY9aQq2htlKvUYeoEzR1mjnNgxZJS6WtopXTGmgXaPdpr+h0uhHdlR5Ol9BX0svpR+iX6AP0dwwNhhWDx4hnKBmbGAcYZxl3GK+YTKYZ04sZx1QwNzHrmOeZD5lvVVgqtip8FZHKCpVKlSaVGyovVKmqpqreqgtV81XLVI+pXlN9rkZVM1PjqQnUlqtVqp1Q61MbU2epO6iHqmeob1Q/pH5Z/YkGWcNMw09DpFGgsV/jvMYgC2MZs3gsIWsNq4Z1gTXEJrHN2Xx2KruY/R27iz2qqaE5QzNKM1ezUvOUZj8H45hx+Jx0TgnnKKeX836K3hTvKeIpG6Y0TLkxZVxrqpaXllirSKtRq0frvTau7aedpr1Fu1n7gQ5Bx0onXCdHZ4/OBZ3nU9lT3acKpxZNPTr1ri6qa6UbobtEd79up+6Ynr5egJ5Mb6feeb3n+hx9L/1U/W36p/VHDFgGswwkBtsMzhg8xTVxbzwdL8fb8VFDXcNAQ6VhlWGX4YSRudE8o9VGjUYPjGnGXOMk423GbcajJgYmISZLTepN7ppSTbmmKaY7TDtMx83MzaLN1pk1mz0x1zLnm+eb15vft2BaeFostqi2uGVJsuRaplnutrxuhVo5WaVYVVpds0atna0l1rutu6cRp7lOk06rntZnw7Dxtsm2qbcZsOXYBtuutm22fWFnYhdnt8Wuw+6TvZN9un2N/T0HDYfZDqsdWh1+c7RyFDpWOt6azpzuP33F9JbpL2dYzxDP2DPjthPLKcRpnVOb00dnF2e5c4PziIuJS4LLLpc+Lpsbxt3IveRKdPVxXeF60vWdm7Obwu2o26/uNu5p7ofcn8w0nymeWTNz0MPIQ+BR5dE/C5+VMGvfrH5PQ0+BZ7XnIy9jL5FXrdewt6V3qvdh7xc+9j5yn+M+4zw33jLeWV/MN8C3yLfLT8Nvnl+F30N/I/9k/3r/0QCngCUBZwOJgUGBWwL7+Hp8Ib+OPzrbZfay2e1BjKC5QRVBj4KtguXBrSFoyOyQrSH355jOkc5pDoVQfujW0Adh5mGLw34MJ4WHhVeGP45wiFga0TGXNXfR3ENz30T6RJZE3ptnMU85ry1KNSo+qi5qPNo3ujS6P8YuZlnM1VidWElsSxw5LiquNm5svt/87fOH4p3iC+N7F5gvyF1weaHOwvSFpxapLhIsOpZATIhOOJTwQRAqqBaMJfITdyWOCnnCHcJnIi/RNtGI2ENcKh5O8kgqTXqS7JG8NXkkxTOlLOW5hCepkLxMDUzdmzqeFpp2IG0yPTq9MYOSkZBxQqohTZO2Z+pn5mZ2y6xlhbL+xW6Lty8elQfJa7OQrAVZLQq2QqboVFoo1yoHsmdlV2a/zYnKOZarnivN7cyzytuQN5zvn//tEsIS4ZK2pYZLVy0dWOa9rGo5sjxxedsK4xUFK4ZWBqw8uIq2Km3VT6vtV5eufr0mek1rgV7ByoLBtQFr6wtVCuWFfevc1+1dT1gvWd+1YfqGnRs+FYmKrhTbF5cVf9go3HjlG4dvyr+Z3JS0qavEuWTPZtJm6ebeLZ5bDpaql+aXDm4N2dq0Dd9WtO319kXbL5fNKNu7g7ZDuaO/PLi8ZafJzs07P1SkVPRU+lQ27tLdtWHX+G7R7ht7vPY07NXbW7z3/T7JvttVAVVN1WbVZftJ+7P3P66Jqun4lvttXa1ObXHtxwPSA/0HIw6217nU1R3SPVRSj9Yr60cOxx++/p3vdy0NNg1VjZzG4iNwRHnk6fcJ3/ceDTradox7rOEH0x92HWcdL2pCmvKaRptTmvtbYlu6T8w+0dbq3nr8R9sfD5w0PFl5SvNUyWna6YLTk2fyz4ydlZ19fi753GDborZ752PO32oPb++6EHTh0kX/i+c7vDvOXPK4dPKy2+UTV7hXmq86X23qdOo8/pPTT8e7nLuarrlca7nuer21e2b36RueN87d9L158Rb/1tWeOT3dvfN6b/fF9/XfFt1+cif9zsu72Xcn7q28T7xf9EDtQdlD3YfVP1v+3Njv3H9qwHeg89HcR/cGhYPP/pH1jw9DBY+Zj8uGDYbrnjg+OTniP3L96fynQ89kzyaeF/6i/suuFxYvfvjV69fO0ZjRoZfyl5O/bXyl/erA6xmv28bCxh6+yXgzMV70VvvtwXfcdx3vo98PT+R8IH8o/2j5sfVT0Kf7kxmTk/8EA5jz/GMzLdsAAAAgY0hSTQAAeiUAAICDAAD5/wAAgOkAAHUwAADqYAAAOpgAABdvkl/FRgAABT1JREFUeNpki8EJwDAMxG7dQucxOQweKFkpoL7qQvoQCIQkSVV1nygiLtuMMRrbdLDN3pvXO8w5AVhr/Q/gOyQpMzl5AAAA//9sjsEJwDAMxG7LrmYwfngLL+EpPEdRX6GE5HuHhGRmz1EkSbcid0fLucbtqCoAZgYz2wmA7v6JiDiKMvP9AAAA//+Mj8EJwFAIQ/+SXaLzqCBxEzfw5kTp6UOF0lbIRfIgb5nZsamvRMQU724+3Rh7B9ydmTnKIvIObCGSrKrxB8ClqudfBwC8AAAA//+Uk70NAyEMhV1nxBskS0B1J4SFRMEaFPQIJFiCJVAkpwoiF5NcildZn/+eDasDOQsRt2Ho1QpSyjsYY2i2j9MrLoTYB4CI7EpLKTwwq/fOtvQBKKXesocQ1oDWmlJK1FobQIyRvPffW8o5D2AeeAnUWv8DfvhwgHPuwX3jWdZaAoDbEwAA//+klDEOgzAMRd2KuQfsDXqFquoSgSJYgoOcBRaEBCviFMCKOEylyl06QAmUtJb+ksFPsf0/AMChKIpHmqa7SXtuLs/zJwB4QEQXl2+4QMIw1KuApmm467pdquvaCoiiCFcBRMRa65niOGZE5CRJZu9E5A6YGqosy4VHqqpiY8zmiDYBiMjDMPC3GseREdEdMLV/3/eLxm3bsjFmERHOI/q03zQ/bY1/AtgWblusFaCUOrvE6l5lWca+71/hXUchxE1KqYIg+EtSSiWEuAPACQC8FwAAAP//3JY9boQwEIWnykH2HilznKXYjiqlRYOwwQXIiD9zFZAMBVwBjoBomVQrZRMDJss2QZoK6bP07PfeAACA67qXJEmuJm2yN0KIKyHkAgAAURTdpJSnSiOlxCAIPiFJktN1D8MQsyxDyPP8JfCiKNbhax271btGcM45Nk1jnJycc3M4YwyPfLrM2ZRFF8dCCKSU/vp3WPOfB9135LZtV4GH4YwxHIbhQYZxHLVSHIL7vo/TNGl1nuf5YS09BI/jGJdl2b3MNRNuwvu+R6UUVlWlhdZ1jUop7LoOdfFtZCLP81af359M9H0opVr43ov553CdW08z0VOR+6qySNMUgXNuSynRZEc3nbIs0XEcBwAAbNt+J4TQZ9v/vgFYlvUBAG9f7JjPqtpAFMbPoqu2T9BdF32Ggrs+TttdxU0RUnFlIHhngpNo4iSYWQqG+ACCmxgFt+Lqclu7UMgDiIuvm/5ZXK9ONV68pQPfMvBjcuac7ztERGQYxnPf9z9JKW+DIEAURVenIAggpbxzXfezYRgviYioXq+/9n3/Til10DFfg1zXhVIKvu+varXaW2q32x96vR4ukaIuIc/zoJSCZVk3JIR4/9Tgoyj6Ewp04Tudzt6AUISEEFoMJ8G7rgvG2IPLrXPPfD4HY+xyNy+EQJIkWrY1yzKkaYosy7TsbZIkey1uYfC//oDjOA+Kcw7OOUajETabDcbjMWzbBuf84HeHgm9h8IeMrJQSi8Vib1ksl0uEYahVGo8CL4QAYwxxHCPPc63azvMcw+EQnPOjm4CLwNu2DcdxMJlMsN1uT3qgu93u957kWMwopNsIIdDv97FarQrtNOv1GoPBQKv2z7p5x3HubfhM00SWZVqgaZrCsqx7sVTXmhT+YBlje9dn+850OoVt29rd5T/8PwvfarWQJMnRKTqbzRDH8Ukt8qJD6tjk/dtJqgv/8SlaYtM0b6harb7xPO+bUursW3kM/Qzb3yuVyjsiIiqXyy+azeYXKeVtGIZXl1+VUgjDEN1u92uj0WiUSqVXRPTsxwB6uappEcprFwAAAABJRU5ErkJggg==</xsl:variable>

  <xsl:template name="uriDecode">
    <xsl:param name="uri" />
    
    <xsl:variable name="quot">"</xsl:variable>
    <xsl:variable name="apos">'</xsl:variable>

    <xsl:variable name="decodeP20">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$uri" />
        <xsl:with-param name="replace" select="'%20'" />
        <xsl:with-param name="by" select="' '" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP21">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP20" />
        <xsl:with-param name="replace" select="'%21'" />
        <xsl:with-param name="by" select="'!'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP22">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP21" />
        <xsl:with-param name="replace" select="'%22'" />
        <xsl:with-param name="by" select="$quot" />
      </xsl:call-template>
    </xsl:variable>    

    <xsl:variable name="decodeP23">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP22" />
        <xsl:with-param name="replace" select="'%23'" />
        <xsl:with-param name="by" select="'#'" />
      </xsl:call-template>
    </xsl:variable>     

    <xsl:variable name="decodeP24">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP23" />
        <xsl:with-param name="replace" select="'%24'" />
        <xsl:with-param name="by" select="'$'" />
      </xsl:call-template>
    </xsl:variable>     

    <xsl:variable name="decodeP25">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP24" />
        <xsl:with-param name="replace" select="'%25'" />
        <xsl:with-param name="by" select="'%'" />
      </xsl:call-template>
    </xsl:variable>     

    <xsl:variable name="decodeP26">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP25" />
        <xsl:with-param name="replace" select="'%26'" />
        <xsl:with-param name="by" select="'&amp;'" />
      </xsl:call-template>
    </xsl:variable>    

    <xsl:variable name="decodeP27">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP26" />
        <xsl:with-param name="replace" select="'%27'" />
        <xsl:with-param name="by" select="$apos" />
      </xsl:call-template>
    </xsl:variable>    

    <xsl:variable name="decodeP28">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP27" />
        <xsl:with-param name="replace" select="'%28'" />
        <xsl:with-param name="by" select="'('" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP29">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP28" />
        <xsl:with-param name="replace" select="'%29'" />
        <xsl:with-param name="by" select="')'" />
      </xsl:call-template>
    </xsl:variable>    

    <xsl:variable name="decodeP2A">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP29" />
        <xsl:with-param name="replace" select="'%2A'" />
        <xsl:with-param name="by" select="'*'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP2B">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP2A" />
        <xsl:with-param name="replace" select="'%2B'" />
        <xsl:with-param name="by" select="'+'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP2C">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP2B" />
        <xsl:with-param name="replace" select="'%2C'" />
        <xsl:with-param name="by" select="','" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP2F">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP2C" />
        <xsl:with-param name="replace" select="'%2F'" />
        <xsl:with-param name="by" select="'/'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP3A">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP2F" />
        <xsl:with-param name="replace" select="'%3A'" />
        <xsl:with-param name="by" select="':'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP3B">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP3A" />
        <xsl:with-param name="replace" select="'%3B'" />
        <xsl:with-param name="by" select="';'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP3D">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP3B" />
        <xsl:with-param name="replace" select="'%3D'" />
        <xsl:with-param name="by" select="'='" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP3F">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP3D" />
        <xsl:with-param name="replace" select="'%3F'" />
        <xsl:with-param name="by" select="'?'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP40">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP3F" />
        <xsl:with-param name="replace" select="'%40'" />
        <xsl:with-param name="by" select="'@'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP5B">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP40" />
        <xsl:with-param name="replace" select="'%5B'" />
        <xsl:with-param name="by" select="'['" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodeP5D">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP5B" />
        <xsl:with-param name="replace" select="'%5D'" />
        <xsl:with-param name="by" select="']'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodePC3P84">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodeP5D" />
        <xsl:with-param name="replace" select="'%C3%84'" />
        <xsl:with-param name="by" select="'Ä'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="decodePC3P96">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePC3P84" />
        <xsl:with-param name="replace" select="'%C3%96'" />
        <xsl:with-param name="by" select="'Ö'" />
      </xsl:call-template>
    </xsl:variable>    

    <xsl:variable name="decodePC3P9C">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePC3P96" />
        <xsl:with-param name="replace" select="'%C3%9C'" />
        <xsl:with-param name="by" select="'Ü'" />
      </xsl:call-template>
    </xsl:variable> 

    <xsl:variable name="decodePC3PA4">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePC3P9C" />
        <xsl:with-param name="replace" select="'%C3%A4'" />
        <xsl:with-param name="by" select="'ä'" />
      </xsl:call-template>
    </xsl:variable>     

    <xsl:variable name="decodePC3PB6">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePC3PA4" />
        <xsl:with-param name="replace" select="'%C3%B6'" />
        <xsl:with-param name="by" select="'ö'" />
      </xsl:call-template>
    </xsl:variable>     

    <xsl:variable name="decodePC3PBC">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePC3PB6" />
        <xsl:with-param name="replace" select="'%C3%BC'" />
        <xsl:with-param name="by" select="'ü'" />
      </xsl:call-template>
    </xsl:variable>      

    <xsl:variable name="decodePC3P9F">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePC3PBC" />
        <xsl:with-param name="replace" select="'%C3%9F'" />
        <xsl:with-param name="by" select="'&#223;'" />
      </xsl:call-template>
    </xsl:variable>   
    
    <xsl:variable name="decodePC4">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePC3P9F" />
        <xsl:with-param name="replace" select="'%C4'" />
        <xsl:with-param name="by" select="'Ä'" />
      </xsl:call-template>
    </xsl:variable>    

    <xsl:variable name="decodePD6">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePC4" />
        <xsl:with-param name="replace" select="'%D6'" />
        <xsl:with-param name="by" select="'Ö'" />
      </xsl:call-template>
    </xsl:variable>   

    <xsl:variable name="decodePDC">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePD6" />
        <xsl:with-param name="replace" select="'%DC'" />
        <xsl:with-param name="by" select="'Ü'" />
      </xsl:call-template>
    </xsl:variable> 
    
    <xsl:variable name="decodePE4">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePDC" />
        <xsl:with-param name="replace" select="'%E4'" />
        <xsl:with-param name="by" select="'ä'" />
      </xsl:call-template>
    </xsl:variable>     

    <xsl:variable name="decodePF6">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePE4" />
        <xsl:with-param name="replace" select="'%F6'" />
        <xsl:with-param name="by" select="'ö'" />
      </xsl:call-template>
    </xsl:variable>     

    <xsl:variable name="decodePFC">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePF6" />
        <xsl:with-param name="replace" select="'%FC'" />
        <xsl:with-param name="by" select="'ü'" />
      </xsl:call-template>
    </xsl:variable>     

    <xsl:variable name="decodePDF">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$decodePFC" />
        <xsl:with-param name="replace" select="'%DF'" />
        <xsl:with-param name="by" select="'&#223;'" />
      </xsl:call-template>
    </xsl:variable> 
                    
    <xsl:value-of select="$decodePDF" />
        
  </xsl:template>
  
  <!-- Source: http://geekswithblogs.net/Erik/archive/2008/04/01/120915.aspx -->
  <xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />
    <xsl:choose>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text,$replace)" />
        <xsl:value-of select="$by" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,$replace)" />
          <xsl:with-param name="replace" select="$replace" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
