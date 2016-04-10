<%@ Page CodeBehind="Paragraph_Edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Paragraph_Edit" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.SystemTools.Inherit" %>
<%
	If Gui.NewUI() Then
		Response.Redirect("/Admin/Content/ParagraphEdit.aspx?ID=" & Base.ChkInteger(Request.QueryString("ID")) & "&PageID=" & Base.ChkInteger(Request.QueryString("PageID")))
	End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title><%=Translate.JSTranslate("Rediger %%","%%",Translate.JSTranslate("afsnit"))%></title>
	<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
	<script language="JavaScript">
		var popupTemplateWindow;
		function layout(){
			LayoutWin = window.open("Template/Template.aspx", "Template", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=600,height=400,screenX=50,screenY=50");
			LayoutWin.focus();
		}

		function lukVindue() {
		   LayoutWin.close();
		}

		function show(i) {
			hideEditor();
			/*
			if (document.all[i].style.display=='none') {
				document.all[i].style.display='';
			}else{
				document.all[i].style.display='none';
			}
			*/
			
			if (document.getElementById(i).style.display=='none') {
				document.getElementById(i).style.display='';
			}else{
				document.getElementById(i).style.display='none';
			}			
		}

		function Send(FileToHandle){
			var NewVersion = false;
			if(document.getElementById('ParagraphImageURL')) {
				document.getElementById('ParagraphImageURL').value = unescape(document.getElementById('ParagraphImageURL').value)
			}
			if (document.getElementById('paragraph_edit').ParagraphHeader.value.length < 1){
				TabClick(document.getElementById('Tab1_head'));
				document.getElementById('paragraph_edit').ParagraphHeader.focus();
				alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
			}
			else {
				document.getElementById('paragraph_edit').target = "";
				document.getElementById('paragraph_edit').action = FileToHandle;
				document.getElementById('paragraph_edit').submit();
			}
		}

		function ValidateInt(obj) {
			if (!parseInt(obj.value)) {
				obj.value=0;
				alert('<%=Translate.JsTranslate("Angiv heltal")%>');
			}
			else {
				obj.value = parseInt(obj.value);
			}
		}

		function setFocus(){
			//if(document.all.Tab1[1].style.display!="none"){
			if(document.getElementById('Tab1').style.display!="none"){
			    InitFckEditor();
				setTimeout("document.getElementById('paragraph_edit').ParagraphHeader.focus()", 250);
			}
		}

		function showModules(intPageID){
			//window.open('Paragraph_Modules.aspx?PageID=' + intPageID + '&NewSort=<%=CStr(Request.QueryString("NewSort"))%>', 'Modules', 'location=no,scrollbars=auto,directories=no,menubar=no,toolbar=no,width=380,height=350,resizable=no,titlebar=no,status=no');
			
			var moduleUrl = "Paragraph_Modules.aspx?PageID="+ intPageID +"&NewSort=<%=CStr(Request.QueryString("NewSort"))%>";
			var mWidth = 405;
			var mHeight = 450;
			window.open(moduleUrl ,'Modules',"displayWindow,width="+ mWidth +",height="+ mHeight +",scrollbars=yes");

		}
	</script>
<%

Dim strHeadersJS as string
strHeadersJS = "Indhold,Egenskaber,Modul"
if boolShowGlobal then
	strHeadersJS = strHeadersJS + ",Global element"
end if
Response.Write(Gui.MakeHeaders("Afsnitsredigering - " & PageMenuText, strHeadersJS, "JavaScript"))

Dim TabID As Integer = 1
If HttpContext.Current.Request.QueryString("Tab") <> "" Then
	TabID = Ctype(HttpContext.Current.Request.QueryString("Tab"), Integer)
End If
Dim strSetFocus As String
If TabID < 2 Then
	strSetFocus = "setFocus();"
End If
%>
<BODY  onLoad="<%=strSetFocus%>document.getElementById('BodyContent').style.display='';">
<div ID="BodyContent" style="display:none">
<%
Dim strHeaders as string = Translate.Translate("Indhold") & "," & Translate.Translate("Modul") & "," & Translate.Translate("Egenskaber")
Dim ParagraphHeaderCount as integer= 3

if boolShowGlobal then
  ParagraphHeaderCount = ParagraphHeaderCount + 1
  strHeaders = strHeaders & "," & Translate.Translate("Global element")
end if
%>
<iframe name="saver" style="display:none;"></iframe>
<%If ParagraphID = "" Then%>
	<form method="post" action="paragraph_save.aspx?ShowAgain=True" name="paragraph_edit" id="paragraph_edit" onsubmit="html();">
<%Else%>
	<form action="paragraph_save.aspx" method="post" name="paragraph_edit" id="paragraph_edit" target="saver">
<%End If%>
<INPUT type="Hidden" name="ParagraphPageID" value="<%=ParagraphPageID%>">
<input type="Hidden" name="PageID" value="<%=ParagraphPageID%>">
<INPUT type="Hidden" name="ParagraphID" value="<%=ParagraphID%>" ID="ParagraphID">
<input type="Hidden" name="ID" value="<%=ParagraphID%>">
<input type="Hidden" name="ParagraphModuleSystemName" value="<%=ParagraphModuleSystemName%>">
<INPUT type="Hidden" name="NewSort" value="<%=Request.QueryString.Item("NewSort")%>">
<input type="hidden" name="Audit" value="<%=Request.Item("Audit")%>" ID="Audit">
<input type="hidden" name="AuditUserID" value="<%=Request.Item("AuditUserID")%>" ID="AuditUserID">
<input type="hidden" name="AuditDateTimeFrom" value="<%=Request.Item("AuditDateTimeFrom")%>" ID="AuditDateTimeFrom">
<input type="hidden" name="AuditDateTimeTo" value="<%=Request.Item("AuditDateTimeTo")%>" ID="AuditDateTimeTo">
<input type="hidden" name="AuditType" value="<%=Request.Item("AuditType")%>" ID="AuditType">
<input type="hidden" name="AuditSortOrder" value="<%=Request.Item("SortOrder")%>" ID="SortOrder">
<input type="hidden" name="AuditSortField" value="<%=Request.Item("SortField")%>" ID="SortField">
<input type="hidden" name="ApprovalType" value="<%=ApprovalType%>">
<input type="hidden" name="ApprovalState" value="<%=ApprovalState%>">
<input type="hidden" name="ReturnToPageID" value="<%=ReturnToPageID%>">
<%=Gui.MakeHeaders(Translate.Translate("Afsnitsredigering") & " - " & PageMenuText, strHeaders, "HTML")%>
<TABLE border="0" cellpadding="0" cellspacing="0" class=tabTable>
	<tr>
		<td valign="top">
			<DIV ID="Tab1" STYLE="display:;">
			<br>
			<table cellspacing="0" border="0" cellpadding="2" width="100%">
				<%if boolShowGlobal = true and Base.HasVersion("18.10.1.0") then%>
					<tr>
						<td><table bgcolor="#ffffe1" style="border: 1px solid Black;width: 100%;"><tr><td><img src="/Admin/Images/icons/alert_small.gif" align="absmiddle" alt="">&nbsp;<%=Translate.JSTranslate("Global element med %% referencer.", "%%", intGlobalPageCount.ToString)%></td></tr></table></td>
					</tr>
				<%end if%>
				<tr>
					<td colspan="2"><strong><%=Translate.Translate("Afsnitsnavn")%></strong> <%=Translate.Translate("(skal angives)")%> <%= GetInheritCompare("ParagraphHeader", ParagraphHeader)%></td>				</tr>
				<tr>
					<td colspan="2"><INPUT type="text" NAME="ParagraphHeader" VALUE="<%=ParagraphHeader%>" STYLE="WIDTH:580px;" class="std" maxlength="255"></td>
				</tr>
				<tr>
					<td colspan="2">
						<strong><%=Translate.Translate("Afsnitstekst")%></strong>
					<%= GetInheritCompare("ParagraphText", ParagraphText)%>
					&nbsp;
						<%If Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "EditorNew" Then%>
							<%
								Dim EditorStylesheetID As Integer
								Dim objSaveCulture As System.Globalization.CultureInfo = CType(System.Threading.Thread.CurrentThread.CurrentCulture.Clone(), System.Globalization.CultureInfo)
								If Base.GetGs("/Globalsettings/Modules/Users/UpdateOnLogoff") <> "refresh" Then
									Dim p As New Dynamicweb.Frontend.PageView
									p.ID = ParagraphPageID
									p.Redirect = False
									Try
										p.Load()
							            EditorStylesheetID = GetStylesheetId(p)
									Catch
									End Try
									
								End If
								If EditorStylesheetID = 0 Then
									Dim SearchPageID As Integer = ParagraphPageID
									Dim PageDR As IDataReader
									Do
										PageDR = Database.CreateDataReader(String.Format("SELECT PageParentPageID, PageStylesheet FROM Page WHERE PageID = {0}", SearchPageID.ToString()), "Dynamic.mdb")
										If PageDR.Read() Then
											If Base.ChkNumber(PageDR.Item("PageStylesheet")) > 0 Then
												EditorStylesheetID = Base.ChkNumber(PageDR.Item("PageStylesheet"))
											End If
											SearchPageID = Base.ChkNumber(PageDR.Item("PageParentPageID"))
										End If
										PageDR.Close()
									Loop While EditorStylesheetID < 1 And SearchPageID > 0
									PageDR.Dispose()
									
									If EditorStylesheetID = 0 Then
										Dim SearchAreaID As Integer = Base.ChkNumber(Database.ExecuteScalar(String.Format("SELECT PageAreaID FROM Page WHERE PageID ={0}", ParagraphPageID.ToString()), "Dynamic.mdb"))
										If SearchAreaID > 0 Then
											EditorStylesheetID = Base.ChkNumber(Database.ExecuteScalar(String.Format("SELECT AreaStyleID FROM Area WHERE AreaID = {0}", SearchAreaID.ToString()), "Dynamic.mdb"))
										End If
									End If
									
									If EditorStylesheetID = 0 Then
										EditorStylesheetID = 1
									End If
								End If
							
								System.Threading.Thread.CurrentThread.CurrentCulture = objSaveCulture
							%>
                            <%= Gui.Editor("ParagraphText", 0, 0, ParagraphText, "", Nothing, "/files/stylesheet" & EditorStylesheetID.ToString() & ".css", "DwCustomConfig", Gui.EditorEdition.SystemDefault, True, False, True)%></td>
						<%Else%>
					<%=Gui.Editor("ParagraphText", 0, 0, ParagraphText)%>
						<%End If%>
					</td>
				</tr>
				<tr height=5>
					<td></td>
				</tr>
				<tr>
					<td colspan="2">
						<table cellspacing="0" border="0" cellpadding="0" width="100%">
							<tr>
								<td width="10">&nbsp;</td>
								<td width="">&nbsp;<strong><%=Translate.Translate("Template")%></strong><%=GetInheritCompare("ParagraphTemplateID", ParagraphTemplateID)%></td>
								<td width="10">&nbsp;</td>
								<td width="1" bgcolor="#000000"></td>
								<td width="">&nbsp;<strong><%=Translate.Translate("Billede")%></strong><%=GetInheritCompare("ParagraphImage", ParagraphImage)%></td>
							</tr>
							<tr>
								<td width="10">&nbsp;</td>
								
								<%=Gui.TemplatePreview(ParagraphTemplateID, "paragraph")%>
								<td width="10">&nbsp;</td>
								<td width="1" bgcolor="#000000"></td>
								<td nowrap>&nbsp;
								<%
								    Response.Write(Gui.FileManager(ParagraphImage, Dynamicweb.Content.Management.Installation.ImagesFolderName, "ParagraphImage"))
								
								    If ParagraphImageURL <> "" Then
								        ParagraphImageURLpopup = Replace(Replace(Replace(Replace(Server.UrlEncode(ParagraphImageURL), "'", "%p", ), "(", "%p1"), ")", "%p2"), ".", "%p3")
								        If InStr(ParagraphImageMouseOver, "'") Then
								            ParagraphImageMouseOver = Replace(ParagraphImageMouseOver, "'", "")
								        End If
								    End If
								    If InStr(ParagraphImageCaption, "'") Then
								        ParagraphImageCaption = Replace(ParagraphImageCaption, "'", "")
								    End If

								    If InStr(ParagraphImageMouseOver, "'") Then
								        ParagraphImageMouseOver = Replace(ParagraphImageMouseOver, "'", "")
								    End If
								%>
								<img ID="ImageSettingsOpen" style="cursor: hand;" onclick="window.open('Paragraph_ImageSettings.aspx?ParagraphImageHAlign=<%=ParagraphImageHAlign%>&ParagraphImageHSpace=<%=ParagraphImageHSpace%>&ParagraphImageVSpace=<%=ParagraphImageVSpace%>&ParagraphImageVAlign=<%=ParagraphImageVAlign%>&ParagraphImageTarget=<%=ParagraphImageTarget%>&ParagraphImageMouseOver=<%=ParagraphImageMouseOver%>&ParagraphImageCaption=<%=ParagraphImageCaption%>&ParagraphImageURL=<%=ParagraphImageURLpopup%>&ParagraphImageResize=<%=ParagraphImageResize%>&ParagraphImageURL_Mode=<%=ParagraphImageURL_Mode%>&ParagraphImageURLTarget=<%=ParagraphImageURLTarget%>&ParagraphImageURLheight=<%=ParagraphImageURLheight%>&ParagraphImageURLleft=<%=ParagraphImageURLleft%>&ParagraphImageURLwidth=<%=ParagraphImageURLwidth%>&ParagraphImageURLtop=<%=ParagraphImageURLtop%>&ParagraphImageURLscrollbars=<%=ParagraphImageURLscrollbars%>&ParagraphImageURLtoolbar=<%=ParagraphImageURLtoolbar%>&ParagraphImageURLmenubar=<%=ParagraphImageURLmenubar%>&ParagraphImageURLstatus=<%=ParagraphImageURLstatus%>&ParagraphImageURLlocation=<%=ParagraphImageURLlocation%>&ParagraphImageURLresizable=<%=ParagraphImageURLresizable%>', '_lala', 'resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=560,height=400,top=155,left=202');" src="../images/Icons/Settings.gif" border="0" align=absmiddle alt="<%=Translate.JsTranslate("Indstillinger")%>">
	  							</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			</div>
			
			<DIV ID="Tab2" STYLE="display:none;">
			<br />
				<table cellspacing="0" border="0" cellpadding="0" width="100%">
					<%
					Response.Write(GetModules())

					If ParagraphModuleSystemName = ""  Then
					%>
					<tr>
						<td align="right">
							<%=Gui.GroupBoxStart(Translate.Translate("Modul"))%>
							<table cellpadding='2' cellspacing='0' border='0' width='100%'>
								<tr height=5>
									<td></td>
								</tr>
								<tr>
									<td align="right"><%=Gui.Button(Translate.Translate("Indsæt %%", "%%", Translate.JsTranslate("modul")), "showModules(" & ParagraphPageID & ");", 100)%></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
						</td>
					</tr>
					<%End If%>
					<tr height=5>
						<td></td>
					</tr>
				</table>
			</div>
			<DIV ID="Tab3" STYLE="display:none;">
				<br>
				<%=Gui.GroupBoxStart(Translate.Translate("Layout"))%>
				<table cellpadding=2 cellspacing=0>
					<%If Base.GetGs("/Globalsettings/Settings/Paragraph/HideSpaceSetting") = "True" Then%>
					<tr><td><input type="hidden" name="ParagraphBottomSpace" value="<%=ParagraphBottomSpace%>"></td></tr>
					<%Else%>
					<tr>
						<td width="170">&nbsp;<%=Translate.Translate("Mellemrum inden afsnit")%></td>
						<td>
							<select name="ParagraphBottomSpace" class=std style="width:35px;">
							<%
							Dim i as integer
							For i = 0 To 9
								If CStr(i) = CStr(ParagraphBottomSpace) Then
									Response.Write("<option value=""" & i & """ selected>" & i & "</option>")
								Else
									Response.Write("<option value=""" & i & """>" & i & "</option>")
								End If
							Next 
							%>
							</select>
						</td>
					</tr>
					<%End If%>
					<tr>
						<td colspan="2" height="5"></td>
					</tr>
					<tr>
						<td width="170">&nbsp;<%=Translate.Translate("Indeks")%></td>
						<td><%= Gui.CheckBox(ParagraphIndex, "ParagraphIndex")%></td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				<%If Base.HasAccess("Publish", "") Then%>
					<%=Gui.GroupBoxStart(Translate.Translate("Publicering"))%>
					<table cellpadding=2 cellspacing=0>
						<tr>
							<td width="170">&nbsp;<%=Translate.Translate("Gyldig fra")%></td>
							<td><%=Dates.DateSelect(ParagraphValidFrom, True, False, True, "ParagraphValidFrom")%></td>
						</tr>
						<tr>
							<td width="170">&nbsp;<%=Translate.Translate("Gyldig til")%></td>
							<td><%=Dates.DateSelect(ParagraphValidTo, true, true, true, "ParagraphValidTo")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
				<%End If%>
				<%'ToDo her er noget galt med ParagraphInheritID. asp var det lavet noget fusk%>
				<%If Base.HasAccess("Inherit", "") Then%>
					<%=Gui.GroupBoxStart(Translate.Translate("Nedarvning"))%>
						<table cellpadding="2" cellspacing="0">
						<%If Base.ChkNumber(ParagraphInheritID) > 0 Then%>
							<tr>
								<td valign="top"><%=Translate.Translate("Nedarves fra")%></td>
								<td><%= GetParagraphInherit(Base.ChkNumber(ParagraphInheritID))%></td>
							</tr>
							<tr>
								<td width="170" valign="top"><%=Translate.Translate("Status")%></td>
								<td><%=Base.IIf(Base.ChkNumber(ParagraphInheritStatus) = 1, "<img src=""../Images/infoicon.gif"" align=""absmiddle""> " & Translate.Translate("Skal tjekkes"), Translate.Translate("Alt i orden"))%></td>
							</tr>
							<tr>
								<td valign="top"><%=Translate.Translate("Sidste ændring")%></td>
								<td>
								<%
								If IsDate(ParagraphInheritUpdateDate) Then
									Response.Write(Dates.ShowDate(CDate(ParagraphInheritUpdateDate), Dates.DateFormat.Short, True))
								Else
									Response.Write("-")
								End If
								%></td>
							</tr>
						<%Else%>
							
							<tr>
								<td width="170" valign="top"><%=Translate.Translate("Nedarv fra")%></td>
								<td>
								<%If ParagraphID = "" Then%>
								<%=Gui.LinkManagerExt("", "ParagraphInheritFromParagraph", "")%>
								<%Else%>
								<%=Gui.LinkManagerExt("", "ParagraphInheritFromParagraphRedoit", "")%>
								<%End If%>
								</td>
							</tr>
						<%End If%>
						</table>
					<%=Gui.GroupBoxEnd%>
				<%End If%>
				<%'### BY RAP 8/11-05%>
				<%If Base.HasAccess("VersionControl", "") And Base.chkNumber(ParagraphID) > 0 And ApprovalType <> 0 Then
					Dim versionConn As IDbConnection = Database.CreateConnection("Dynamic.mdb")
					Dim sVCParagraph As System.Data.IDbCommand = versionConn.CreateCommand
					sVCParagraph.CommandText = "SELECT COUNT(VersionDataID) AS Versions FROM VersionData WHERE VersionDataTypeID = " & Base.ChkNumber(ParagraphID)
					Dim intVersions As integer = CInt(sVCParagraph.ExecuteScalar())
				%>
					<%=Gui.GroupBoxStart(Translate.Translate("Versionsstyring"))%>
					<br /><table cellpadding=0 cellspacing=0 width=100%>
						<tr>
							<td>&nbsp;<strong><%=Translate.Translate("Version")%></strong></td>
							<td>&nbsp;<strong><%=Translate.Translate("Sidst redigeret")%></strong></td>
							<td>&nbsp;<strong><%=Translate.Translate("Publiceret")%></strong></td>
							<td>&nbsp;<strong><%=Translate.Translate("Status")%></strong></td>
							<td>&nbsp;<strong><%=Translate.Translate("Gendan")%></strong></td>
						</tr>
						<tr>
						    <td bgcolor="#C4C4C4" colspan=5><img src="/Admin/images/nothing.gif" width=1 height=1 alt="" border="0"></td>
						</tr>
						<%
						Dim SQL As String = "SELECT TOP 50 * FROM VersionData WHERE VersionDataType = 'Paragraph' AND VersionDataTypeID = " & Base.ChkNumber(ParagraphID) & " ORDER BY VersionDataID DESC"
						sVCParagraph.CommandText = SQL
						Dim vcpDR as IDataReader = sVCParagraph.ExecuteReader()
						Dim versionCount as integer = 0
						Dim VersionDraftID as integer = 0
						Dim draftPresent as Boolean = False						
						While(vcpDR.Read())
							%>
							<tr>
								<td style="height:30px;" align="center">&nbsp;<%=intVersions - versionCount%></td>
								<td>&nbsp;<%=Dates.ShowDate(vcpDR("VersionDataEdit"), Dates.DateFormat.Short, True)%></td>
								<%
								dim strDate as string = ""
									If NOT IsDbNull(vcpDR("VersionDataPublishedTime")) Then
										strDate = Dates.ShowDate(vcpDR("VersionDataPublishedTime"), Dates.DateFormat.Short, True)
									End If
								%>
								<td>&nbsp;<%=strDate%></td>
								<%
								If versionCount = 0 Then
									VersionDraftID = vcpDR("VersionDataID")
								End If								
								If versionCount = 0 AND (vcpDR("VersionDataPublishedTime") & "") = "" Then
									draftPresent = True%>
									<td>&nbsp;<em><%=Translate.Translate("Kladde")%></em></td>
								<%ElseIf versionCount = 0 AND (vcpDR("VersionDataPublishedTime") & "") <> "" Then%>
									<td>&nbsp;<%=Translate.Translate("Aktiv")%></td>
								<%ElseIf versionCount = 1 AND draftPresent Then%>
									<td>&nbsp;<strong><%=Translate.Translate("Aktiv")%></strong></td>
								<%Else%>
									<td>&nbsp;<%=Translate.Translate("Arkiveret")%></td>
								<%End If%>
								<td align=center>&nbsp;<%If versionCount > 0 Then%><a <%If draftPresent%>href="#" onclick="if (confirm('<%=Translate.JSTranslate("Den nuværende kladde vil blive slettet!")%>\n<%=Translate.JSTranslate("Fortsæt?")%>'))document.location='Paragraph_VersionRestore.aspx?VersionDataID=<%=vcpDR("VersionDataID")%>&PageID=<%=ParagraphPageID%>&VersionDraftID=<%=VersionDraftID%>';"<%Else%> href="Paragraph_VersionRestore.aspx?VersionDataID=<%=vcpDR("VersionDataID")%>&PageID=<%=ParagraphPageID%>&VersionDraftID=<%=VersionDraftID%>"<%End If%>><img src="../images/Replace.gif" border=0 alt="<%=Translate.JsTranslate("Gendan %%", "%%", Translate.JsTranslate("version"))%>"</a><%End If%></td>
							</tr>
							<tr>
								<td bgcolor="#C4C4C4" colspan=5><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
							</tr>
							<%
							versionCount = versionCount + 1
						End While
						
						%>
						<tr>
							<td colspan="4">&nbsp;</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
				<%End If%>
				<%'### END RAP EDIT%>
			</div>
			<%if boolShowGlobal = true and Base.HasVersion("18.10.1.0") then%>
			<DIV ID="Tab4" STYLE="display:none;">
			    <br/>
				<table cellspacing="0" border="0" cellpadding="2" width="100%">
					<tr>
						<td align="right">
							<%=Gui.GroupBoxStart(Translate.Translate("Referencer"))%>
							<table cellpadding='2' cellspacing='0' border='0' width='100%'>
								<tr height=5>
									<td colspan=2></td>
								</tr>
								<%=strOutputUsage.ToString%>
							</table>
							<%=Gui.GroupBoxEnd%>
						</td>
					</tr>
					<tr height=5>
						<td></td>
					</tr>
				</table>
			</div>
			<%End If%>
		</td>
	</tr>
	<TR><TD>
		<INPUT TYPE="Hidden" NAME="ParagraphImageHAlign" VALUE="<%=ParagraphImageHAlign%>">
		<INPUT TYPE="Hidden" NAME="ParagraphImageHSpace" VALUE="<%=ParagraphImageHSpace%>">
		<INPUT TYPE="Hidden" NAME="ParagraphImageVSpace" VALUE="<%=ParagraphImageVSpace%>">
		<INPUT TYPE="Hidden" NAME="ParagraphImageVAlign" VALUE="<%=ParagraphImageVAlign%>">
		<INPUT TYPE="Hidden" NAME="ParagraphImageWindowSelect" VALUE="<%=ParagraphImageTarget%>">
		<INPUT TYPE="Hidden" NAME="ParagraphImageMouseOver" VALUE="<%=ParagraphImageMouseOver%>">
		<INPUT TYPE="Hidden" NAME="ParagraphImageCaption" VALUE="<%=ParagraphImageCaption%>">
		<INPUT TYPE="Hidden" NAME="ParagraphImageURL" VALUE="<%=ParagraphImageURL%>">
		<INPUT TYPE="Hidden" NAME="ParagraphImageResize" VALUE="<%=ParagraphImageResize%>">

		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURL_Mode" VALUE="<%=ParagraphImageURL_Mode%>">
		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURLTarget" VALUE="<%=ParagraphImageURLTarget%>">
		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURLheight" VALUE="<%=ParagraphImageURLheight%>">
		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURLleft" VALUE="<%=ParagraphImageURLleft%>">
		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURLwidth" VALUE="<%=ParagraphImageURLwidth%>">
		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURLtop" VALUE="<%=ParagraphImageURLtop%>">
		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURLscrollbars" VALUE="<%=ParagraphImageURLscrollbars%>">
		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURLtoolbar" VALUE="<%=ParagraphImageURLtoolbar%>">
		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURLmenubar" VALUE="<%=ParagraphImageURLmenubar%>">
		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURLstatus" VALUE="<%=ParagraphImageURLstatus%>">
		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURLlocation" VALUE="<%=ParagraphImageURLlocation%>">
		<INPUT TYPE="Hidden" NAME="LinkManagerSettings_ParagraphImageURLresizable" VALUE="<%=ParagraphImageURLresizable%>">

		<INPUT type="Hidden" name="LinkManagerSettings_ParagraphImageURLTarget" id="LinkManagerSettings_ParagraphImageURLTarget" VALUE="<%=ParagraphImageURL%>">
	</TD></TR>
	<tr>
		<td align="right" valign="bottom">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<% If Base.HasVersion("18.10.1.0") Then
						If ParagraphID = "" Then%>
							<td align="right"><%=Gui.Button(Translate.Translate("Gem"), "html();Send('paragraph_save.aspx?ShowAgain=True')", 0)%></td>
						<%Else%>
							<td align="right"><%=Gui.Button(Translate.Translate("Gem"), "html();this.form.submit();", 0)%></td>
						<%End If%>
						<td width="5"></td>
						<td align="right"><%=Gui.Button(Translate.Translate("Gem og luk"), "if(html()){;Send('paragraph_save.aspx" & Base.IIf(Not IsNothing(Request.QueryString.GetValues("source")), "?source=" & Request.QueryString.Item("source"), "") & "');}", 0)%></td>
					<%Else%>
						<td align="right"><%=Gui.Button(Translate.Translate("OK"), "if(html()){;Send('paragraph_save.aspx" & Base.IIf(Not IsNothing(Request.QueryString.GetValues("source")), "?source=" & Request.QueryString.Item("source"), "") & "');}", 0)%></td>
					<%End If%>
					<td width="5"></td>
					<td align="right">
					<%
					If Request("Audit") = "true" Then
						Dim strAuditData as string = "Audit&=true&AuditUserID=" & Request.Item("AuditUserID") & "&AuditDateTimeFrom=" & Request.Item("AuditDateTimeFrom") & "&AuditDateTimeTo=" & Request.Item("AuditDateTimeTo") & "&AuditType=" & Request.Item("AuditType") & "&SortOrder=" & Request.Item("SortOrder") & "&SortField=" & Request.Item("SortField")
						Response.Write(Gui.Button(Translate.Translate("Annuller"), "location='/Admin/module/Audit/Audit_list.aspx?" & strAuditData & "';", 0))
					Else
						Response.Write(Gui.Button(Translate.Translate("Annuller"), "doCancel();", 0))
					End If
					%>
					</td>
					<%=Gui.HelpButton("paragraph", "page.paragraph.edit",,5)%>
					<td width="5"></td>
				</tr>
	 			<tr>
					<td colspan="4" height="5"></td>
				</tr>			
			</table>
		</td>
	</tr>
	
</table>

<SCRIPT language="javascript">
<!--
	function doCancel() {
		<%If Not IsNothing(Request.QueryString("source")) And Base.IsModuleInstalled("Corporate", true) Then%>
			location.href = "Paragraph_Unlock.aspx?ID=<%=ParagraphPageID%>&Unlock=<%=Trim(ParagraphID)%>";
		<%ElseIf Not IsNothing(Request.QueryString.GetValues("source")) Then %>
			self.close();
		<%Elseif Request("ReturnToPageID") <> "" then%>
			location.href = "Paragraph_list.aspx?ID=<%=ReturnToPageID%>&Unlock=<%=Trim(ParagraphID)%>"
		<%Else%>
			location.href = "Paragraph_list.aspx?ID=<%=ParagraphPageID%>&Unlock=<%=Trim(ParagraphID)%>"
		<%End If%>
	}
//-->
</SCRIPT>


<%'Setting for the paragraph%>

<%=Gui.TemplatePreviewScript("paragraph", ParagraphTemplateID, "paragraph_edit")%>
<%
Response.write(Gui.SelectTab())
%>

</form>
</div>
<script>
function getInheritValue(strFieldName, InheritID){
	//alert(document.frames("InheritFrame").location);
	//document.frames("InheritFrame").location = "/Admin/Module/Inherit/Inherit_GetValue.aspx?TableName=Paragraph&FieldName=" + strFieldName + "&InheritID=" + InheritID;
	setInheritValue(strFieldName, unescape(InheritID));
	if(strFieldName == "ParagraphText"){
	    <%If Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") <> "EditorNew" Then%>
		startEditor();
		<%End If%>
	}
}
function setInheritValue(strFieldName, NewValue){
	if(strFieldName == "ParagraphImage" && NewValue.indexOf("/") > 0){
		selObj = document.forms.paragraph_edit.elements[strFieldName];
		selObj.options.length = selObj.options.length + 1;
		selObj.options[selObj.options.length-1].value = NewValue;
		selObj.options[selObj.options.length-1].text = NewValue;
		selObj.selectedIndex = selObj.options.length-1;
	}
	else{
	    if(strFieldName == "ParagraphText"){
    	    <%If Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "EditorNew" Then%>
    	    //alert(NewValue);
    	    //ParagraphText___Frame
            var TextDiv = document.getElementById(strFieldName);
	        TextDiv.value = NewValue;
	        ParagraphText___Frame.document.location.reload();
    		<%Else%>
       		document.forms.paragraph_edit.elements[strFieldName].value = NewValue;
    		<%End If%>
        } else {
       		document.forms.paragraph_edit.elements[strFieldName].value = NewValue;
        }                
	}
}
</script>
</body>
</html>
<% 
	Translate.GetEditOnlineScript() ' BBR 11/2005
%>
