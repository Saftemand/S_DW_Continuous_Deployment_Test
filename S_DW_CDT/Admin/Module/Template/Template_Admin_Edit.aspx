<%@ Page CodeBehind="Template_Admin_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_Admin_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			12-02-2002
'	Last modfied:		12-02-2002
'
'	Purpose: Lists template categories
'
'	Revision history:
'		1.0 - 12-02-2002 - Michael Lykke
'		First version
'**************************************************************************************************

Dim strSql As String = ""

Dim TemplateCatgeoryDirectory As String = ""
Dim TemplateDescription As String = ""
    Dim TemplateImageWidth As String = 0
Dim TemplateImageHeight As String = 0
Dim TemplateFile As String = ""

Dim TemplateIcon As String = ""
Dim TemplateID As Integer = 0
Dim TemplateCategoryID As Integer = 0
Dim TemplateImageColumns As Integer = 0
	Dim TemplateAutoResize As Boolean = False
	Dim TemplatePutInTable As Boolean = False

Dim TemplateDir As String = ""
Dim TemplateName As String = ""

Dim cnTemplate As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect As IDbCommand = cnTemplate.CreateCommand

TemplateCategoryID = Request.QueryString.Item("TemplateCategoryID")

If Not IsNothing(Request.QueryString.GetValues("TemplateID")) Then
	strSql = "SELECT Template.*, TemplateCategory.TemplateCatgeoryDirectory FROM TemplateCategory INNER JOIN Template ON TemplateCategory.TemplateCategoryID = Template.TemplateCategoryID WHERE TemplateID=" & Request.QueryString.Item("TemplateID")
	cmdSelect.CommandText = strSql
	Dim drTemplate as IDataReader = cmdSelect.ExecuteReader()
	drTemplate.Read()
	
	TemplateID = Request.QueryString.Item("TemplateID") 
	TemplateName = drTemplate("TemplateName").ToString
	TemplateFile = drTemplate("TemplateFile").ToString
	TemplateIcon = drTemplate("TemplateIcon").ToString
	TemplateDescription = drTemplate("TemplateDescription").ToString
        TemplateCategoryID = drTemplate("TemplateCategoryID") & ""
	TemplateCatgeoryDirectory = drTemplate("TemplateCatgeoryDirectory").ToString
	If Base.HasVersion("18.2.2.0") Then
		If Not isDbNull(drTemplate("TemplateImageColumns")) Then TemplateImageColumns = Cint(drTemplate("TemplateImageColumns"))
		If Not isDbNull(drTemplate("TemplateImageWidth")) Then TemplateImageWidth = Cint(drTemplate("TemplateImageWidth"))
		If Not isDbNull(drTemplate("TemplateImageHeight")) Then TemplateImageHeight = Cint(drTemplate("TemplateImageHeight"))
	End If
		If Not IsDBNull(drTemplate("TemplateAutoResize")) Then TemplateAutoResize = CBool(drTemplate("TemplateAutoResize"))
		TemplatePutInTable = Base.ChkBoolean(drTemplate("TemplatePutInTable"))
		
	
	'Cleanup
	drTemplate.Close()
	drTemplate.Dispose()
Else
	strSql = "SELECT TemplateCatgeoryDirectory FROM TemplateCategory WHERE TemplateCategoryID = " & TemplateCategoryID
	cmdSelect.CommandText = strSql
	Dim drTemplate as IDataReader = cmdSelect.ExecuteReader()
	If drTemplate.Read() Then
		If Not isDbNull(drTemplate("TemplateCatgeoryDirectory")) Then 
			TemplateCatgeoryDirectory = drTemplate("TemplateCatgeoryDirectory")
		End If
	End If
	TemplateImageColumns = 0
	
	'Cleanup
	drTemplate.Close()
	drTemplate.Dispose()
End If

TemplateDir = "Templates/" & TemplateCatgeoryDirectory

