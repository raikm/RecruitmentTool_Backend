************
ELGA REFERENZ-STYLESHEET
------------------------
Version: V1.09.001
************

Nutzungsbedingungen:
--------------------
Das "ELGA Referenz-Stylesheet" wird von der ELGA GmbH bis auf Widerruf unentgeltlich und nicht-exklusiv sowie zeitlich und �rtlich unbegrenzt, jedoch beschr�nkt auf Verwendungen f�r die Zwecke der "Clinical Document Architecture" (CDA) zur Verf�gung gestellt. Ver�nderungen f�r die lokale Verwendung sind zul�ssig. Derartige Ver�nderungen (sogenannte bearbeitete Fassungen) d�rfen ihrerseits publiziert und Dritten zur Weiterverwendung und Bearbeitung zur Verf�gung gestellt werden. 
Bei der Ver�ffentlichung von bearbeiteten Fassungen ist darauf hinzuweisen, dass diese auf Grundlage des von der ELGA GmbH publizierten "ELGA Referenz-Stylesheet" erstellt wurden.
Die Anwendung sowie die allf�llige Bearbeitung des "ELGA Referenz-Stylesheet" erfolgt in ausschlie�licher Verantwortung der AnwenderInnen. Aus der Ver�ffentlichung, Verwendung und/oder Bearbeitung k�nnen keinerlei Rechtsanspr�che gegen die ELGA GmbH erhoben oder abgeleitet werden.

************
Optionen:
---------

Das Verhalten des Referenzstylesheets kann �ber folgende Optionen gesteuert werden (Bitte in der Datei ein- oder auskommentieren):
- ShowRevisionMarks: eingef�gten und gel�schten Text anzeigen
- use external css: Externes CSS aktivieren
- print icon visibility: Druck-Icon ausblenden
- isdeprecated: Status des Dokuments (g�ltig oder storniert)
- enableInfoButton: Anzeige eines Info-Button bei Laborbefund EIS Full Support (Link auf Seite im Gesundheitsportal)
- LOINCResolutionUrl: URL zur Aufl�sung bei InfoButton
- sectionTitleWhiteBackgroundColor: Section �berschrift kann mit grauem (default) oder wei�em Hintergrund angezeigt werden

**
ACHTUNG, f�r das Setzen der folgenden Optionen beachten Sie bitte die untenstehenden Hinweise!
- strict mode: wenn aktiviert, werden ung�ltige Dokumente nicht angezeigt (default: aktiviert)
- showTableInBestGuess: wenn aktiviert, werden ung�ltige Tabellen angezeigt ("in best guess mode") (default: deaktiviert)

ACHTUNG:
F�r das Setzen der Optionen strict mode: disabled und showTableInBestGuess: enabled  ist unbedingt Folgendes zu beachten:
Mit dieser Einstellung werden auch ung�ltige Tabellen, z.B.: mit unterschiedlicher Spaltenanzahl innerhalb einer Tabelle im "best guess" Modus angezeigt.
Der Inhalt kann dadurch unter Umst�nden fehlerhaft interpretiert werden. 
Diese Tabellen werden durch das Stylesheet mit einem Warnhinweis versehen angezeigt.
Das Umstellen dieser beiden Optionen ist aus haftungsrechtlichen Gr�nden dringend mit dem Verantwortlichen/Ihrem Vorgesetzten abzustimmen. Bei Fragen wenden Sie sich an cda@elga.gv.at.
**

************
Das ELGA Referenz-Stylesheet wurde erfolgreich mit folgenden XSLT Prozessoren getestet:
- Saxon, Versionen 6.5.5 und 9.6.0.7
- Xsltproc
- .NET 1.0
- MSXML 3.0

************
Known Issues
************
Optimale Darstellungsergebnisse werden bei Verwendung von Firefox erreicht.

- Bei der Darstellung mittels Internet Explorer ist zu beachten:
  Bei der Darstellung von lokal gespeicherten Dateien muss folgende Einstellung f�r JavaScript getroffen werden:
  Internetoptionen -> Erweitert -> unter Sicherheit: Ausf�hrung aktiver Inhalte in Dateien auf dem lokalen Computer zulassen
