<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Editing_cpl.aspx.vb" Inherits="Dynamicweb.Admin.Editing_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<link rel="Stylesheet" type="text/css" href="../Stylesheet.css" />
<title><%=Translate.JsTranslate("Redigering")%></title>
</head>
<body>

<script language="javascript" type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
<script type="text/javascript">

	function OK_OnClick() {
		var lockTime = document.getElementById("DWParagraphMaxLockTime");
		var eHeight = document.getElementById("/Globalsettings/Settings/TextEditor/EditorHeight");
		var sendResultsTo = document.getElementById('/Globalsettings/Settings/MarkupValidation/SendResultsTo');
		var ret = true;
		
		if(ret && lockTime.value.length > 0 && !ChkInt(lockTime.value)) {
			ret = false;
			alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Maksimal låsning i minutter"))%>");
			lockTime.focus();
		}
		
		if(ret && eHeight.value.length > 0 && !ChkInt(eHeight.value)) {
			ret = false;
			alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Højde"))%>");
			eHeight.focus();
		}
		
		if(ret && sendResultsTo) {
		    if(sendResultsTo.value.length > 0)
		        ret = IsEmailValid(sendResultsTo, 
		            '<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JSTranslate("Send_notificering_til_bruger"))%>');
		}
		
		if(ret)
			document.getElementById('frmGlobalSettings').submit();
	}
	
	function onChangeNotify(checkbox) {
	    var rows = [ 'rowNotify' ];
	    
	    for(var i = 0; i < rows.length; i++) {
	        var row = document.getElementById(rows[i]);
	        if(row) 
	            row.style.display = (checkbox.checked ? '' : 'none');
	    }
	}
	
	function findCheckboxNames(form) {
		var _names="";
		for(var i=0; i < form.length ; i++) {
			if(form[i].name!=undefined) {
				if(form[i].type=="checkbox") {
					_names = _names + form[i].name + "@"
				}
			}
		}
	form.CheckboxNames.value=_names;
	}
</script>

<%
Dim DISABLED As Boolean
Dim sql As String
Dim DWParagraphMaxLockTime As String
Dim strParagraphBottomSpace As String
Dim TekstEditorConn  As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdTekstEditor = TekstEditorConn.CreateCommand
%>
<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Redigering")),Translate.Translate("Konfiguration"), "all")%>