%>
<HTML>
<HEAD>
	<TITLE>...</TITLE>
	<LINK REL="STYLESHEET" TYPE="text/css" HREF="../../stylesheet.css">
	<SCRIPT LANGUAGE="JavaScript">
		function TemplateEdit_Send() {
			if(document.getElementById('TemplateEdit').TemplateName.value=='') {
				alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
			} else if (document.getElementById('TemplateEdit').TemplateFile.value=='') {
				alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Template fil"))%>');
			} else {
				document.getElementById('TemplateEdit').submit();
			}
		}
		
		function DWDelete(strMsg, strURL) {
			if(confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("menu"))%>\n(' + strMsg + ')')) {
				location = strURL;
			}
		}
	</SCRIPT>
</HEAD>

<BODY>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("template")), Translate.Translate("Indstillinger"), "all")%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="TabTable">
<TR>
	<TD VALIGN="TOP">
		<BR>
		<DIV ID="Tab1" STYLE="DISPLAY:">
		<TABLE WIDTH="100%" CELLPADDING="0">
		<form NAME="TemplateEdit" id="TemplateEdit" ACTION="Template_Save.aspx" METHOD="POST">
		<INPUT TYPE="HIDDEN" NAME="TemplateID" VALUE="<%=TemplateID%>">
		<INPUT TYPE="HIDDEN" NAME="TemplateCategoryID" VALUE="<%=TemplateCategoryID%>">
		<INPUT TYPE="HIDDEN" NAME="Opener" VALUE="<%=Request.QueryString.Item("Opener")%>">
		<tr>
			<td>
				<%=Gui.GroupBoxStart(Translate.Translate("Template"))%>
					<table>
						<TR>
							<TD width=170><%=Translate.Translate("Navn")%></TD>
							<TD><INPUT TYPE="TEXT" NAME="TemplateName" VALUE="<%= Server.HtmlEncode(TemplateName)%>" MAXLENGTH="100" CLASS="Std"></TD>
						</TR>
						<TR>
							<TD><%=Translate.Translate("Templatefil")%></TD>
							<TD><%=Gui.FileManager(TemplateFile, TemplateDir, "TemplateFile")%> </TD>
						</TR>
						<%If TemplateCategoryID <> 1 Then%>
						<TR>
							<TD><%=Translate.Translate("Ikon")%></TD>
							<TD><%=Gui.FileManager(TemplateIcon, "Templates/Images", "TemplateIcon")%></TD>
						</TR>
						<tr>
							<td valign="Top" width="170px"><%=Translate.Translate("Beskrivelse")%></td>
							<td><textarea class="std" name="TemplateDescription" rows="3" cols="50" ><%=TemplateDescription%></textarea></td>
						</tr>
						<tr>
							<td>
								<%=Translate.Translate("Put billede i tabel")%>
							</td>
							<td>
								<%=Gui.CheckBox(TemplatePutInTable, "TemplatePutInTable")%>
							</td>
						</tr>
						<%End If%>
					</table>
				<%=Gui.GroupBoxEnd%>
				
					<%	If TemplateCategoryID = 3 OrElse TemplateCategoryID = _newsv2CategoryId Then%>
						<%=Gui.GroupBoxStart(Translate.Translate("Tvunget billedestørrelse"))%>
						<table>
							<TR>
								<TD width=170><%=Translate.Translate("Antal kolonner")%></TD>
								<TD><%=Gui.SpacListExt(TemplateImageColumns, "TemplateImageColumns", 0, 6, 1, "")%></TD>
							</tr>
							<tr>
								<td><b><%=Translate.Translate("Eller")%></b></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Billedebredde")%></td>
								<td><INPUT TYPE="TEXT" NAME="TemplateImageWidth" VALUE="<%=TemplateImageWidth%>" MAXLENGTH="255" CLASS="Std" style="width:53px;"> px</TD>
							</TR>
							<tr>
								<td><%=Translate.Translate("Image height")%></td>
								<td><INPUT TYPE="TEXT" NAME="TemplateImageHeight" VALUE="<%=TemplateImageHeight%>" MAXLENGTH="255" CLASS="Std" style="width:53px;"> px</TD>
							</TR>
							<tr>
								<td><%=Translate.Translate("Autoskaler")%></td>
								<td><%=Gui.CheckBox(TemplateAutoResize, "TemplateAutoResize")%></TD>
							</TR>
							
						</table>
						<%=Gui.GroupBoxEnd%>
					<%	End If%>
			</td>
		</tr>
		<tr>
			<td>
				<% 
				If Base.chknumber(TemplateID) <> 0 And TemplateCategoryID = 1 Then%>
					<%=Gui.GroupBoxStart(Translate.Translate("Menu"))%>
					<TABLE WIDTH="570" cellpadding="0">
					<TR>
						<TD WIDTH="300"><strong><%=Translate.Translate("Navn")%></strong></TD>
						<TD><strong><%=Translate.Translate("Type")%></strong></TD>
						<TD WIDTH="40"><strong><%=Translate.Translate("Slet")%></strong></TD>
					</TR>
					<TR>
						<TD COLSPAN="3" BGCOLOR="#C4C4C4"><IMG SRC="../../images/Nothing.gif" WIDTH="1" HEIGHT="1"></TD>
					</TR>

					<%	
	
	strSql = "SELECT * FROM TemplateMenu INNER JOIN TemplateMenuType ON TemplateMenu.TemplateMenuType = TemplateMenuType.TemplateMenuTypeID WHERE TemplateMenuTemplateID=" & TemplateID
	cmdSelect.CommandText = strSql
	Dim drMenu as IDataReader = cmdSelect.ExecuteReader()
	
	Do While drMenu.Read()
	    Response.Write("<script type=""text/javascript"">var menu" & drMenu("TemplateMenuID") & " = '" & Base.JSEnable (drMenu("TemplateMenuName")) & "'; </script>")
		Response.Write(("<TR><TD><a href=""Template_Menu_Edit.aspx?TemplateMenuID=" & drMenu("TemplateMenuID") & "&TemplateID=" & TemplateID & "&TemplateCategoryID=" & TemplateCategoryID & "&Opener=" & Request.QueryString.Item("Opener") & """>" & Server.HtmlEncode(drMenu("TemplateMenuName")) & "</a></TD><TD>" & Translate.Translate(drMenu("TemplateMenuTypeName")) & "</TD><TD><A HREF=""#"" OnClick=""DWDelete('" & Server.HtmlEncode(Base.JSEnable(drMenu("TemplateMenuName"))) & "', 'Template_Menu_Del.aspx?TemplateMenuID=" & drMenu("TemplateMenuID") & "&TemplateCategoryID=" & TemplateCategoryID & "&TemplateID=" & TemplateID & "');""><IMG SRC=""../../Images/Delete.gif"" BORDER=""0"" alt=""" & Translate.Translate("Slet menu") & """></A></TD></TR>"))
		%>
		<TR><TD COLSPAN="3" BGCOLOR="#C4C4C4"><IMG SRC="../../images/Nothing.gif" WIDTH="1" HEIGHT="1"></TD></TR>
	<%
	Loop 
	%>
					<tr>
						<td colspan="3" align="right"><br /><%=Gui.Button(Translate.Translate("Ny menu"), "location='Template_Menu_Edit.aspx?TemplateID=" & TemplateID & "&TemplateCategoryID=" & TemplateCategoryID & "';", 0)%></td>
					</tr>
					</TABLE>
					<%=Gui.GroupBoxEnd%>
				<%End If%>
			</td>
		</tr>
		<TR>
			<TD COLSPAN="2">&nbsp;</TD>
		</TR>
		</form>
		</TABLE>
		</DIV>
	</TD>
	</TR>
	<TR>
		<TD ALIGN="RIGHT" valign=bottom>
			<TABLE>
				<TR>
					<TD><%=Gui.Button(Translate.Translate("OK"), "TemplateEdit_Send()", 0)%></TD>
					<%If Base.ChkString(Base.Request("Opener")) <> "" Then%>
						<TD><%=	Gui.Button(Translate.Translate("Luk"), "self.close();", 0)%></TD>
					<%Else%>
						<TD><%=	Gui.Button(Translate.Translate("Luk"), "location='Template_List.aspx?TemplateCategoryID=" & TemplateCategoryID & "'", 0)%></TD>
					<%End If%>
					<%=Gui.HelpButton("templates", "modules.template.general.list.item.edit")%>
				</TR>
			</TABLE>
		</TD>
	</TR>
</TABLE>
</BODY>
</HTML>
<%
cmdSelect.Dispose()
cnTemplate.Close()
cnTemplate.Dispose()

	Translate.GetEditOnlineScript()
%>