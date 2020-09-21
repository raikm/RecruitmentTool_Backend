************
ELGA REFERENZ-STYLESHEET
------------------------
Version: V1.09.001
************

Nutzungsbedingungen:
--------------------
Das "ELGA Referenz-Stylesheet" wird von der ELGA GmbH bis auf Widerruf unentgeltlich und nicht-exklusiv sowie zeitlich und örtlich unbegrenzt, jedoch beschränkt auf Verwendungen für die Zwecke der "Clinical Document Architecture" (CDA) zur Verfügung gestellt. Veränderungen für die lokale Verwendung sind zulässig. Derartige Veränderungen (sogenannte bearbeitete Fassungen) dürfen ihrerseits publiziert und Dritten zur Weiterverwendung und Bearbeitung zur Verfügung gestellt werden. 
Bei der Veröffentlichung von bearbeiteten Fassungen ist darauf hinzuweisen, dass diese auf Grundlage des von der ELGA GmbH publizierten "ELGA Referenz-Stylesheet" erstellt wurden.
Die Anwendung sowie die allfällige Bearbeitung des "ELGA Referenz-Stylesheet" erfolgt in ausschließlicher Verantwortung der AnwenderInnen. Aus der Veröffentlichung, Verwendung und/oder Bearbeitung können keinerlei Rechtsansprüche gegen die ELGA GmbH erhoben oder abgeleitet werden.

************
Optionen:
---------

Das Verhalten des Referenzstylesheets kann über folgende Optionen gesteuert werden (Bitte in der Datei ein- oder auskommentieren):
- ShowRevisionMarks: eingefügten und gelöschten Text anzeigen
- use external css: Externes CSS aktivieren
- print icon visibility: Druck-Icon ausblenden
- isdeprecated: Status des Dokuments (gültig oder storniert)
- enableInfoButton: Anzeige eines Info-Button bei Laborbefund EIS Full Support (Link auf Seite im Gesundheitsportal)
- LOINCResolutionUrl: URL zur Auflösung bei InfoButton
- sectionTitleWhiteBackgroundColor: Section Überschrift kann mit grauem (default) oder weißem Hintergrund angezeigt werden

**
ACHTUNG, für das Setzen der folgenden Optionen beachten Sie bitte die untenstehenden Hinweise!
- strict mode: wenn aktiviert, werden ungültige Dokumente nicht angezeigt (default: aktiviert)
- showTableInBestGuess: wenn aktiviert, werden ungültige Tabellen angezeigt ("in best guess mode") (default: deaktiviert)

ACHTUNG:
Für das Setzen der Optionen strict mode: disabled und showTableInBestGuess: enabled  ist unbedingt Folgendes zu beachten:
Mit dieser Einstellung werden auch ungültige Tabellen, z.B.: mit unterschiedlicher Spaltenanzahl innerhalb einer Tabelle im "best guess" Modus angezeigt.
Der Inhalt kann dadurch unter Umständen fehlerhaft interpretiert werden. 
Diese Tabellen werden durch das Stylesheet mit einem Warnhinweis versehen angezeigt.
Das Umstellen dieser beiden Optionen ist aus haftungsrechtlichen Gründen dringend mit dem Verantwortlichen/Ihrem Vorgesetzten abzustimmen. Bei Fragen wenden Sie sich an cda@elga.gv.at.
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
  Bei der Darstellung von lokal gespeicherten Dateien muss folgende Einstellung für JavaScript getroffen werden:
  Internetoptionen -> Erweitert -> unter Sicherheit: Ausführung aktiver Inhalte in Dateien auf dem lokalen Computer zulassen
- Beim Speichern von eingebetteten Dateien wird im Internet Explorer wird keine Dateiendung an die Datei gehängt

- Microsoft Spartan unterstützt keine XSL Transformationen. Ein zu einer HTML-Datei transformiertes Stylesheet wird aber fehlerfrei angezeigt.

- Bei der Darstellung in den verschiedenen Browsern, müssen einige Einstellungen beachtet werden, damit das Stylesheet richtig angezeigt wird (siehe Changelog_CDA Visualization_2019-09)

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
keine Änderungen im e-Befund Stylesheet

1.07.003.1
keine Änderungen im e-Befund Stylesheet

1.07.002.1
- Die hinterlegten Value Sets im Stylesheet werden bei jedem Deploy des Stylesheets aktualisiert.
- Die Bildunterschriften werden nun angezeigt.
- Korrektur: Die Warnung „ The child axis starting at an attribute node will never select anything” wurde behoben.
- Der InfoButton-Link im Laborbefund wurde auf das Produktivsystem des Gesundheitsportals (www.gesundheit.gv.at) umgestellt.
- Die getroffenen Einstellungen/Parameter werden nun in HTML und PDF angezeigt (am Ende des Dokuments)
- Ein InfoButton Dialog wurde für den Laborbefund eingeführt. Die Infoseite öffnet sich erst nach Bestätigung.