- Beim Speichern von eingebetteten Dateien wird im Internet Explorer wird keine Dateiendung an die Datei geh�ngt

- Microsoft Spartan unterst�tzt keine XSL Transformationen. Ein zu einer HTML-Datei transformiertes Stylesheet wird aber fehlerfrei angezeigt.

- Bei der Darstellung in den verschiedenen Browsern, m�ssen einige Einstellungen beachtet werden, damit das Stylesheet richtig angezeigt wird (siehe Changelog_CDA Visualization_2019-09)

************
Change-Log
************
1.09.001
siehe beiliegendes PDF Dokument "Changelog_CDA Visaulization_2020-04"

1.08.004
siehe beiliegendes PDF Dokument "Changelog_CDA Visaulization_2019-11"

1.08.003.1
siehe beiliegendes PDF Dokument "Changelog_CDA Visaulization_2019-10"

1.08.002.4
siehe beiliegendes PDF Dokument "Changelog_CDA Visualization_2019-05"

1.07.004.1
keine �nderungen im e-Befund Stylesheet

1.07.003.1
keine �nderungen im e-Befund Stylesheet

1.07.002.1
- Die hinterlegten Value Sets im Stylesheet werden bei jedem Deploy des Stylesheets aktualisiert.
- Die Bildunterschriften werden nun angezeigt.
- Korrektur: Die Warnung � The child axis starting at an attribute node will never select anything� wurde behoben.
- Der InfoButton-Link im Laborbefund wurde auf das Produktivsystem des Gesundheitsportals (www.gesundheit.gv.at) umgestellt.
- Die getroffenen Einstellungen/Parameter werden nun in HTML und PDF angezeigt (am Ende des Dokuments)
- Ein InfoButton Dialog wurde f�r den Laborbefund eingef�hrt. Die Infoseite �ffnet sich erst nach Best�tigung.

1.07.001
- Die �SetId� wird nun in den Dokumentinformationen angezeigt.
- Der Abstand vor abschlie�enden Bemerkungen wurde verkleinert
- Korrektur: Die Links auf eingeklappte Elemente haben in manchen F�llen nicht funktioniert.
- Korrektur: Der Link auf die Subsektion Risiken hat in manchen F�llen nicht funktioniert.

1.06.005
- Ein fehlerhafter Abstand im Patientenblock wurde behoben.

V1.06.004.1
- �nderung der Relations-Aufl�sung beim Infobutton

V1.06.004
- Sachwalter umbenennen in "Erwachsenenvertreter"
- Anzeige bei unbekanntem Auftraggeber vereinheitlicht
- Korrektur: Hochgestellte Tabellen wurden im PDF �ber Fu�zeile gedruckt
- Anzeige der Sprachf�higkeit von Patienten erm�glicht
- Mouse-over Information bei Infobutton (Lbaorbefund) eingef�gt
- Optimiert: Anzeige mehrerer Unterzeichner, wenn kein rechtlicher Unterzeichner angegeben wird.

V1.06.003
- Text in Tabellen in PDF wird besser an Zeilenbreite angepasst
- Textumbruch in Tabellen in PDF verbessert
- Weitere Behandler werden jetzt angezeigt
- Tausch des Infobutton-Icon
- Es k�nnen nun Tabellen angezeigt werden, die eine unterschiedliche Spaltenanzahl im Body und Header haben. Siehe Parameter �enableShowTableInBestGuess()� 
- Die Warnung �You did not close a PDF Document� wurde behoben

V1.06.002.1
- Anzeige eines Info-Button bei Laborbefund EIS Full Support erm�glicht: Link auf Seite im Gesundheitsportal, siehe Parameter param_enableInfoButton
- Tabellen mit Spaltenbreiten gr��er als 100% werden nun besser skaliert.
- Die Anzeige der Dosierung wurde verbessert

V1.06.001.1
- Die nicht genutzte Variable �tagname� wurde entfernt.