<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
    <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
		<input type="hidden" name="CheckboxNames" />
		<tr>
			<td valign="top">
				
				<%=Gui.GroupBoxStart(Translate.Translate("Indstilling"))%>
				<table cellpadding='2' cellspacing='0' border='0' width='100%'>
					<tr>
						<td width="36" align="left"><img src="../Images/Icons/cplEditing.gif" alt="" /></td>
						<td align="left" nowrap="nowrap" style='font-size: 14; font-family: Verdana, Arial, Helvetica; font-weight: Bold;'><%=Translate.Translate("Redigering")%></td>
					</tr>
				</table>		
				<%=Gui.GroupBoxEnd%>
				<%		If Base.HasVersion("19.0.0.0") AndAlso Session("DW_Admin_UserID") < 3 Then%>
				<%=Gui.GroupBoxStart(Translate.Translate("Brugergrænseflade"))%>
				<table cellpadding='2' cellspacing='0' border='0' width='100%' style="table-layout: fixed">
					<tr valign="top">
						<td width="170" align="left">
							</td>
						<td align="left">
							<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/ContentEditor/UseNew") = "True", "checked", "")%> id="/Globalsettings/Settings/ContentEditor/UseNew" name="/Globalsettings/Settings/ContentEditor/UseNew" />
							<label for="/Globalsettings/Settings/ContentEditor/UseNew"><%=Translate.Translate("Ny")%></label>
							</td>
					</tr>
					<tr valign="top">
						<td width="170" align="left">
							</td>
						<td align="left">
							<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/ContentEditor/UseSimpleParagraphList") = "True", "checked", "")%> id="/Globalsettings/Settings/ContentEditor/UseSimpleParagraphList" name="/Globalsettings/Settings/ContentEditor/UseSimpleParagraphList" />
							<label for="/Globalsettings/Settings/ContentEditor/UseSimpleParagraphList"><%=Translate.Translate("Simple paragraph list")%></label>
							</td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				<%End If%>
				
				<%If Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/ContentEditor/UseNew")) Then%>
				<%=Gui.GroupBoxStart(Translate.Translate("Validering"))%>
				<table border="0" cellpadding="2" cellspacing="0" width="100%" style="table-layout: fixed">
				    <tr>
				        <td width="170">
				            <label for="/Globalsettings/Settings/MarkupValidation/ShowWarnings">
				                <%=Translate.Translate("Show warnings")%>
				            </label>
				        </td>
				        <td>
				            <input type="checkbox" value="True" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/MarkupValidation/ShowWarnings")), "checked", String.Empty)%> 
                                id="/Globalsettings/Settings/MarkupValidation/ShowWarnings" name="/Globalsettings/Settings/MarkupValidation/ShowWarnings" />
				        </td>
				    </tr>
				    <tr>
				        <td>
				            <label for="/Globalsettings/Settings/MarkupValidation/ValidateTopLevel">
				                <%=Translate.Translate("Validate top-level pages")%>
				            </label>
				        </td>
				        <td>
				            <input type="checkbox" value="True" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/MarkupValidation/ValidateTopLevel")), "checked", String.Empty)%> 
                                id="/Globalsettings/Settings/MarkupValidation/ValidateTopLevel" name="/Globalsettings/Settings/MarkupValidation/ValidateTopLevel" />
				        </td>
				    </tr>
				    <tr>
				        <td>
				            <label for="/Globalsettings/Settings/MarkupValidation/EnableNotification">
				                <%=Translate.Translate("Notificering_ved_ændring")%>
                            </label>
				        </td>
				        <td>
				            <input type="checkbox" onclick="onChangeNotify(this);" value="True" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/MarkupValidation/EnableNotification")), "checked", String.Empty)%> 
                                id="/Globalsettings/Settings/MarkupValidation/EnableNotification" name="/Globalsettings/Settings/MarkupValidation/EnableNotification" />      
				        </td>
				    </tr>
				    <tr id="rowNotify" style="display: <%=Base.IIF(Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/MarkupValidation/EnableNotification")), String.Empty, "none")%>">
				        <td colspan="2" style="padding-left: 15px;">
				            <table>
				                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Subject")%>
                                    </td>
                                    <td>
                                        <input type="text" class="std" value='<%=Base.GetGs("/Globalsettings/Settings/MarkupValidation/EmailSubject") %>'
                                            id="/Globalsettings/Settings/MarkupValidation/EmailSubject" name="/Globalsettings/Settings/MarkupValidation/EmailSubject" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Email")%>
                                    </td>
                                    <td>
                                        <input type="text" class="std" value='<%=Base.GetGs("/Globalsettings/Settings/MarkupValidation/SendResultsTo") %>' 
                                            id="/Globalsettings/Settings/MarkupValidation/SendResultsTo" name="/Globalsettings/Settings/MarkupValidation/SendResultsTo" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Template")%>
                                    </td>
                                    <td>
                                        <%=Gui.FileManager(Base.GetGs("/Globalsettings/Settings/MarkupValidation/Template"), "Templates/Validation", "/Globalsettings/Settings/MarkupValidation/Template")%>
                                    </td>
                                </tr>
				            </table>
				        </td>
				    </tr>
				</table>
				<%=Gui.GroupBoxEnd()%>
				<%End If%>
				
				<%=Gui.GroupBoxStart(Translate.Translate("Afsnit"))%>
				<table border="0" cellpadding="2" cellspacing="0">
					<tr>
						<%
							If Trim(Base.GetGs("/Globalsettings/Settings/Paragraph/MaximumLockingInMinutes")) = "" Or Not IsNumeric(Base.GetGs("/Globalsettings/Settings/Paragraph/MaximumLockingInMinutes")) Then
								DWParagraphMaxLockTime = "30"
							Else
								DWParagraphMaxLockTime = Base.GetGs("/Globalsettings/Settings/Paragraph/MaximumLockingInMinutes")
							End If
							%>
						<td width="170"><label for="/Globalsettings/Settings/Paragraph/MaximumLockingInMinutes"><%=Translate.Translate("Maksimal låsning i minutter")%></A></td>
						<td><input type="text" maxlength="255" class="std" value="<%=DWParagraphMaxLockTime%>" name="/Globalsettings/Settings/Paragraph/MaximumLockingInMinutes" id="DWParagraphMaxLockTime"></td>
					</tr>
					
					<tr style='display: <%=Base.IIf(Gui.NewUI(), "none", String.Empty)%>'>
						<td><label for="/Globalsettings/Settings/Paragraph/FrontendEditingEnabled"><%=Translate.Translate("Frontend editering")%></label></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/FrontendEditingEnabled") = "True", "checked", "")%> id="DWFrontend_Active" name="/Globalsettings/Settings/Paragraph/FrontendEditingEnabled"></td>
					</tr>
					
					<tr>
						<td><%=Translate.Translate("Mellemrum inden afsnit")%></td>
						<td>
							<select name="/Globalsettings/Settings/Paragraph/SpacesBeforeParagraph" class="std" style="width:35px;">
								<%
								If Base.GetGs("/Globalsettings/Settings/Paragraph/SpacesBeforeParagraph") = "" Then
									strParagraphBottomSpace = 1
								Else
									strParagraphBottomSpace = Base.GetGs("/Globalsettings/Settings/Paragraph/SpacesBeforeParagraph")
								End If
								For i As Integer = 0 To 9
									If CStr(i) = CStr(strParagraphBottomSpace) Then
										Response.Write("<option value=""" & i & """ selected>" & i & "</option>")
									Else
										Response.Write("<option value=""" & i & """>" & i & "</option>")
									End If
								Next 
								%>
							</select>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/HideSpaceSetting") = "True", "checked", "")%> id="/Globalsettings/Settings/Paragraph/HideSpaceSetting" name="/Globalsettings/Settings/Paragraph/HideSpaceSetting">
							<label for="/Globalsettings/Settings/Paragraph/HideSpaceSetting"><%=Translate.Translate("Skjul indstilling på afsnit")%></label>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<%
							If Base.GetGs("/Globalsettings/Settings/Paragraph/SpaceMode") = "" Then
								Base.SetGs("/Globalsettings/Settings/Paragraph/SpaceMode", "tr")
							End If
							%>
							<input type="radio" value="tr" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/SpaceMode") = "tr", "checked", "")%> id="Mode1" name="/Globalsettings/Settings/Paragraph/SpaceMode"><label for="Mode1"><%=Translate.Translate("Standard (tr)")%></label><br />
							<input type="radio" value="div" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/SpaceMode") = "div", "checked", "")%> id="Mode2" name="/Globalsettings/Settings/Paragraph/SpaceMode"><label for="Mode2"><%=Translate.Translate("Div")%></label><br />
							<input type="radio" value="none" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/SpaceMode") = "none", "checked", "")%> id="Mode3" name="/Globalsettings/Settings/Paragraph/SpaceMode"><label for="Mode3"><%=Translate.Translate("Ingen")%></label>
						</td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				<%If Base.HasVersion("18.10.1.0") And Session("DW_Admin_UserID") < 3 Then%>
				<%=Gui.GroupBoxStart(Translate.Translate("Egenskaber"))%>
				<table cellpadding='2' cellspacing='0' border='0' width='100%'>
					<tr valign=top>
						<td width=170 align=left><%=Translate.Translate("Editor")%></td>
						<td align=left>
							<input type="radio" name="/Globalsettings/Settings/TextEditor/EditorVersion" id="EditorOld" value="EditorOld" onclick="document.getElementById('OldEditorSettings').style.display = '';document.getElementById('NewEditorSettings').style.display = 'none';" <%=IIf((Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "" OR Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "EditorOld"), "checked", "")%>><%=Translate.Translate("Standard")%>&nbsp;
							<br/>
							<input type="radio" name="/Globalsettings/Settings/TextEditor/EditorVersion" id="EditorNew" value="EditorNew" onclick="document.getElementById('OldEditorSettings').style.display = 'none';document.getElementById('NewEditorSettings').style.display = '';" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "EditorNew", "checked", "")%>><%=Translate.Translate("Udvidet")%>&nbsp;
						</td>
					</tr>
<%--					<tr valign="top">
						<td width="170" align="left"><%=Translate.Translate("Spellchecker language")%></td>
						<td align="left">
						    <select name="/Globalsettings/Settings/TextEditor/NewEditor/SpellCheckLanguage">
						        <% For Each item As ListItem In spellerLanguages %>
						        <option <%=Base.IIf(item.selected, "selected=""selected""", "")%>
						                value="<%=HttpUtility.HtmlAttributeEncode(item.Value) %>">
						            <%=Server.HtmlEncode(item.Text)%>
						        </option>
						        <% Next%>
						    </select>
						</td>
					</tr>--%>
				</table>		
				<%=Gui.GroupBoxEnd%>
				<%End If%>
				<div id="NewEditorSettings" style="display:<%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "EditorNew", "", "none")%>;">

				<%=Gui.GroupBoxStart(Translate.Translate("Editor"))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170"><%=Translate.Translate("Højde")%></td>
							<td><input type=text value="<%=Base.GetGs("/Globalsettings/Settings/TextEditor/EditorHeight")%>" name="/Globalsettings/Settings/TextEditor/EditorHeight" id="/Globalsettings/Settings/TextEditor/EditorHeight" class="std"></td>
						</tr>
						<tr>
							<td><label for="UseStylesheet"><%=Translate.Translate("Brug stylesheet i editor")%></label>
							</td>
							<td>			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/UseStylesheet") = "True", "checked", "")%> id="UseStylesheet" name="/Globalsettings/Settings/TextEditor/NewEditor/UseStylesheet">
							</td>
						</tr>
						<tr>
							<td valign="top">
								<%=Translate.Translate("Editor linieskift")%>
							</td>
							<td>
								<%
									If Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/EnterType") = "" Then
										Base.SetGs("/Globalsettings/Settings/TextEditor/NewEditor/EnterType", "p")
									End If
								%>
								<input id="EnterType1" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/EnterType") = "p", "checked", "")%>=""
									name="/Globalsettings/Settings/TextEditor/NewEditor/EnterType" type="radio" value="p"><label
										for="EnterType1"><%=Translate.Translate("Standard (p)")%></label><br />
								<input id="EnterType2" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/EnterType") = "div", "checked", "")%>=""
									name="/Globalsettings/Settings/TextEditor/NewEditor/EnterType" type="radio" value="div"><label
										for="EnterType2"><%=Translate.Translate("Div")%></label><br />
								<input id="EnterType3" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/EnterType") = "br", "checked", "")%>=""
									name="/Globalsettings/Settings/TextEditor/NewEditor/EnterType" type="radio" value="br"><label
										for="EnterType3"><%=Translate.Translate("br")%></label>
							</td>
						</tr>
					</table>
				<%=Gui.GroupBoxEnd%>
				<%=Gui.GroupBoxStart(Translate.Translate("Værktøjslinier"))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td colspan=2><strong><%=Translate.Translate("Funktioner",2)%></strong></td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Source") = "True", "checked", "")%> id="Source" name="/Globalsettings/Settings/TextEditor/NewEditor/Source">
							</td>
							<td><label for="Source"><%=Translate.Translate("Kilde")%></label>
							</td>
						</tr>
						<!--tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/DocProps") = "True", "checked", "")%> id="DocProps" name="/Globalsettings/Settings/TextEditor/NewEditor/DocProps">
							</td>
							<td><label for="DocProps"><%=Translate.Translate("Egenskaber")%></label>
							</td>
						</tr-->
						<!--tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Save") = "True", "checked", "")%> id="Save" name="/Globalsettings/Settings/TextEditor/NewEditor/Save">
							</td>
							<td><label for="Save"><%=Translate.Translate("Gem")%></label>
							</td>
						</tr-->
						<!--tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/NewPage") = "True", "checked", "")%> id="NewPage" name="/Globalsettings/Settings/TextEditor/NewEditor/NewPage">
							</td>
							<td><label for="NewPage"><%=Translate.Translate("Ny side")%></label>
							</td>
						</tr-->
						
						<tr>
							<td style="padding-left: 40px;">
								<input id="FitWindow" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/FitWindow") = "True", "checked", "")%>=""
									name="/Globalsettings/Settings/TextEditor/NewEditor/FitWindow" type="checkbox"
									value="True">
							</td>
							<td>
								<label for="FitWindow">
									<%=Translate.Translate("Maximize window")%>
								</label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Preview") = "True", "checked", "")%> id="Preview" name="/Globalsettings/Settings/TextEditor/NewEditor/Preview">
							</td>
							<td><label for="Preview"><%=Translate.Translate("Preview")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Templates") = "True", "checked", "")%> id="Templates" name="/Globalsettings/Settings/TextEditor/NewEditor/Templates">
							</td>
							<td><label for="Templates"><%=Translate.Translate("Templates")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Print") = "True", "checked", "")%> id="Print" name="/Globalsettings/Settings/TextEditor/NewEditor/Print">
							</td>
							<td><label for="Print"><%=Translate.Translate("Udskriv")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/SpellCheck") = "True", "checked", "")%> id="SpellCheck" name="/Globalsettings/Settings/TextEditor/NewEditor/SpellCheck">
							</td>
							<td><label for="SpellCheck"><%=Translate.Translate("Stavekontrol")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/GoogleTranslate") = "True", "checked", "")%> id="GoogleTranslate" name="/Globalsettings/Settings/TextEditor/NewEditor/GoogleTranslate">
							</td>
							<td><label for="GoogleTranslate"><%=Translate.Translate("Translate")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/UniversalKey") = "True", "checked", "")%> id="UniversalKey" name="/Globalsettings/Settings/TextEditor/NewEditor/UniversalKey">
							</td>
							<td><label for="UniversalKey"><%=Translate.Translate("Universaltastatur")%></label>
							</td>
						</tr>

						
						<tr>
							<td colspan=2><strong><%=Translate.Translate("Rediger",2)%></strong></td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Cut") = "True", "checked", "")%> id="Cut" name="/Globalsettings/Settings/TextEditor/NewEditor/Cut">
							</td>
							<td><label for="Cut"><%=Translate.Translate("Klip")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Copy") = "True", "checked", "")%> id="Copy" name="/Globalsettings/Settings/TextEditor/NewEditor/Copy">
							</td>
							<td><label for="Copy"><%=Translate.Translate("Kopier")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Paste") = "True", "checked", "")%> id="Paste" name="/Globalsettings/Settings/TextEditor/NewEditor/Paste">
							</td>
							<td><label for="Paste"><%=Translate.Translate("Sæt ind")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/PasteText") = "True", "checked", "")%> id="PasteText" name="/Globalsettings/Settings/TextEditor/NewEditor/PasteText">
							</td>
							<td><label for="PasteText"><%=Translate.Translate("Sæt ind som tekst")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/PasteWord") = "True", "checked", "")%> id="PasteWord" name="/Globalsettings/Settings/TextEditor/NewEditor/PasteWord">
							</td>
							<td><label for="PasteWord"><%=Translate.Translate("Sæt ind fra Word")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Undo") = "True", "checked", "")%> id="Undo" name="/Globalsettings/Settings/TextEditor/NewEditor/Undo">
							</td>
							<td><label for="Undo"><%=Translate.Translate("Fortryd")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Redo") = "True", "checked", "")%> id="Redo" name="/Globalsettings/Settings/TextEditor/NewEditor/Redo">
							</td>
							<td><label for="Redo"><%=Translate.Translate("Annuller fortryd")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Find") = "True", "checked", "")%> id="Find" name="/Globalsettings/Settings/TextEditor/NewEditor/Find">
							</td>
							<td><label for="Find"><%=Translate.Translate("Find")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Replace") = "True", "checked", "")%> id="Replace" name="/Globalsettings/Settings/TextEditor/NewEditor/Replace">
							</td>
							<td><label for="Replace"><%=Translate.Translate("Erstat")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/SelectAll") = "True", "checked", "")%> id="SelectAll" name="/Globalsettings/Settings/TextEditor/NewEditor/SelectAll">
							</td>
							<td><label for="SelectAll"><%=Translate.Translate("Marker alt",1)%></label>
							</td>
						</tr>
						<tr>
							<td colspan=2><strong><%=Translate.Translate("Indsæt",2)%></strong></td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Link") = "True", "checked", "")%> id="Link" name="/Globalsettings/Settings/TextEditor/NewEditor/Link">
							</td>
							<td><label for="Link"><%=Translate.Translate("Link")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Unlink") = "True", "checked", "")%> id="Unlink" name="/Globalsettings/Settings/TextEditor/NewEditor/Unlink">
							</td>
							<td><label for="Unlink"><%=Translate.Translate("Fjern link")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/DwPageLink") = "True", "checked", "")%> id="DwPageLink" name="/Globalsettings/Settings/TextEditor/NewEditor/DwPageLink" />
							</td>
							<td>
								<label for="DwPageLink"><%=Translate.Translate("Internt_link")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Anchor") = "True", "checked", "")%> id="Anchor" name="/Globalsettings/Settings/TextEditor/NewEditor/Anchor">
							</td>
							<td><label for="Anchor"><%=Translate.Translate("Bogmærke")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Image") = "True", "checked", "")%> id="Image" name="/Globalsettings/Settings/TextEditor/NewEditor/Image">
							</td>
							<td><label for="Image"><%=Translate.Translate("Billede")%></label>
							</td>
						</tr>
						
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Flash") = "True", "checked", "")%> id="Flash" name="/Globalsettings/Settings/TextEditor/NewEditor/Flash">
							</td>
							<td><label for="Flash"><%=Translate.Translate("Flash")%></label>
							</td>
						</tr>
						
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Table") = "True", "checked", "")%> id="Table" name="/Globalsettings/Settings/TextEditor/NewEditor/Table">
							</td>
							<td><label for="Table"><%=Translate.Translate("Tabel")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Rule") = "True", "checked", "")%> id="Rule" name="/Globalsettings/Settings/TextEditor/NewEditor/Rule">
							</td>
							<td><label for="Rule"><%=Translate.Translate("Vandret linie")%></label>
							</td>
						</tr>
						<!--tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Smiley") = "True", "checked", "")%> id="Smiley" name="/Globalsettings/Settings/TextEditor/NewEditor/Smiley">
							</td>
							<td><label for="Smiley"><%=Translate.Translate("Smiley")%></label>
							</td>
						</tr-->
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/SpecialChar") = "True", "checked", "")%> id="SpecialChar" name="/Globalsettings/Settings/TextEditor/NewEditor/SpecialChar">
							</td>
							<td><label for="SpecialChar"><%=Translate.Translate("Symbol")%></label>
							</td>
						</tr>
						<!--tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/PageBreak") = "True", "checked", "")%> id="PageBreak" name="/Globalsettings/Settings/TextEditor/NewEditor/PageBreak">
							</td>
							<td><label for="PageBreak"><%=Translate.Translate("Sideskift")%></label>
							</td>
						</tr-->

						<tr>
							<td colspan=2><strong><%=Translate.Translate("Formatering",2)%></strong></td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Bold") = "True", "checked", "")%> id="Bold" name="/Globalsettings/Settings/TextEditor/NewEditor/Bold">
							</td>
							<td><label for="Bold"><%=Translate.Translate("Fed")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Italic") = "True", "checked", "")%> id="Italic" name="/Globalsettings/Settings/TextEditor/NewEditor/Italic">
							</td>
							<td><label for="Italic"><%=Translate.Translate("Kursiv")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Underline") = "True", "checked", "")%> id="Underline" name="/Globalsettings/Settings/TextEditor/NewEditor/Underline">
							</td>
							<td><label for="Underline"><%=Translate.Translate("Understreget")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/StrikeThrough") = "True", "checked", "")%> id="StrikeThrough" name="/Globalsettings/Settings/TextEditor/NewEditor/StrikeThrough">
							</td>
							<td><label for="StrikeThrough"><%=Translate.Translate("Overstreget")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Subscript") = "True", "checked", "")%> id="Subscript" name="/Globalsettings/Settings/TextEditor/NewEditor/Subscript">
							</td>
							<td><label for="Subscript"><%=Translate.Translate("Sænket skrift")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Superscript") = "True", "checked", "")%> id="Superscript" name="/Globalsettings/Settings/TextEditor/NewEditor/Superscript">
							</td>
							<td><label for="Superscript"><%=Translate.Translate("Hævet skrift")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/RemoveFormat") = "True", "checked", "")%> id="RemoveFormat" name="/Globalsettings/Settings/TextEditor/NewEditor/RemoveFormat">
							</td>
							<td><label for="RemoveFormat"><%=Translate.Translate("Fjern formatering")%></label>
							</td>
						</tr>

						<tr>
							<td colspan=2><strong><%=Translate.Translate("Justering",2)%></strong></td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/JustifyLeft") = "True", "checked", "")%> id="JustifyLeft" name="/Globalsettings/Settings/TextEditor/NewEditor/JustifyLeft">
							</td>
							<td><label for="JustifyLeft"><%=Translate.Translate("Venstrejusteret")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/JustifyCenter") = "True", "checked", "")%> id="JustifyCenter" name="/Globalsettings/Settings/TextEditor/NewEditor/JustifyCenter">
							</td>
							<td><label for="JustifyCenter"><%=Translate.Translate("Centreret")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/JustifyRight") = "True", "checked", "")%> id="JustifyRight" name="/Globalsettings/Settings/TextEditor/NewEditor/JustifyRight">
							</td>
							<td><label for="JustifyRight"><%=Translate.Translate("Højrejusteret")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/JustifyFull") = "True", "checked", "")%> id="JustifyFull" name="/Globalsettings/Settings/TextEditor/NewEditor/JustifyFull">
							</td>
							<td><label for="JustifyFull"><%=Translate.Translate("Lige margener",1)%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/OrderedList") = "True", "checked", "")%> id="OrderedList" name="/Globalsettings/Settings/TextEditor/NewEditor/OrderedList">
							</td>
							<td><label for="OrderedList"><%=Translate.Translate("Talopstilling")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/UnorderedList") = "True", "checked", "")%> id="UnorderedList" name="/Globalsettings/Settings/TextEditor/NewEditor/UnorderedList">
							</td>
							<td><label for="UnorderedList"><%=Translate.Translate("Punktopstilling")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Outdent") = "True", "checked", "")%> id="Outdent" name="/Globalsettings/Settings/TextEditor/NewEditor/Outdent">
							</td>
							<td><label for="Outdent"><%=Translate.Translate("Formindsk indrykning")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Indent") = "True", "checked", "")%> id="Indent" name="/Globalsettings/Settings/TextEditor/NewEditor/Indent">
							</td>
							<td><label for="Indent"><%=Translate.Translate("Forøg indrykning")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left: 40px;">
								<input id="Blockquote" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Blockquote") = "True", "checked", "")%>=""
									name="/Globalsettings/Settings/TextEditor/NewEditor/Blockquote" type="checkbox"
									value="True">
							</td>
							<td>
								<label for="Blockquote">
									<%=Translate.Translate("Blockquote")%>
								</label>
							</td>
						</tr>
						<tr>
							<td colspan=2><strong><%=Translate.Translate("Typografi",2)%></strong></td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Style") = "True", "checked", "")%> id="Style" name="/Globalsettings/Settings/TextEditor/NewEditor/Style">
							</td>
							<td><label for="Style"><%=Translate.Translate("Typografi")%></label>
							</td>
						</tr>
						<!--tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/FontFormat") = "True", "checked", "")%> id="FontFormat" name="/Globalsettings/Settings/TextEditor/NewEditor/FontFormat">
							</td>
							<td><label for="FontFormat"><%=Translate.Translate("Typografi")%></label>
							</td>
						</tr-->
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/FontName") = "True", "checked", "")%> id="FontName" name="/Globalsettings/Settings/TextEditor/NewEditor/FontName">
							</td>
							<td><label for="FontName"><%=Translate.Translate("Skrifttype")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/FontSize") = "True", "checked", "")%> id="FontSize" name="/Globalsettings/Settings/TextEditor/NewEditor/FontSize">
							</td>
							<td><label for="FontSize"><%=Translate.Translate("Skriftstørrelse")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/TextColor") = "True", "checked", "")%> id="TextColor" name="/Globalsettings/Settings/TextEditor/NewEditor/TextColor">
							</td>
							<td><label for="TextColor"><%=Translate.Translate("Tekst farve")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/BGColor") = "True", "checked", "")%> id="BGColor" name="/Globalsettings/Settings/TextEditor/NewEditor/BGColor">
							</td>
							<td><label for="BGColor"><%=Translate.Translate("Baggrundsfarve")%></label>
							</td>
						</tr>
						
						<!--tr> DO NOT DELETE, we might need it later
							<td colspan=2><strong><%=Translate.Translate("Formularer",2)%></strong></td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Form") = "True", "checked", "")%> id="Form" name="/Globalsettings/Settings/TextEditor/NewEditor/Form">
							</td>
							<td><label for="Form"><%=Translate.Translate("Formular")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Checkbox") = "True", "checked", "")%> id="Checkbox" name="/Globalsettings/Settings/TextEditor/NewEditor/Checkbox">
							</td>
							<td><label for="Checkbox"><%=Translate.Translate("Checkboks")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Radio") = "True", "checked", "")%> id="Radio" name="/Globalsettings/Settings/TextEditor/NewEditor/Radio">
							</td>
							<td><label for="Radio"><%=Translate.Translate("Radio-knap")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/TextField") = "True", "checked", "")%> id="TextField" name="/Globalsettings/Settings/TextEditor/NewEditor/TextField">
							</td>
							<td><label for="TextField"><%=Translate.Translate("Tekstfelt")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Textarea") = "True", "checked", "")%> id="Textarea" name="/Globalsettings/Settings/TextEditor/NewEditor/Textarea">
							</td>
							<td><label for="Textarea"><%=Translate.Translate("Tekstområde")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Select") = "True", "checked", "")%> id="Select" name="/Globalsettings/Settings/TextEditor/NewEditor/Select">
							</td>
							<td><label for="Select"><%=Translate.Translate("Liste")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Button") = "True", "checked", "")%> id="Button" name="/Globalsettings/Settings/TextEditor/NewEditor/Button">
							</td>
							<td><label for="Button"><%=Translate.Translate("Knap")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/ImageButton") = "True", "checked", "")%> id="ImageButton" name="/Globalsettings/Settings/TextEditor/NewEditor/ImageButton">
							</td>
							<td><label for="ImageButton"><%=Translate.Translate("Billedknap")%></label>
							</td>
						</tr>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/HiddenField") = "True", "checked", "")%> id="HiddenField" name="/Globalsettings/Settings/TextEditor/NewEditor/HiddenField">
							</td>
							<td><label for="HiddenField"><%=Translate.Translate("Skjult felt")%></label>
							</td>
						</tr-->
					</table>
					<%=Gui.GroupBoxEnd%>
				</div>
				
				<div id="OldEditorSettings" style="display:<%=IIf((Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "" OR Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "EditorOld"), "", "none")%>;">
				<%If Base.HasVersion("18.3.1.0") And Session("DW_Admin_UserID") < 3 Then%>
				<%=Gui.GroupBoxStart(Translate.Translate("Editor"))%>
				<table border="0" cellpadding="2" cellspacing="0">
					<%
	                DISABLED = False
	                sql = "SELECT TOP 1 ParagraphID FROM [Paragraph]"

                    cmdTekstEditor.CommandText = sql
					Dim drTekstEditor As IDataReader = cmdTekstEditor.ExecuteReader()

	                If drTekstEditor.Read Then
		                DISABLED = True
	                End If
	                
	                drTekstEditor.Dispose
	                %>
					<tr>
						<td width="170"><%=Translate.Translate("Formatering")%></td>
						<td>
							<input type="radio" value="" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/Format") = "", "checked", "")%> id="DWeditorFormat1" name="/Globalsettings/Settings/TextEditor/Format" <%=IIf(DISABLED, " DISABLED=True", "")%>><label for="DWeditorFormat1"><%=Translate.Translate("Traditionel")%></label>
							<%	If DISABLED Then%>
							<input type=hidden value="<%=Base.GetGs("/Globalsettings/Settings/TextEditor/Format")%>" name="/Globalsettings/Settings/TextEditor/Format">
							<%	End If%>
						</td>
					</tr>
					<tr>
						<td></td>
						<td><input type="radio" value="Heading" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/Format") = "Heading", "checked", "")%> id="DWeditorFormat2" name="/Globalsettings/Settings/TextEditor/Format" <%=IIf(DISABLED, " DISABLED=True", "")%>><label for="DWeditorFormat2"><%=Translate.Translate("H1, H2 style")%></label></td>
					</tr>
					<tr>
						<td height="5"></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/ExtendedFormating") = "True", "checked", "")%> id="DWEditorExtendedFormating" name="/Globalsettings/Settings/TextEditor/ExtendedFormating"><label for="DWEditorExtendedFormating"><%=Translate.Translate("Udvidet formatering")%></label></td>
					</tr>
					<tr>
						<td height="5"></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Sæt ind")%></td>
						<td><input type="radio" value="" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/Paste") = "", "checked", "")%> id="DWeditorOnPaste1" name="/Globalsettings/Settings/TextEditor/Paste"><label for="DWeditorOnPaste1"><%=Translate.Translate("Ingen omformatering")%></label></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="radio" value="Compatible" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/Paste") = "Compatible", "checked", "")%> id="DWeditorOnPaste2" name="/Globalsettings/Settings/TextEditor/Paste"><label for="DWeditorOnPaste2"><%=Translate.Translate("Kompatibel omformatering")%></label></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="radio" value="StripAll" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/Paste") = "StripAll", "checked", "")%> id="DWeditorOnPaste3" name="/Globalsettings/Settings/TextEditor/Paste"><label for="DWeditorOnPaste3"><%=Translate.Translate("Fjern al formatering")%></label></td>
					</tr>
					<tr>
						<td height="5"></td>
					</tr>
					<tr>
						<td><label for="DWeditorFontColor"><%=Translate.Translate("Farve og fonte")%></label></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/ColorsAndFonts") = "True", "checked", "")%> id="DWeditorFontColor" name="/Globalsettings/Settings/TextEditor/ColorsAndFonts" /></td>
					</tr>
					<tr>
						<td><label for="DWEditorAllowWordEditing"><%=Translate.Translate("Aktiver Word-Editering")%></label></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/ActivateWordEditing") = "True", "checked", "")%> id="DWEditorAllowWordEditing" name="/Globalsettings/Settings/TextEditor/ActivateWordEditing" /></td>
					</tr>
					<%If Base.HasVersion("18.9.1.0") Then%>
						<tr>
							<td width="170"><%=Translate.Translate("Type")%></td>
							<td>
								<select class="std" name="/Globalsettings/Settings/TextEditor/Type" id="DWeditortype">
									<option value="default" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/Type") = "default", "selected", "")%>><%=Translate.Translate("Standard")%></option>
									<option value="enhanced" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/Type") = "enhanced", "selected", "")%>><%=Translate.Translate("Udvidet")%></option>
								</select>
							</td>
						</tr>
					<%End If%>
				</table>
				
				<%Else%>
					<input type="hidden" value="<%=Base.GetGs("/Globalsettings/Settings/TextEditor/Format")%>" name="/Globalsettings/Settings/TextEditor/Format" />
				<%End If%>