1.07.001
- Die „SetId“ wird nun in den Dokumentinformationen angezeigt.
- Der Abstand vor abschließenden Bemerkungen wurde verkleinert
- Korrektur: Die Links auf eingeklappte Elemente haben in manchen Fällen nicht funktioniert.
- Korrektur: Der Link auf die Subsektion Risiken hat in manchen Fällen nicht funktioniert.

1.06.005
- Ein fehlerhafter Abstand im Patientenblock wurde behoben.

V1.06.004.1
- Änderung der Relations-Auflösung beim Infobutton

V1.06.004
- Sachwalter umbenennen in "Erwachsenenvertreter"
- Anzeige bei unbekanntem Auftraggeber vereinheitlicht
- Korrektur: Hochgestellte Tabellen wurden im PDF über Fußzeile gedruckt
- Anzeige der Sprachfähigkeit von Patienten ermöglicht
- Mouse-over Information bei Infobutton (Lbaorbefund) eingefügt
- Optimiert: Anzeige mehrerer Unterzeichner, wenn kein rechtlicher Unterzeichner angegeben wird.

V1.06.003
- Text in Tabellen in PDF wird besser an Zeilenbreite angepasst
- Textumbruch in Tabellen in PDF verbessert
- Weitere Behandler werden jetzt angezeigt
- Tausch des Infobutton-Icon
- Es können nun Tabellen angezeigt werden, die eine unterschiedliche Spaltenanzahl im Body und Header haben. Siehe Parameter „enableShowTableInBestGuess()“ 
- Die Warnung „You did not close a PDF Document“ wurde behoben

V1.06.002.1
- Anzeige eines Info-Button bei Laborbefund EIS Full Support ermöglicht: Link auf Seite im Gesundheitsportal, siehe Parameter param_enableInfoButton
- Tabellen mit Spaltenbreiten größer als 100% werden nun besser skaliert.
- Die Anzeige der Dosierung wurde verbessert

V1.06.001.1
- Die nicht genutzte Variable „tagname“ wurde entfernt.

V1.06.001
- Korrektur: Wenn für das Land (state) ein Nullflavor angegeben wurde, wurde ein Beistrich nach der Stadt angezeigt.
- Die Darstellung bei nicht vorhandenem Empfänger wurde im Stylesheet dem PDF angepasst.
- Bei den Kontaktdaten der für den Aufenthalt verantwortlichen Person (/n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:telecom) wurden die Kontaktdaten der Organisation (n1:ClinicalDocument/n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:serviceProviderOrganization ) angezeigt.
- Die URL des Base64-Decoders für Attachments kann nun mit einem Parameter an gesetzt werden.
- Korrektur: Für ein EIS Basic Dokument wurde im CDA2PDF u.a. "Full Support" angegeben.
- Korrektur: Wenn ein Datums-Wert mit einem Nullflavor angegeben wurde, wurde ein "." angezeigt.

V1.05.006
- Darstellung mehrerer Authenticator Elemente ermöglicht, als "unterzeichnet von" untereinander
- Fußnoten wiederholten sich bei Tabellen über mehrere Seiten und werden nun nur mehr am Ende der Tabelle angezeigt.
- Bis zu dieser Version orientierte sich die Anzeige des Auftraggeber Elements im Laborbefund an der templateId des Elements 1.3.6.1.4.1.19376.1.3.3.1.6, was nicht funktionierte, wenn der Auftraggeber mit nullFlavor angegeben wurde. Ab dieser Version wird hängt die Anzeige des Auftraggeber Elements an der Document-Level templateId
- Überarbeitung Anzeige der Fachrichtung und Rolle des Autors
- Ein langer Erstellernamen überdeckt führt nicht mehr zu einer fehlerhaften Darstellung
- Im Stylesheet wurde der Tag version=“1.0“ entfernt, um die Transformation mit Saxon9 wieder zu ermöglichen.

V1.05.004
- Fehlerrobustheit: Unterschiedliche Spaltenanzahl in einer Tabelle
- Fußnotentexte kleiner (90%)
- Korrektur - HTML-Links implementieren

V1.05.003
- Fehlerhafte Umschlüsselung der DocumentLevel Template ID / EIS für Befund Bildgebende Diagnostik
- Tabellendarstellung: Korrekte Darstellung des Footers
- Tippfehler "Begin der Leistung"
- Medientype Unterstützung (v.a. text/xml)
- Familienname des Patienten fettgedruckt
- Tabellendarstellung - COLSPAN (zusätzliche Attribute)

V1.05.002
- Speichern von eingebetteten PDF-Dateien: Dateiendung fehlte im IE