V1.06.001
- Korrektur: Wenn f�r das Land (state) ein Nullflavor angegeben wurde, wurde ein Beistrich nach der Stadt angezeigt.
- Die Darstellung bei nicht vorhandenem Empf�nger wurde im Stylesheet dem PDF angepasst.
- Bei den Kontaktdaten der f�r den Aufenthalt verantwortlichen Person (/n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:telecom) wurden die Kontaktdaten der Organisation (n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:serviceProviderOrganization ) angezeigt.
- Die URL des Base64-Decoders f�r Attachments kann nun mit einem Parameter an gesetzt werden.
- Korrektur: F�r ein EIS Basic Dokument wurde im CDA2PDF u.a. "Full Support" angegeben.
- Korrektur: Wenn ein Datums-Wert mit einem Nullflavor angegeben wurde, wurde ein "." angezeigt.

V1.05.006
- Darstellung mehrerer Authenticator Elemente erm�glicht, als "unterzeichnet von" untereinander
- Fu�noten wiederholten sich bei Tabellen �ber mehrere Seiten und werden nun nur mehr am Ende der Tabelle angezeigt.
- Bis zu dieser Version orientierte sich die Anzeige des Auftraggeber Elements im Laborbefund an der templateId des Elements 1.3.6.1.4.1.19376.1.3.3.1.6, was nicht funktionierte, wenn der Auftraggeber mit nullFlavor angegeben wurde. Ab dieser Version wird h�ngt die Anzeige des Auftraggeber Elements an der Document-Level templateId
- �berarbeitung Anzeige der Fachrichtung und Rolle des Autors
- Ein langer Erstellernamen �berdeckt f�hrt nicht mehr zu einer fehlerhaften Darstellung
- Im Stylesheet wurde der Tag version=�1.0� entfernt, um die Transformation mit Saxon9 wieder zu erm�glichen.

V1.05.004
- Fehlerrobustheit: Unterschiedliche Spaltenanzahl in einer Tabelle
- Fu�notentexte kleiner (90%)
- Korrektur - HTML-Links implementieren

V1.05.003
- Fehlerhafte Umschl�sselung der DocumentLevel Template ID / EIS f�r Befund Bildgebende Diagnostik
- Tabellendarstellung: Korrekte Darstellung des Footers
- Tippfehler "Begin der Leistung"
- Medientype Unterst�tzung (v.a. text/xml)
- Familienname des Patienten fettgedruckt
- Tabellendarstellung - COLSPAN (zus�tzliche Attribute)

V1.05.002
- Speichern von eingebetteten PDF-Dateien: Dateiendung fehlte im IE

V1.05.001
- Barriefreiheit: Alternativtext zu Grafiken
- HTML-Links Funktion korrigiert

V1.04.011
- Anzeige der Service Events im Labor (Schlagw�rter)
- Mehrzeiliger Dokumententitel - Zeilenh�he zu gering
- Anzeige der EIS

V1.04.010
- neue Icons

V1.04.009
- Verhalten bei mehreren Autoren
- Anzeige von author.assignedAuthor.code und author.functionCode
- Darstellung von Ger�ten/Software als Autor
- IntendedRecipient ("Ergeht an") nur Person ohne Organisation besser darstellen
- Tabellendarstellung - COLSPAN (zus�tzliche Attribute)

V1.04.008
- URI Sonderzeichen Decodierung in Telecom-Elementen
- Ansprechpartner Einr�ckung auf Linie von �Unterzeichnet von�
- Dokumentinformationen ausklappbar unter �Schlagw�rter�
- Rahmen verschm�lern/entfernen, Farben reduzieren
- neue Icons
- (Usability) Einr�ckungen und Gr��e der �berschriften

V1.04.007
- Anzeige des Risiko im Pflegesituationsbericht
- URI Sonderzeichen Decodierung in Telecom-Elementen
- Reduzierung der R�cksprunglinks durch einen R�cksprungbutton
- Korrektur von Tippfehlern
- "gesetzlicher Vetreter" in Patientenbox in n�chster Zeile angezeigt
- Aufnahme von neuen Dokumententypen und Dokumentenklassen (LOINC)

