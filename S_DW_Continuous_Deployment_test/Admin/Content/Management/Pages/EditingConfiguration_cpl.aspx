<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" Codebehind="EditingConfiguration_cpl.aspx.vb" Inherits="Dynamicweb.Admin.EditingConfiguration_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
    
    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function() {
			    page.submit();
        }
    </script>
    
    <%
        Dim DISABLED As Boolean
        Dim sql As String
        Dim DWParagraphMaxLockTime As String
        Dim strParagraphBottomSpace As String
    %>

    <style type="text/css">
        span.editor-notification
        {
        display: block;
        margin-top: 2px;
        margin-left: 2px;
        padding-left: 20px;
        background: url('/Admin/Images/Ribbon/Icons/Small/information.png') top left no-repeat;
        height: 22px;
        color: #8c8c8c;
        }
    </style>

</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server" ID="MainContent">
    <div id="PageContent">
        <TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable" runat="server" id="classicViewTable">
		<TR>
			<TD valign="top">
				<%	If Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "EditorNew" Then%>
				
				
				<div id="NewEditorSettings" style="display:<%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "EditorNew", "", "none")%>;">

				<%=Gui.GroupBoxStart(Translate.Translate("Editor"))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td>
							</td>
							<td>			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/UseStylesheet") = "True", "checked", "")%> id="UseStylesheet" name="/Globalsettings/Settings/TextEditor/NewEditor/UseStylesheet" />
								<label for="UseStylesheet"><%=Translate.Translate("Brug stylesheet i editor")%></label><br />
                                <span class="editor-notification"><dw:TranslateLabel id="lbEditorNotification" Text="Activating this setting can on rare occasions break the editor on paragraphs. If this happens to you then disable this setting again." runat="server" /></span> 
							</td>
						</tr>
						<tr>
							<td>
							</td>
							<td>			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/OnlyOwnStyles") = "True", "checked", "")%> id="/Globalsettings/Settings/TextEditor/NewEditor/OnlyOwnStyles" name="/Globalsettings/Settings/TextEditor/NewEditor/OnlyOwnStyles" />
								<label for="/Globalsettings/Settings/TextEditor/NewEditor/OnlyOwnStyles"><%= Translate.Translate("Only use own typography styles")%> (/Files/System/Styles.xml)</label>
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
<%--				    <tr>
						    <td valign="top"><%=Translate.Translate("Spellchecker language")%></td>r
						    <td>
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
				<%=Gui.GroupBoxStart(Translate.Translate("Værktøjslinier"))%>
					<TABLE border="0" cellpadding="2" cellspacing="0">
						<TR>
							<TD colspan=2><strong><%=Translate.Translate("Funktioner",2)%></strong></TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Source") = "True", "checked", "")%> id="Source" name="/Globalsettings/Settings/TextEditor/NewEditor/Source">
							</TD>
							<TD><LABEL for="Source"><%=Translate.Translate("Kilde")%></LABEL>
							</TD>
						</TR>
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
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/SpellCheck") = "True", "checked", "")%> id="SpellCheck" name="/Globalsettings/Settings/TextEditor/NewEditor/SpellCheck"/>
							</td>
							<td><label for="SpellCheck"><%=Translate.Translate("Stavekontrol")%></label>
							</td>
						</tr>
						<%If Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/GoogleTranslate") = "True" Then%>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/GoogleTranslate") = "True", "checked", "")%> id="GoogleTranslate" name="/Globalsettings/Settings/TextEditor/NewEditor/GoogleTranslate" />
							</td>
							<td><label for="GoogleTranslate"><%=Translate.Translate("Translate")%></label>
							</td>
						</tr>
						<%End If%>
						<tr>
							<td style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/UniversalKey") = "True", "checked", "")%> id="UniversalKey" name="/Globalsettings/Settings/TextEditor/NewEditor/UniversalKey">
							</td>
							<td><label for="UniversalKey"><%=Translate.Translate("Universaltastatur")%></label>
							</td>
						</tr>

						
						<tr>
							<td colspan=2><strong><%=Translate.Translate("Rediger",2)%></strong></TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Cut") = "True", "checked", "")%> id="Cut" name="/Globalsettings/Settings/TextEditor/NewEditor/Cut">
							</TD>
							<TD><label for="Cut"><%=Translate.Translate("Klip")%></label>
							</TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Copy") = "True", "checked", "")%> id="Copy" name="/Globalsettings/Settings/TextEditor/NewEditor/Copy">
							</TD>
							<TD><label for="Copy"><%=Translate.Translate("Kopier")%></label>
							</TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Paste") = "True", "checked", "")%> id="Paste" name="/Globalsettings/Settings/TextEditor/NewEditor/Paste">
							</TD>
							<TD><label for="Paste"><%=Translate.Translate("Sæt ind")%></label>
							</TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/PasteText") = "True", "checked", "")%> id="PasteText" name="/Globalsettings/Settings/TextEditor/NewEditor/PasteText">
							</TD>
							<TD><label for="PasteText"><%=Translate.Translate("Sæt ind som tekst")%></label>
							</TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/PasteWord") = "True", "checked", "")%> id="PasteWord" name="/Globalsettings/Settings/TextEditor/NewEditor/PasteWord">
							</TD>
							<TD><label for="PasteWord"><%=Translate.Translate("Sæt ind fra Word")%></label>
							</TD>
						</tr>
                        <tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/DwInsertCode") = "True", "checked", "")%> id="DwInsertCode" name="/Globalsettings/Settings/TextEditor/NewEditor/DwInsertCode">
							</TD>
							<TD><label for="DwInsertCode"><%=Translate.Translate("Paste code")%></label>
							</TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Undo") = "True", "checked", "")%> id="Undo" name="/Globalsettings/Settings/TextEditor/NewEditor/Undo">
							</TD>
							<TD><label for="Undo"><%=Translate.Translate("Fortryd")%></label>
							</TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Redo") = "True", "checked", "")%> id="Redo" name="/Globalsettings/Settings/TextEditor/NewEditor/Redo">
							</TD>
							<TD><label for="Redo"><%=Translate.Translate("Annuller fortryd")%></label>
							</TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Find") = "True", "checked", "")%> id="Find" name="/Globalsettings/Settings/TextEditor/NewEditor/Find">
							</TD>
							<TD><LABEL for="Find"><%=Translate.Translate("Find")%></LABEL>
							</TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Replace") = "True", "checked", "")%> id="Replace" name="/Globalsettings/Settings/TextEditor/NewEditor/Replace">
							</TD>
							<TD><LABEL for="Replace"><%=Translate.Translate("Erstat")%></LABEL>
							</TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/SelectAll") = "True", "checked", "")%> id="SelectAll" name="/Globalsettings/Settings/TextEditor/NewEditor/SelectAll">
							</TD>
							<TD><LABEL for="SelectAll"><%=Translate.Translate("Marker alt",1)%></LABEL>
							</TD>
						</tr>
						<tr>
							<TD colspan=2><strong><%=Translate.Translate("Indsæt",2)%></strong></TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Link") = "True", "checked", "")%> id="Link" name="/Globalsettings/Settings/TextEditor/NewEditor/Link">
							</TD>
							<TD><LABEL for="Link"><%=Translate.Translate("Link")%></LABEL>
							</TD>
						</tr>
						<tr>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Unlink") = "True", "checked", "")%> id="Unlink" name="/Globalsettings/Settings/TextEditor/NewEditor/Unlink">
							</TD>
							<TD><LABEL for="Unlink"><%=Translate.Translate("Fjern link")%></LABEL>
							</TD>
						</tr>
						<tr>
							<td style="padding-left:40px;">
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/DwPageLink") = "True", "checked", "")%> id="DwPageLink" name="/Globalsettings/Settings/TextEditor/NewEditor/DwPageLink" />
							</td>
							<td>
								<label for="DwPageLink"><%=Translate.Translate("Internt_link")%></label>
							</td>
						</tr>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Anchor") = "True", "checked", "")%> id="Anchor" name="/Globalsettings/Settings/TextEditor/NewEditor/Anchor">
							</TD>
							<TD><LABEL for="Anchor"><%=Translate.Translate("Bogmærke")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Image") = "True", "checked", "")%> id="Image" name="/Globalsettings/Settings/TextEditor/NewEditor/Image">
							</TD>
							<TD><LABEL for="Image"><%=Translate.Translate("Billede")%></LABEL>
							</TD>
						</TR>
						
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Flash") = "True", "checked", "")%> id="Flash" name="/Globalsettings/Settings/TextEditor/NewEditor/Flash">
							</TD>
							<TD><LABEL for="Flash"><%=Translate.Translate("Flash")%></LABEL>
							</TD>
						</TR>
						
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Table") = "True", "checked", "")%> id="Table" name="/Globalsettings/Settings/TextEditor/NewEditor/Table">
							</TD>
							<TD><LABEL for="Table"><%=Translate.Translate("Tabel")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Rule") = "True", "checked", "")%> id="Rule" name="/Globalsettings/Settings/TextEditor/NewEditor/Rule">
							</TD>
							<TD><LABEL for="Rule"><%=Translate.Translate("Vandret linie")%></LABEL>
							</TD>
						</TR>
						<!--TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Smiley") = "True", "checked", "")%> id="Smiley" name="/Globalsettings/Settings/TextEditor/NewEditor/Smiley">
							</TD>
							<TD><LABEL for="Smiley"><%=Translate.Translate("Smiley")%></LABEL>
							</TD>
						</TR-->
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/SpecialChar") = "True", "checked", "")%> id="SpecialChar" name="/Globalsettings/Settings/TextEditor/NewEditor/SpecialChar">
							</TD>
							<TD><LABEL for="SpecialChar"><%=Translate.Translate("Symbol")%></LABEL>
							</TD>
						</TR>
						<!--TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/PageBreak") = "True", "checked", "")%> id="PageBreak" name="/Globalsettings/Settings/TextEditor/NewEditor/PageBreak">
							</TD>
							<TD><LABEL for="PageBreak"><%=Translate.Translate("Sideskift")%></LABEL>
							</TD>
						</TR-->

						<TR>
							<TD colspan=2><strong><%=Translate.Translate("Formatering",2)%></strong></TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Bold") = "True", "checked", "")%> id="Bold" name="/Globalsettings/Settings/TextEditor/NewEditor/Bold">
							</TD>
							<TD><LABEL for="Bold"><%=Translate.Translate("Fed")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Italic") = "True", "checked", "")%> id="Italic" name="/Globalsettings/Settings/TextEditor/NewEditor/Italic">
							</TD>
							<TD><LABEL for="Italic"><%=Translate.Translate("Kursiv")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Underline") = "True", "checked", "")%> id="Underline" name="/Globalsettings/Settings/TextEditor/NewEditor/Underline">
							</TD>
							<TD><LABEL for="Underline"><%=Translate.Translate("Understreget")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/StrikeThrough") = "True", "checked", "")%> id="StrikeThrough" name="/Globalsettings/Settings/TextEditor/NewEditor/StrikeThrough">
							</TD>
							<TD><LABEL for="StrikeThrough"><%=Translate.Translate("Overstreget")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Subscript") = "True", "checked", "")%> id="Subscript" name="/Globalsettings/Settings/TextEditor/NewEditor/Subscript">
							</TD>
							<TD><LABEL for="Subscript"><%=Translate.Translate("Sænket skrift")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Superscript") = "True", "checked", "")%> id="Superscript" name="/Globalsettings/Settings/TextEditor/NewEditor/Superscript">
							</TD>
							<TD><LABEL for="Superscript"><%=Translate.Translate("Hævet skrift")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/RemoveFormat") = "True", "checked", "")%> id="RemoveFormat" name="/Globalsettings/Settings/TextEditor/NewEditor/RemoveFormat">
							</TD>
							<TD><LABEL for="RemoveFormat"><%=Translate.Translate("Fjern formatering")%></LABEL>
							</TD>
						</TR>

						<TR>
							<TD colspan=2><strong><%=Translate.Translate("Justering",2)%></strong></TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/JustifyLeft") = "True", "checked", "")%> id="JustifyLeft" name="/Globalsettings/Settings/TextEditor/NewEditor/JustifyLeft">
							</TD>
							<TD><LABEL for="JustifyLeft"><%=Translate.Translate("Venstrejusteret")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/JustifyCenter") = "True", "checked", "")%> id="JustifyCenter" name="/Globalsettings/Settings/TextEditor/NewEditor/JustifyCenter">
							</TD>
							<TD><LABEL for="JustifyCenter"><%=Translate.Translate("Centreret")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/JustifyRight") = "True", "checked", "")%> id="JustifyRight" name="/Globalsettings/Settings/TextEditor/NewEditor/JustifyRight">
							</TD>
							<TD><LABEL for="JustifyRight"><%=Translate.Translate("Højrejusteret")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/JustifyFull") = "True", "checked", "")%> id="JustifyFull" name="/Globalsettings/Settings/TextEditor/NewEditor/JustifyFull">
							</TD>
							<TD><LABEL for="JustifyFull"><%=Translate.Translate("Lige margener",1)%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/OrderedList") = "True", "checked", "")%> id="OrderedList" name="/Globalsettings/Settings/TextEditor/NewEditor/OrderedList">
							</TD>
							<TD><LABEL for="OrderedList"><%=Translate.Translate("Talopstilling")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/UnorderedList") = "True", "checked", "")%> id="UnorderedList" name="/Globalsettings/Settings/TextEditor/NewEditor/UnorderedList">
							</TD>
							<TD><LABEL for="UnorderedList"><%=Translate.Translate("Punktopstilling")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Outdent") = "True", "checked", "")%> id="Outdent" name="/Globalsettings/Settings/TextEditor/NewEditor/Outdent">
							</TD>
							<TD><LABEL for="Outdent"><%=Translate.Translate("Formindsk indrykning")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Indent") = "True", "checked", "")%> id="Indent" name="/Globalsettings/Settings/TextEditor/NewEditor/Indent">
							</TD>
							<TD><LABEL for="Indent"><%=Translate.Translate("Forøg indrykning")%></LABEL>
							</TD>
						</TR>
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
						<TR>
							<TD colspan=2><strong><%=Translate.Translate("Typografi",2)%></strong></TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Style") = "True", "checked", "")%> id="Style" name="/Globalsettings/Settings/TextEditor/NewEditor/Style">
							</TD>
							<TD><LABEL for="Style"><%=Translate.Translate("Typografi")%></LABEL>
							</TD>
						</TR>
						<!--TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/FontFormat") = "True", "checked", "")%> id="FontFormat" name="/Globalsettings/Settings/TextEditor/NewEditor/FontFormat">
							</TD>
							<TD><LABEL for="FontFormat"><%=Translate.Translate("Typografi")%></LABEL>
							</TD>
						</TR-->
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/FontName") = "True", "checked", "")%> id="FontName" name="/Globalsettings/Settings/TextEditor/NewEditor/FontName">
							</TD>
							<TD><LABEL for="FontName"><%=Translate.Translate("Skrifttype")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/FontSize") = "True", "checked", "")%> id="FontSize" name="/Globalsettings/Settings/TextEditor/NewEditor/FontSize">
							</TD>
							<TD><LABEL for="FontSize"><%=Translate.Translate("Skriftstørrelse")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/TextColor") = "True", "checked", "")%> id="TextColor" name="/Globalsettings/Settings/TextEditor/NewEditor/TextColor">
							</TD>
							<TD><LABEL for="TextColor"><%=Translate.Translate("Tekst farve")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/BGColor") = "True", "checked", "")%> id="BGColor" name="/Globalsettings/Settings/TextEditor/NewEditor/BGColor">
							</TD>
							<TD><LABEL for="BGColor"><%=Translate.Translate("Baggrundsfarve")%></LABEL>
							</TD>
						</TR>
						
						<!--TR> DO NOT DELETE, we might need it later
							<TD colspan=2><strong><%=Translate.Translate("Formularer",2)%></strong></TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Form") = "True", "checked", "")%> id="Form" name="/Globalsettings/Settings/TextEditor/NewEditor/Form">
							</TD>
							<TD><LABEL for="Form"><%=Translate.Translate("Formular")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Checkbox") = "True", "checked", "")%> id="Checkbox" name="/Globalsettings/Settings/TextEditor/NewEditor/Checkbox">
							</TD>
							<TD><LABEL for="Checkbox"><%=Translate.Translate("Checkboks")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Radio") = "True", "checked", "")%> id="Radio" name="/Globalsettings/Settings/TextEditor/NewEditor/Radio">
							</TD>
							<TD><LABEL for="Radio"><%=Translate.Translate("Radio-knap")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/TextField") = "True", "checked", "")%> id="TextField" name="/Globalsettings/Settings/TextEditor/NewEditor/TextField">
							</TD>
							<TD><LABEL for="TextField"><%=Translate.Translate("Tekstfelt")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Textarea") = "True", "checked", "")%> id="Textarea" name="/Globalsettings/Settings/TextEditor/NewEditor/Textarea">
							</TD>
							<TD><LABEL for="Textarea"><%=Translate.Translate("Tekstområde")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Select") = "True", "checked", "")%> id="Select" name="/Globalsettings/Settings/TextEditor/NewEditor/Select">
							</TD>
							<TD><LABEL for="Select"><%=Translate.Translate("Liste")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/Button") = "True", "checked", "")%> id="Button" name="/Globalsettings/Settings/TextEditor/NewEditor/Button">
							</TD>
							<TD><LABEL for="Button"><%=Translate.Translate("Knap")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/ImageButton") = "True", "checked", "")%> id="ImageButton" name="/Globalsettings/Settings/TextEditor/NewEditor/ImageButton">
							</TD>
							<TD><LABEL for="ImageButton"><%=Translate.Translate("Billedknap")%></LABEL>
							</TD>
						</TR>
						<TR>
							<TD style="padding-left:40px;">			
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/NewEditor/HiddenField") = "True", "checked", "")%> id="HiddenField" name="/Globalsettings/Settings/TextEditor/NewEditor/HiddenField">
							</TD>
							<TD><LABEL for="HiddenField"><%=Translate.Translate("Skjult felt")%></LABEL>
							</TD>
						</TR-->
					</table>
					<%=Gui.GroupBoxEnd%>
				</div>
				<%End If%>

				</td>
		</TR>
	</TABLE>
	
	<% If Not Base.GsExists("/Globalsettings/Settings/TextEditor/NewEditor/Source") Then%>
<script>
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/EditorHeight'].value = 500;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/EditorWidth'].value = 580;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Source'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Preview'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Templates'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Print'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/SpellCheck'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/UniversalKey'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Cut'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Copy'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Paste'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/PasteText'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/PasteWord'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Undo'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Redo'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Find'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Replace'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/SelectAll'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Link'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Unlink'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/DwPageLink'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Anchor'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Image'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Table'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Rule'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/SpecialChar'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Bold'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Italic'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Underline'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/StrikeThrough'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Subscript'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Superscript'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/RemoveFormat'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/JustifyLeft'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/JustifyCenter'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/JustifyRight'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/JustifyFull'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/OrderedList'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/UnorderedList'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Outdent'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Indent'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/Style'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/FontName'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/FontSize'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/TextColor'].checked = true;
    document.frmGlobalSettings['/Globalsettings/Settings/TextEditor/NewEditor/BGColor'].checked = true;
</script>
<%End If%>
<%
	Translate.GetEditOnlineScript()
%>
    </div>
</asp:Content>