V1.05.001
- Barriefreiheit: Alternativtext zu Grafiken
- HTML-Links Funktion korrigiert

V1.04.011
- Anzeige der Service Events im Labor (Schlagwörter)
- Mehrzeiliger Dokumententitel - Zeilenhöhe zu gering
- Anzeige der EIS

V1.04.010
- neue Icons

V1.04.009
- Verhalten bei mehreren Autoren
- Anzeige von author.assignedAuthor.code und author.functionCode
- Darstellung von Geräten/Software als Autor
- IntendedRecipient ("Ergeht an") nur Person ohne Organisation besser darstellen
- Tabellendarstellung - COLSPAN (zusätzliche Attribute)

V1.04.008
- URI Sonderzeichen Decodierung in Telecom-Elementen
- Ansprechpartner Einrückung auf Linie von „Unterzeichnet von“
- Dokumentinformationen ausklappbar unter „Schlagwörter“
- Rahmen verschmälern/entfernen, Farben reduzieren
- neue Icons
- (Usability) Einrückungen und Größe der Überschriften

V1.04.007
- Anzeige des Risiko im Pflegesituationsbericht
- URI Sonderzeichen Decodierung in Telecom-Elementen
- Reduzierung der Rücksprunglinks durch einen Rücksprungbutton
- Korrektur von Tippfehlern
- "gesetzlicher Vetreter" in Patientenbox in nächster Zeile angezeigt
- Aufnahme von neuen Dokumententypen und Dokumentenklassen (LOINC)

V1.04.006
- Verbesserung der Darstellung mit Option "hideheader"
- Verbesserung der Darstellung mit Option "isdeprecated"
- Beschriftung "Verantwortliche Person" bei Aufenthalt
- Leerzeichen in ID-Attribut entfernt

V1.04.005
- In Adress-Elementen kann "%20" als Leerzeichen verwendet werden
- Web-Links werden standardmäßig in einem neuen Tab geöffnet
- Anpassungen für den Pflegesituationsbericht
- Verbesserungen in der Darstellung von Adressen

V1.04.004
- Korrigiert: Anzeige der Uhrzeit bei 0:00 Uhr
- Korrigiert. Kein Beistrich nach Adresse, wenn Bundesland mit NullFlavor angegeben
- Korrigiert: Medientyp image/gif und image/png können angegeben werden

V1.04.003
- in Telefonnummer etc. können Leerzeichen als %20 angegeben werden
- Custodian wird als "Verwahrer des Dokuments" angezeigt
- Die Document-Level Templates für die Dokumentenklasse und die EIS werden verkürzt (nicht mehr separat) dargestellt

V1.04.000
- Darstellung von subscript ermöglicht
- Tabellen werden allgemein mit valign top dargestellt
- Statt "Sachwalter" wird der Begriff "gesetzlicher Vertreter" verwendet

V1.03.010
- Tastaturfokus ist besser sichtbar 
- Anpassung bei der Darstellung des Autors (lange Organisationsnamen)

V1.03.008
- Anforderung ELGA-Portal: Möglichkeit der Kennzeichnung von stornierten Dokumenten (document state)
- Aktualisierung der  Übersetzung der Klassifkation der Angehörigen (personalRelationship)
- Anforderung ELGA-Portal: Folgende Variablen können durch Parameter überschrieben werden: showrevisionmarks, useexternalcss, hideheader, printiconvisibility

V1.03.007
- Technisches Problem bei Transformation von ELGA CDA nach HTML behoben
- Zusätzliche Adresse "TMP" wird als Pflegeadresse angezeigt, Überschrift "Pflegeadresse"
- Wortlaut der Warnung bei "Allergien, Unverträglichkeiten und Risiken" an den Titel der entsprechenden Sektion angepasst

V1.03.006
- neue Hinweistexte bei Video- und Audiodateien

V1.03.005
- Zusätzliche Adresse "TMP" wird als Pflegeadresse angezeigt
- Optionsschalter zum Ausblenden des Druck-Icons
- neue Hinweistexte für EIS Basic und Structured

V1.03.004
- Optimierung im Hinblick auf Security Themen
- Optionschalter zur Verwendung externer CSS

V1.03.003
- Audio- und Videodateien (video/mpeg, audio/mpeg) werden als Download zur Verfügung gestellt
- Allergien und Unverträglichkeiten werden dargestellt wie Risiken
- Wenn eine Aktivierung von Javascript notwendig ist, wird im Befund ein entsprechender Hinweis angezeigt
- Tabellen werden nun auch im IE mit alternierenden Hintergrundfarben angezeigt

V1.03.002
- Vereinheitlichung der Benennung von Base64 Decoder
- Darstellungsoptimierung bei ausgeblendeten Headerdaten
- Erweiterung für e-Medikation
- Behandlung von abweichenden Dokumentenklassen
- Verbesserungen bei der Darstellung mit Internet Explorer