<!--bbr-->
				</div>
					<%=Gui.GroupBoxStart(Translate.Translate("Side"))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td style="padding-left: 170px;">
								<input id="/Globalsettings/Settings/Page/Edit/ShowLogoAlt" <%=IIf(Base.GetGs("/Globalsettings/Settings/Page/Edit/ShowLogoAlt") = "True", "checked", "")%>
									name="/Globalsettings/Settings/Page/Edit/ShowLogoAlt" type="checkbox" value="True" />
							</td>
							<td>
								<label for="/Globalsettings/Settings/Page/Edit/ShowLogoAlt">
									<%=Translate.Translate("Show alt tekst for logo")%>
								</label>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>

					<%=Gui.GroupBoxStart(Translate.Translate("Date selector"))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td style="padding-left: 170px;">
								<input id="/Globalsettings/Settings/Page/Edit/DisablePopupCalendar" <%=IIf(Base.GetGs("/Globalsettings/Settings/Page/Edit/DisablePopupCalendar") = "True", "checked", "")%>
									name="/Globalsettings/Settings/Page/Edit/DisablePopupCalendar" type="checkbox" value="True">
							</td>
							<td>
								<label for="/Globalsettings/Settings/Page/Edit/DisablePopupCalendar">
									<%=Translate.Translate("Disable the popup calendar")%>
								</label>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
				</td>
				<tr>
					<td align="right" valign=bottom>
						<table>
							<tr>
								<td>
									<%=Gui.Button(Translate.Translate("OK"), "findCheckboxNames(this.form);OK_OnClick();", "90")%>
								</td>
								<td>
									<%=Gui.Button(Translate.Translate("Annuller"), "location='ControlPanel.aspx';", "90")%>
								</td>
								<%=Gui.HelpButton("", "administration.controlpanel.editing")%>
								<td width="2"></td>
							</tr>
						</table>
					</td>
				</tr>
			</td>
		</tr>
    </table>
</form>
<% If Not Base.GsExists("/Globalsettings/Settings/TextEditor/NewEditor/Source") Then%>
<script type="text/javascript">
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/EditorHeight'].value = 500;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Source'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Preview'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Templates'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Print'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/SpellCheck'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/GoogleTranslate'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/UniversalKey'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Cut'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Copy'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Paste'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/PasteText'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/PasteWord'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Undo'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Redo'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Find'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Replace'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/SelectAll'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Link'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Unlink'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/DwPageLink'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Anchor'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Image'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Table'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Rule'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/SpecialChar'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Bold'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Italic'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Underline'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/StrikeThrough'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Subscript'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Superscript'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/RemoveFormat'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/JustifyLeft'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/JustifyCenter'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/JustifyRight'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/JustifyFull'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/OrderedList'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/UnorderedList'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Outdent'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Indent'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/Style'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/FontName'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/FontSize'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/TextColor'].checked = true;
document.getElementById('frmGlobalSettings')['/Globalsettings/Settings/TextEditor/NewEditor/BGColor'].checked = true;
</script>
<%End If%>
<%
TekstEditorConn.Dispose
Translate.GetEditOnlineScript()
%>
</body>
</html>