V1.04.006
- Verbesserung der Darstellung mit Option "hideheader"
- Verbesserung der Darstellung mit Option "isdeprecated"
- Beschriftung "Verantwortliche Person" bei Aufenthalt
- Leerzeichen in ID-Attribut entfernt

V1.04.005
- In Adress-Elementen kann "%20" als Leerzeichen verwendet werden
- Web-Links werden standardm��ig in einem neuen Tab ge�ffnet
- Anpassungen f�r den Pflegesituationsbericht
- Verbesserungen in der Darstellung von Adressen

V1.04.004
- Korrigiert: Anzeige der Uhrzeit bei 0:00 Uhr
- Korrigiert. Kein Beistrich nach Adresse, wenn Bundesland mit NullFlavor angegeben
- Korrigiert: Medientyp image/gif und image/png k�nnen angegeben werden

V1.04.003
- in Telefonnummer etc. k�nnen Leerzeichen als %20 angegeben werden
- Custodian wird als "Verwahrer des Dokuments" angezeigt
- Die Document-Level Templates f�r die Dokumentenklasse und die EIS werden verk�rzt (nicht mehr separat) dargestellt

V1.04.000
- Darstellung von subscript erm�glicht
- Tabellen werden allgemein mit valign top dargestellt
- Statt "Sachwalter" wird der Begriff "gesetzlicher Vertreter" verwendet

V1.03.010
- Tastaturfokus ist besser sichtbar 
- Anpassung bei der Darstellung des Autors (lange Organisationsnamen)

V1.03.008
- Anforderung ELGA-Portal: M�glichkeit der Kennzeichnung von stornierten Dokumenten (document state)
- Aktualisierung der  �bersetzung der Klassifkation der Angeh�rigen (personalRelationship)
- Anforderung ELGA-Portal: Folgende Variablen k�nnen durch Parameter �berschrieben werden: showrevisionmarks, useexternalcss, hideheader, printiconvisibility

V1.03.007
- Technisches Problem bei Transformation von ELGA CDA nach HTML behoben
- Zus�tzliche Adresse "TMP" wird als Pflegeadresse angezeigt, �berschrift "Pflegeadresse"
- Wortlaut der Warnung bei "Allergien, Unvertr�glichkeiten und Risiken" an den Titel der entsprechenden Sektion angepasst

V1.03.006
- neue Hinweistexte bei Video- und Audiodateien

V1.03.005
- Zus�tzliche Adresse "TMP" wird als Pflegeadresse angezeigt
- Optionsschalter zum Ausblenden des Druck-Icons
- neue Hinweistexte f�r EIS Basic und Structured

V1.03.004
- Optimierung im Hinblick auf Security Themen
- Optionschalter zur Verwendung externer CSS

V1.03.003
- Audio- und Videodateien (video/mpeg, audio/mpeg) werden als Download zur Verf�gung gestellt
- Allergien und Unvertr�glichkeiten werden dargestellt wie Risiken
- Wenn eine Aktivierung von Javascript notwendig ist, wird im Befund ein entsprechender Hinweis angezeigt
- Tabellen werden nun auch im IE mit alternierenden Hintergrundfarben angezeigt

V1.03.002
- Vereinheitlichung der Benennung von Base64 Decoder
- Darstellungsoptimierung bei ausgeblendeten Headerdaten
- Erweiterung f�r e-Medikation
- Behandlung von abweichenden Dokumentenklassen
- Verbesserungen bei der Darstellung mit Internet Explorer

V1.03.001
- Headerdaten k�nnen ab jetzt ausgeblendet werden (Die Anzeige beginnt dann direkt beim Ersteller/Empf�nger):
- Anzeige von eingef�gtem und gel�schten Text optional m�glich
- Korrigiert: Lange Texte in der Box f�r den Ansprechpartner werden abgeteilt
 
V1.02.012
- �nderung des PDF herunterladen Links: "Dokument anzeigen"

V1.02.011
- ServiceEvent/code wird als Schlagw�rter (Services) unter "zus�tzliche Informationen zu diesem Dokument" dargestellt
- Verbesserungen im Bereich der Accessability