V1.03.001
- Headerdaten können ab jetzt ausgeblendet werden (Die Anzeige beginnt dann direkt beim Ersteller/Empfänger):
- Anzeige von eingefügtem und gelöschten Text optional möglich
- Korrigiert: Lange Texte in der Box für den Ansprechpartner werden abgeteilt
 
V1.02.012
- Änderung des PDF herunterladen Links: "Dokument anzeigen"

V1.02.011
- ServiceEvent/code wird als Schlagwörter (Services) unter "zusätzliche Informationen zu diesem Dokument" dargestellt
- Verbesserungen im Bereich der Accessability

V1.02.010
-Korrigiert: Aufgetretene Warnings durch StyleCode xELGA_red
-Optimiert: Erkennung von Mehreren Risiken innerhalb eines Dokuments
-Optimiert: Skalierung von eingebetteten Bildern
-Optimiert: Erkennung von eingebetteten Video- und Audiodateien 

V1.02.009
- Anzeigetexte präzisiert (u.a. Texte bei Geschlecht und Versicherungsgesellschaft/Inhaber)
- Korrigiert: Verhalten bei unbekannter Dokument-TemplateID und unbekannter EIS
- Vereinheitlichung der Zeilenumbrücke bei "Aufenthalt" 

V1.02.008
- Korrigiert: Tabellenformatierung mit styleCode="xELGA_tabVertical"
- Optimierung der Abstände zwischen Blöcken bei Darstellung im Internet Explorer
- Korrigiert: Darstellung von Listen ohne Angabe von @listType
- Optimierung der Darstellung von Fußnoten
- Vereinheitlichung der Darstellung von Hauptteil und Anhang
- Optimierung der Darstellung von Icons

V1.02.007
- Korrigiert: Anzeige des Geburtsortes in Adress-Granularitätsstufe 1
- Ergänzt: Mouseover für Kontaktperson
- Formatierung: Patienteninformation auf erster Seite kleiner, Einrückung der Adressblöcke und Überschriften, blaue Balken für Unterzeichner etc. 
- Anpassung des Abstandes bei den Blöcken "Risiken" und  "Für Fragen kontaktieren Sie bitte:"
- Darstellung des ELGA Logos optimiert
- Vereinheitlichung: Doppelpunkte bei den Datenblöcken
- Korrektur des ELGA styleCodes "xELGA_colw:XX"

V1.02.006
- Optimierung von HTML Links und deren Formatierung
- Umsetzung der expliziten Angabe der Spaltenbreite
- Optimierung der Abstände bei Brieftext und abschließenden Bemerkungen

V1.02.005
- Der Link "http://elga.vserver40.local.netconomy.net/elgaWeb/xsltBase64Encoder" wurde entfernt
Ein Erklärungstext wurde eingefügt: "Für das Generieren eines PDF-Download-Links muss ein Servlet zur Decodierung von Base64 codiertem PDF bereitgestellt werden. Codebeispiele für das Servlet finden Sie auf www.elga.gv.at"
- Optimierung der styleCodes in Tabellen
- Änderungen bei der Darstellung der Uhrzeit:
	1) Uhrzeit wird immer in der Form "hh:mm Uhr" dargestellt
	2) Uhrzeit bei Aufenthalt im Block "Patient" entfernt
	3) Bemi Geburtsdatum wird die Uhrzeit angezeigt, wenn vorhanden

V1.02.004
- styleCodes sind nicht mehr case sensitive
- Anzeigen der ELGA Interoperabilitätsstufe (EIS)
- styleCode Kapitälchen (und Kombination Unterstrichen, Kapitälchen) umgesetzt
- Die Icons, die den Warnungen auf der ersten Seite zugewiesen wurden, wurden auch links neben den Überschriften eingefügt
- Warnungen und die dazugehörigen Überschriften wurden gleich bezeichnet
- Anzeige der Versionsnummer des Referenz-Stylesheets bei den technischen Daten
- Mouseover bei der Kontaktperson bzw. dem Fachlichen Ansprechpartner ergänzt:
	Neuer Text: "Fachliche(r) Ansprechpartner(in) für dieses Dokument"
- Ausführlicherer Dokumententitel für bessere Unterscheidung zwischen Entlassungsbrief Pflege und Ärztlich (Beispiel: Entlassungsbrief aus stationärer Behandlung (Ärztlich)
- Die Anzeige „keine automatischen Warnungen“ erscheint nur mehr in Entlassungsbriefen
- Das verwendete Dokumententemplate wird angezeigt 
- Konsolidierung der Identifikation der participants
- Neue Icons für Risiko und Patientenverfügung integriert
- Hinzufügen von styleCodes für die Formatierung von Listen