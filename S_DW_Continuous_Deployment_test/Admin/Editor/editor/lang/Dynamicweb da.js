﻿/*
 * FCKeditor - The text editor for internet
 * Copyright (C) 2003-2005 Frederico Caldeira Knabben
 * 
 * Licensed under the terms of the GNU Lesser General Public License:
 * 		http://www.opensource.org/licenses/lgpl-license.php
 * 
 * For further information visit:
 * 		http://www.fckeditor.net/
 * 
 * "Support Open Source software. What about a donation today?"
 * 
 * File Name: da.js
 * 	Danish language file.
 * 
 * File Authors:
 * 		Bo Brandt (bbr@dynamicweb.dk)
 * 		Jørgen Nordstrøm (jn@FirstWeb.dk)
 * 		Jesper Michelsen (jm@i-deVision.dk)
 */

var FCKLang =
{
// Language direction : "ltr" (left to right) or "rtl" (right to left).
Dir					: "ltr",

ToolbarCollapse		: "Skjul værktøjslinier",
ToolbarExpand		: "Vis værktøjslinier",

// Toolbar Items and Context Menu
Save			: "Gem",
NewPage			: "Ny side",
Preview			: "Vis eksempel",
Cut			: "Klip",
Copy			: "Kopier",
Paste			: "Indsæt",
PasteText		: "Indsæt som ikke-formateret tekst",
PasteWord		: "Indsæt fra Word",
Print			: "Udskriv",
SelectAll		: "Vælg alt",
RemoveFormat		: "Fjern formatering",
InsertLinkLbl		: "Hyperlink",
InsertLink		: "Indsæt/rediger hyperlink",
RemoveLink		: "Fjern hyperlink",
Anchor			: "Indsæt/rediger bogmærke",
InsertImageLbl		: "Indsæt billede",
InsertImage		: "Indsæt/rediger billede",
InsertFlashLbl		: "Flash",
InsertFlash		: "Indsæt/rediger Flash",
InsertTableLbl		: "Table",
InsertTable		: "Indsæt/rediger tabel",
InsertLineLbl		: "Linie",
InsertLine		: "Indsæt vandret linie",
InsertSpecialCharLbl	: "Symbol",
InsertSpecialChar	: "Indsæt symbol",
InsertSmileyLbl		: "Smiley",
InsertSmiley		: "Indsæt smiley",
About			: "Om FCKeditor",
Bold			: "Fed",
Italic			: "Kursiv",
Underline		: "Understreget",
StrikeThrough		: "Gennemstreget",
Subscript		: "Sænket skrift",
Superscript		: "Hævet skrift",
LeftJustify		: "Venstrestillet",
CenterJustify		: "Centreret",
RightJustify		: "Højrestillet",
BlockJustify		: "Lige margener",
DecreaseIndent		: "Formindsk indrykning",
IncreaseIndent		: "Forøg indrykning",
Undo			: "Fortryd",
Redo			: "Annuller fortryd",
NumberedListLbl		: "Talopstilling",
NumberedList		: "Indsæt/fjern talopstilling",
BulletedListLbl		: "Punktopstilling",
BulletedList		: "Indsæt/fjern punktopstilling",
ShowTableBorders	: "Vis tabelkanter",
ShowDetails		: "Vis detaljer",
Style			: "Typografi",
FontFormat		: "Formatering",
Font			: "Skrifttype",
FontSize		: "Skriftstørrelse",
TextColor		: "Tekstfarve",
BGColor			: "Baggrundsfarve",
Source			: "Kilde",
Find			: "Søg",
Replace			: "Erstat",
SpellCheck		: "Stavekontrol",
UniversalKeyboard	: "Universaltastatur",
PageBreakLbl		: "Sidskift",
PageBreak		: "Indsæt sideskift",

Form			: "Indsæt formular",
Checkbox		: "Indsæt afkrydsningsfelt",
RadioButton		: "Indsæt alternativknap",
TextField		: "Indsæt tekstfelt",
Textarea		: "Indsæt tekstområde",
HiddenField		: "Indsæt skjult felt",
Button			: "Indsæt knap",
SelectionField		: "Indsæt liste",
ImageButton		: "Indsæt billedknap",

// Context Menu
EditLink		: "Rediger hyperlink",
InsertRow		: "Indsæt række",
DeleteRows		: "Slet række",
InsertColumn		: "Indsæt kolonne",
DeleteColumns		: "Slet kolonne",
InsertCell		: "Indsæt celle",
DeleteCells		: "Slet celle",
MergeCells		: "Flet celler",
SplitCell		: "Opdel celle",
TableDelete		: "Slet tabel",
CellProperties		: "Egenskaber for celle",
TableProperties		: "Egenskaber for tabel",
ImageProperties		: "Egenskaber for billede",
FlashProperties		: "Egenskaber for Flash",

AnchorProp		: "Egenskaber for bogmærke",
ButtonProp		: "Egenskaber for knap",
CheckboxProp		: "Egenskaber for afkrydsningsfelt",
HiddenFieldProp		: "Egenskaber for skjult felt",
RadioButtonProp		: "Egenskaber for alternativknap",
ImageButtonProp		: "Egenskaber for billedknap",
TextFieldProp		: "Egenskaber for tekstfelt",
SelectionFieldProp	: "Egenskaber for liste",
TextareaProp		: "Egenskaber for tekstboks",
FormProp		: "Egenskaber for formular",

FontFormats		: "Normal;Formateret;Adresse;Overskrift 1;Overskrift 2;Overskrift 3;Overskrift 4;Overskrift 5;Overskrift 6;Normal (DIV);text3",

// Alerts and Messages
ProcessingXHTML		: "Behandler XHTML...",
Done			: "Færdig",
PasteWordConfirm	: "Den tekst du forsøger at indsætte ser ud til at komme fra Word.<br>Vil du rense teksten før den indsættes?",
NotCompatiblePaste	: "Denne kommando er tilgændelig i Internet Explorer 5.5 eller senere.<br>Vil du indsætte teksten uden at rense den ?",
UnknownToolbarItem	: "Ukendt værktøjslinjeobjekt \"%1\"!",
UnknownCommand		: "Ukendt kommandonavn \"%1\"!",
NotImplemented		: "Kommandoen er ikke implementeret!",
UnknownToolbarSet	: "Værktøjslinjen \"%1\" eksisterer ikke!",
NoActiveX		: "Din browsers sikkerhedsindstillinger begrænser nogle af editorens muligheder.<br>Slå \"Kør ActiveX-objekter og plug-ins\" til, ellers vil du opleve fejl og manglende muligheder.",
BrowseServerBlocked 	: "Browseren kunne ikke åbne de nødvendige ressourcer!<br>Slå pop-up blokering fra.",
DialogBlocked		: "Dialogvinduet kunne ikke åbnes!<br>Slå pop-up blokering fra.",

// Dialogs
DlgBtnOK		: "OK",
DlgBtnCancel		: "Annuller",
DlgBtnClose		: "Luk",
DlgBtnBrowseServer	: "Gennemse...",
DlgAdvancedTag		: "Avanceret",
DlgOpOther		: "&lt;Andet&gt;",
DlgInfoTab		: "Generelt",
DlgAlertUrl		: "Indtast URL",

// General Dialogs Labels
DlgGenNotSet		: "&lt;intet valgt&gt;",
DlgGenId		: "Id",
DlgGenLangDir		: "Skriveretning",
DlgGenLangDirLtr	: "Fra venstre mod højre (LTR)",
DlgGenLangDirRtl	: "Fra højre mod venstre (RTL)",
DlgGenLangCode		: "Sprogkode",
DlgGenAccessKey		: "Genvejstast",
DlgGenName		: "Navn",
DlgGenTabIndex		: "Tabulator indeks",
DlgGenLongDescr		: "Udvidet beskrivelse",
DlgGenClass		: "Typografiark",
DlgGenTitle		: "Titel",
DlgGenContType		: "Indholdstype",
DlgGenLinkCharset	: "Tegnsæt",
DlgGenStyle		: "Typografi",

// Image Dialog
DlgImgTitle		: "Egenskaber for billede",
DlgImgInfoTab		: "Generelt",
DlgImgBtnUpload		: "Upload",
DlgImgURL		: "URL",
DlgImgUpload		: "Upload",
DlgImgAlt		: "Alternativ tekst",
DlgImgWidth		: "Bredde",
DlgImgHeight		: "Højde",
DlgImgLockRatio		: "Lås størrelsesforhold",
DlgBtnResetSize		: "Nulstil størrelse",
DlgImgBorder		: "Ramme",
DlgImgHSpace		: "HMargen",
DlgImgVSpace		: "VMargen",
DlgImgAlign		: "Justering",
DlgImgAlignLeft		: "Venstre",
DlgImgAlignAbsBottom	: "Absolut nederst",
DlgImgAlignAbsMiddle	: "Absolut centreret",
DlgImgAlignBaseline	: "Grundlinje",
DlgImgAlignBottom	: "Nederst",
DlgImgAlignMiddle	: "Centreret",
DlgImgAlignRight	: "Højre",
DlgImgAlignTextTop	: "Toppen af teksten",
DlgImgAlignTop		: "Øverst",
DlgImgPreview		: "Vis eksempel",
DlgImgAlertUrl		: "Indtast stien til billedet",
DlgImgLinkTab		: "Hyperlink",

// Flash Dialog
DlgFlashTitle		: "Egenskaber for Flash",
DlgFlashChkPlay		: "Automatisk afspilning",
DlgFlashChkLoop		: "Gentagelse",
DlgFlashChkMenu		: "Vis Flash menu",
DlgFlashScale		: "Skalér",
DlgFlashScaleAll	: "Vis alt",
DlgFlashScaleNoBorder	: "Ingen ramme",
DlgFlashScaleFit	: "Tilpas størrelse",

// Link Dialog
DlgLnkWindowTitle	: "Egenskaber for hyperlink",
DlgLnkInfoTab		: "Generelt",
DlgLnkTargetTab		: "Destination",

DlgLnkType		: "Hyperlink type",
DlgLnkTypeURL		: "URL",
DlgLnkTypeAnchor	: "Bogmærke på denne side",
DlgLnkTypeEMail		: "E-mail",
DlgLnkProto		: "Protokol",
DlgLnkProtoOther		: "&lt;anden&gt;",
DlgLnkURL		: "URL",
DlgLnkAnchorSel		: "Vælg et anker",
DlgLnkAnchorByName	: "Efter anker navn",
DlgLnkAnchorById	: "Efter element Id",
DlgLnkNoAnchors		: "&lt;Ingen bogmærker dokumentet&gt;",
DlgLnkEMail		: "E-mailadresse",
DlgLnkEMailSubject	: "Emne",
DlgLnkEMailBody		: "Brødtekst",
DlgLnkUpload		: "Upload",
DlgLnkBtnUpload		: "Upload",

DlgLnkTarget		: "Destination",
DlgLnkTargetFrame	: "&lt;ramme&gt;",
DlgLnkTargetPopup	: "&lt;popup vindue&gt;",
DlgLnkTargetBlank	: "Nyt vindue (_blank)",
DlgLnkTargetParent	: "Overordnet ramme (_parent)",
DlgLnkTargetSelf	: "Samme vindue (_self)",
DlgLnkTargetTop		: "Hele vinduet (_top)",
DlgLnkTargetFrameName	: "Destinationsvinduets navn",
DlgLnkPopWinName	: "Pop-up vinduets navn",
DlgLnkPopWinFeat	: "Egenskaber for pop-up",
DlgLnkPopResize		: "Skalering",
DlgLnkPopLocation	: "Adresselinje",
DlgLnkPopMenu		: "Menulinje",
DlgLnkPopScroll		: "Scrollbars",
DlgLnkPopStatus		: "Statuslinje",
DlgLnkPopToolbar	: "Værktøjslinje",
DlgLnkPopFullScrn	: "Fuld skærm (IE)",
DlgLnkPopDependent	: "Koblet/dependent (Netscape)",
DlgLnkPopWidth		: "Bredde",
DlgLnkPopHeight		: "Højde",
DlgLnkPopLeft		: "Position fra venstre",
DlgLnkPopTop		: "Position fra toppen",

DlnLnkMsgNoUrl		: "Indtast hyperlink URL!",
DlnLnkMsgNoEMail	: "Indtast e-mailaddresse!",
DlnLnkMsgNoAnchor	: "Vælg bogmærke!",

// Color Dialog
DlgColorTitle		: "Vælg farve",
DlgColorBtnClear	: "Nulstil",
DlgColorHighlight	: "Markeret",
DlgColorSelected	: "Valgt",

// Smiley Dialog
DlgSmileyTitle		: "Vælg smiley",

// Special Character Dialog
DlgSpecialCharTitle	: "Vælg symbol",

// Table Dialog
DlgTableTitle		: "Egenskaber for tabel",
DlgTableRows		: "Rækker",
DlgTableColumns		: "Kolonner",
DlgTableBorder		: "Rammebredde",
DlgTableAlign		: "Justering",
DlgTableAlignNotSet	: "&lt;intet valgt&gt;",
DlgTableAlignLeft	: "Venstrestillet",
DlgTableAlignCenter	: "Centreret",
DlgTableAlignRight	: "Højrestillet",
DlgTableWidth		: "Bredde",
DlgTableWidthPx		: "pixels",
DlgTableWidthPc		: "procent",
DlgTableHeight		: "Højde",
DlgTableCellSpace	: "Celleafstand",
DlgTableCellPad		: "Cellemargen",
DlgTableCaption		: "Titel",
DlgTableSummary		: "Resume",

// Table Cell Dialog
DlgCellTitle		: "Egenskaber for celle",
DlgCellWidth		: "Bredde",
DlgCellWidthPx		: "pixels",
DlgCellWidthPc		: "procent",
DlgCellHeight		: "Højde",
DlgCellWordWrap		: "Orddeling",
DlgCellWordWrapNotSet	: "&lt;intet valgt&gt;",
DlgCellWordWrapYes	: "Ja",
DlgCellWordWrapNo	: "Nej",
DlgCellHorAlign		: "Vandret justering",
DlgCellHorAlignNotSet	: "&lt;intet valgt&gt;",
DlgCellHorAlignLeft	: "Venstrestillet",
DlgCellHorAlignCenter	: "Centreret",
DlgCellHorAlignRight	: "Højrestillet",
DlgCellVerAlign		: "Lodret justering",
DlgCellVerAlignNotSet	: "&lt;intet valgt&gt;",
DlgCellVerAlignTop	: "Øverst",
DlgCellVerAlignMiddle	: "Centreret",
DlgCellVerAlignBottom	: "Nederst",
DlgCellVerAlignBaseline	: "Grundlinje",
DlgCellRowSpan		: "Højde i antal rækker",
DlgCellCollSpan		: "Bredde i antal kolonner",
DlgCellBackColor	: "Baggrundsfarve",
DlgCellBorderColor	: "Rammefarve",
DlgCellBtnSelect	: "Vælg...",

// Find Dialog
DlgFindTitle		: "Find",
DlgFindFindBtn		: "Find",
DlgFindNotFoundMsg	: "Søgeteksten blev ikke fundet!",

// Replace Dialog
DlgReplaceTitle		: "Erstat",
DlgReplaceFindLbl	: "Søg efter:",
DlgReplaceReplaceLbl	: "Erstat med:",
DlgReplaceCaseChk	: "Forskel på store og små bogstaver",
DlgReplaceReplaceBtn	: "Erstat",
DlgReplaceReplAllBtn	: "Erstat alle",
DlgReplaceWordChk	: "Kun hele ord",

// Paste Operations / Dialog
PasteErrorPaste		: "Din browsers sikkerhedsindstillinger tillader ikke editoren at indsætte tekst automatisk!<br>Brug i stedet tastaturet til at indsætte teksten (Ctrl+V).",
PasteErrorCut		: "Din browsers sikkerhedsindstillinger tillader ikke editoren at klippe tekst automatisk!<br>Brug i stedet tastaturet til at klippe teksten (Ctrl+X).",
PasteErrorCopy		: "Din browsers sikkerhedsindstillinger tillader ikke editoren at kopiere tekst automatisk!<br>Brug i stedet tastaturet til at kopiere teksten (Ctrl+C).",

PasteAsText		: "Indsæt som ikke-formateret tekst",
PasteFromWord		: "Indsæt fra Word",

DlgPasteMsg2		: "Indsæt i feltet herunder (<STRONG>Ctrl+V</STRONG>) og klik <STRONG>OK</STRONG>.",
DlgPasteIgnoreFont	: "Ignorer font definitioner",
DlgPasteRemoveStyles	: "Ignorer typografi",
DlgPasteCleanBox	: "Slet indhold",


// Color Picker
ColorAutomatic		: "Automatisk",
ColorMoreColors		: "Flere farver...",

// Document Properties
DocProps		: "Egenskaber for dokument",

// Anchor Dialog
DlgAnchorTitle		: "Egenskaber for bogmærke",
DlgAnchorName		: "Bogmærke navn",
DlgAnchorErrorName	: "Indtast bogmærke navn!",

// Speller Pages Dialog
DlgSpellNotInDic	: "Ikke i ordbogen",
DlgSpellChangeTo	: "Forslag",
DlgSpellBtnIgnore	: "Ignorer",
DlgSpellBtnIgnoreAll	: "Ignorer alle",
DlgSpellBtnReplace	: "Erstat",
DlgSpellBtnReplaceAll	: "Erstat alle",
DlgSpellBtnUndo		: "Tilbage",
DlgSpellNoSuggestions	: "- ingen forslag -",
DlgSpellProgress	: "Stavekontrolen arbejder...",
DlgSpellNoMispell	: "Stavekontrol færdig: Ingen fejl fundet",
DlgSpellNoChanges	: "Stavekontrol færdig: Ingen ord ændret",
DlgSpellOneChange	: "Stavekontrol færdig: Et ord ændret",
DlgSpellManyChanges	: "Stavekontrol færdig: %1 ord ændret",

IeSpellDownload		: "Stavekontrol ikke installeret.<br>Vil du hente den nu?",

// Button Dialog
DlgButtonText		: "Tekst",
DlgButtonType		: "Type",

// Checkbox and Radio Button Dialogs
DlgCheckboxName		: "Navn",
DlgCheckboxValue	: "Værdi",
DlgCheckboxSelected	: "Valgt",

// Form Dialog
DlgFormName		: "Navn",
DlgFormAction		: "Handling",
DlgFormMethod		: "Metod",

// Select Field Dialog
DlgSelectName		: "Navn",
DlgSelectValue		: "Værdi",
DlgSelectSize		: "Størrelse",
DlgSelectLines		: "linier",
DlgSelectChkMulti	: "Tillad flere valg",
DlgSelectOpAvail	: "Valgmuligheder",
DlgSelectOpText		: "Tekst",
DlgSelectOpValue	: "Værdi",
DlgSelectBtnAdd		: "Tilføj",
DlgSelectBtnModify	: "Rediger",
DlgSelectBtnUp		: "Op",
DlgSelectBtnDown	: "Ned",
DlgSelectBtnSetValue 	: "Sæt som valgt",
DlgSelectBtnDelete	: "Slet",

// Textarea Dialog
DlgTextareaName		: "Navn",
DlgTextareaCols		: "Kolonner",
DlgTextareaRows		: "Rækker",

// Text Field Dialog
DlgTextName		: "Navn",
DlgTextValue		: "Værdi",
DlgTextCharWidth	: "Bredde (tegn)",
DlgTextMaxChars		: "Max antal tegn",
DlgTextType		: "Type",
DlgTextTypeText		: "Tekst",
DlgTextTypePass		: "Adgangskode",

// Hidden Field Dialog
DlgHiddenName		: "Navn",
DlgHiddenValue		: "Værdi",

// Bulleted List Dialog
BulletedListProp	: "Egenskaber for punktopstilling",
NumberedListProp	: "Egenskaber for talopstilling",
DlgLstType		: "Type",
DlgLstTypeCircle	: "Cirkel",
DlgLstTypeDisc		: "Udfyldt cirkel",
DlgLstTypeSquare	: "Firkant",
DlgLstTypeNumbers	: "Nummereret (1, 2, 3)",
DlgLstTypeLCase		: "Små bogstaver (a, b, c)",
DlgLstTypeUCase		: "Store bogstaver (A, B, C)",
DlgLstTypeSRoman	: "Små romertal (i, ii, iii)",
DlgLstTypeLRoman	: "Store romertal (I, II, III)",

// Document Properties Dialog
DlgDocGeneralTab	: "Generelt",
DlgDocBackTab		: "Baggrund",
DlgDocColorsTab		: "Farver og margen",
DlgDocMetaTab		: "Metadata",

DlgDocPageTitle		: "Sidetitel",
DlgDocLangDir		: "Sprog",
DlgDocLangDirLTR	: "Fra venstre mod højre (LTR)",
DlgDocLangDirRTL	: "Fra højre mod venstre (RTL)",
DlgDocLangCode		: "Landekode",
DlgDocCharSet		: "Tegnsæt kode",
DlgDocCharSetOther	: "Anden tegnsæt kode",

DlgDocDocType		: "Dokumenttype kategori",
DlgDocDocTypeOther	: "Anden dokumenttype kategori",
DlgDocIncXHTML		: "Inkludere XHTML deklartion",
DlgDocBgColor		: "Baggrundsfarve",
DlgDocBgImage		: "Baggrundsbillede URL",
DlgDocBgNoScroll	: "Fastlåst baggrund",
DlgDocCText		: "Tekst",
DlgDocCLink		: "Hyperlink",
DlgDocCVisited		: "Besøgt hyperlink",
DlgDocCActive		: "Aktivt hyperlink",
DlgDocMargins		: "Sidemargen",
DlgDocMaTop		: "Øverst",
DlgDocMaLeft		: "Venstre",
DlgDocMaRight		: "Højre",
DlgDocMaBottom		: "Nederst",
DlgDocMeIndex		: "Dokument index nøgleord (kommasepareret)",
DlgDocMeDescr		: "Dokument beskrivelse",
DlgDocMeAuthor		: "Forfatter",
DlgDocMeCopy		: "Copyright",
DlgDocPreview		: "Vis",

// Templates Dialog
Templates		: "Skabeloner",
DlgTemplatesTitle	: "Indholdsskabeloner",
DlgTemplatesSelMsg	: "Vælg den skabelon, som skal åbnes i editoren.<br>(Nuværende indhold vil blive overskrevet!):",
DlgTemplatesLoading	: "Henter liste over skabeloner...",
DlgTemplatesNoTpl	: "(Der er ikke defineret nogen skabelon!)",

// About Dialog
DlgAboutAboutTab	: "Om",
DlgAboutBrowserInfoTab	: "Generelt",
DlgAboutVersion		: "version",
DlgAboutLicense		: "Licens under vilkår for GNU Lesser General Public License",
DlgAboutInfo		: "For yderlig information gå til"
}