V1.02.010
-Korrigiert: Aufgetretene Warnings durch StyleCode xELGA_red
-Optimiert: Erkennung von Mehreren Risiken innerhalb eines Dokuments
-Optimiert: Skalierung von eingebetteten Bildern
-Optimiert: Erkennung von eingebetteten Video- und Audiodateien 

V1.02.009
- Anzeigetexte pr�zisiert (u.a. Texte bei Geschlecht und Versicherungsgesellschaft/Inhaber)
- Korrigiert: Verhalten bei unbekannter Dokument-TemplateID und unbekannter EIS
- Vereinheitlichung der Zeilenumbr�cke bei "Aufenthalt" 

V1.02.008
- Korrigiert: Tabellenformatierung mit styleCode="xELGA_tabVertical"
- Optimierung der Abst�nde zwischen Bl�cken bei Darstellung im Internet Explorer
- Korrigiert: Darstellung von Listen ohne Angabe von @listType
- Optimierung der Darstellung von Fu�noten
- Vereinheitlichung der Darstellung von Hauptteil und Anhang
- Optimierung der Darstellung von Icons

V1.02.007
- Korrigiert: Anzeige des Geburtsortes in Adress-Granularit�tsstufe 1
- Erg�nzt: Mouseover f�r Kontaktperson
- Formatierung: Patienteninformation auf erster Seite kleiner, Einr�ckung der Adressbl�cke und �berschriften, blaue Balken f�r Unterzeichner etc. 
- Anpassung des Abstandes bei den Bl�cken "Risiken" und  "F�r Fragen kontaktieren Sie bitte:"
- Darstellung des ELGA Logos optimiert
- Vereinheitlichung: Doppelpunkte bei den Datenbl�cken
- Korrektur des ELGA styleCodes "xELGA_colw:XX"

V1.02.006
- Optimierung von HTML Links und deren Formatierung
- Umsetzung der expliziten Angabe der Spaltenbreite
- Optimierung der Abst�nde bei Brieftext und abschlie�enden Bemerkungen

V1.02.005
- Der Link "http://elga.vserver40.local.netconomy.net/elgaWeb/xsltBase64Encoder" wurde entfernt
Ein Erkl�rungstext wurde eingef�gt: "F�r das Generieren eines PDF-Download-Links muss ein Servlet zur Decodierung von Base64 codiertem PDF bereitgestellt werden. Codebeispiele f�r das Servlet finden Sie auf www.elga.gv.at"
- Optimierung der styleCodes in Tabellen
- �nderungen bei der Darstellung der Uhrzeit:
	1) Uhrzeit wird immer in der Form "hh:mm Uhr" dargestellt
	2) Uhrzeit bei Aufenthalt im Block "Patient" entfernt
	3) Bemi Geburtsdatum wird die Uhrzeit angezeigt, wenn vorhanden

V1.02.004
- styleCodes sind nicht mehr case sensitive
- Anzeigen der ELGA Interoperabilit�tsstufe (EIS)
- styleCode Kapit�lchen (und Kombination Unterstrichen, Kapit�lchen) umgesetzt
- Die Icons, die den Warnungen auf der ersten Seite zugewiesen wurden, wurden auch links neben den �berschriften eingef�gt
- Warnungen und die dazugeh�rigen �berschriften wurden gleich bezeichnet
- Anzeige der Versionsnummer des Referenz-Stylesheets bei den technischen Daten
- Mouseover bei der Kontaktperson bzw. dem Fachlichen Ansprechpartner erg�nzt:
	Neuer Text: "Fachliche(r) Ansprechpartner(in) f�r dieses Dokument"
- Ausf�hrlicherer Dokumententitel f�r bessere Unterscheidung zwischen Entlassungsbrief Pflege und �rztlich (Beispiel: Entlassungsbrief aus station�rer Behandlung (�rztlich)
- Die Anzeige �keine automatischen Warnungen� erscheint nur mehr in Entlassungsbriefen
- Das verwendete Dokumententemplate wird angezeigt 
- Konsolidierung der Identifikation der participants
- Neue Icons f�r Risiko und Patientenverf�gung integriert
- Hinzuf�gen von styleCodes f�r die Formatierung von Listen