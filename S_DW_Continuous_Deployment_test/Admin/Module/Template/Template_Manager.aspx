<%@ Page CodeBehind="Template_Manager.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_Manager" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
'**************************************************************************************************
'	Current version:	1.1
'	Created:			12-02-2002
'	Last modfied:		08-06-2004
'
'	Purpose: Lists template categories
'
'	Revision history:
'		1.0 - 12-02-2002 - Michael Lykke
'		First version
'		1.1 - 08-06-2004 - David Frandsen
'		Converted to .NET
'***************************************************************************************************

Dim ParagraphTemplateID As String
Dim ParagraphTemplateIcon As String
Dim FileHome As String = "/Files/"
Dim Home As String = "/Admin/"

Dim Cursor As Short

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title><%=Translate.JSTranslate("Vælg template")%></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<script language="javascript">
		function doOk() {
			window.opener.document.all('<%=Request.QueryString.Item("returnto")%>').value = document.all('SelectedTemplateID').value;
			self.close();
		}
	</script>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0", bottommargin="0">

<%
Response.Write(("<STYLE>"))
Response.Write((".TemplatePreview{"))
Response.Write(("	WIDTH:600px;"))
Response.Write(("	HEIGHT:300px;"))
Response.Write(("	POSITION:Absolute;"))
Response.Write(("	BACKGROUND-COLOR:#FFFFFF;"))
Response.Write(("}"))
Response.Write(("</STYLE>"))
Response.Write(("<DIV ID=""TemplatePreview"" CLASS=""TemplatePreview"">"))
Response.Write(("<INPUT TYPE=""HIDDEN"" NAME=""ParagraphTemplateID"" VALUE=""" & ParagraphTemplateID & """>"))
Response.Write(("<INPUT TYPE=""HIDDEN"" NAME=""SelectedTemplateID"" VALUE=""" & ParagraphTemplateID & """>"))
Response.Write(("<INPUT TYPE=""HIDDEN"" NAME=""TempParagraphTemplateIcon"" VALUE=""" & ParagraphTemplateIcon & """>"))
Response.Write(("<TABLE CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" HEIGHT=""300"" border=0>"))
Response.Write(("	<TR BGCOLOR=""#ECE9D8"" HEIGHT=23>"))
Response.Write(("		<TD><STRONG>" & Translate.Translate("Templates") & "</STRONG></TD>"))
Response.Write(("		<TD ALIGN=RIGHT><!--<img src=""" & Home & "images/Close_off.gif"" title=" & Translate.Translate("Luk") & " onmouseover=""this.src='" & Home & "images/Close_on.gif'"" onmouseout=""this.src='" & Home & "images/Close_off.gif'"" onmousedown=""this.src='" & Home & "/images/Close_press.gif'"" onmouseup=""this.src='" & Home & "/images/Close_on.gif'"" onClick=""self.close();"">--></TD>"))
Response.Write(("	</TR>"))
Response.Write(("	<TR BGCOLOR=""#ACA899"" HEIGHT=1>"))
Response.Write(("		<TD COLSPAN=2></TD>"))
Response.Write(("	</TR>"))
Response.Write(("	<TR>"))
Response.Write(("		<TD COLSPAN=2 ALIGN=LEFT VALIGN=TOP>"))
Response.Write(("			<TABLE BORDER=""0"" CELLSPACING=""0"" CELLPADDING=""0"" WIDTH=""100%"" HEIGHT=""340"">"))
Response.Write(("				<TR HEIGHT=5>"))
Response.Write(("					<TD COLSPAN=""3""></TD>"))
Response.Write(("				</TR>"))
Response.Write(("				<TR>"))
Response.Write(("					<TD VALIGN=""TOP"" align=center width=150><Div Style=""overflow:auto;HEIGHT:300px"">"))
Response.Write(("						<TABLE>"))

Dim cnTemplate As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect As IDbCommand = cnTemplate.CreateCommand
Dim TemplateSql as String = "SELECT Template.TemplateID, Template.TemplateName, Template.TemplateIcon, Template.TemplateIsDefault FROM Template LEFT JOIN News ON Template.TemplateID = News.NewsTemplateID WHERE (((Template.TemplateCategoryID)=4)) GROUP BY Template.TemplateID, Template.TemplateName, Template.TemplateIcon, Template.TemplateIsDefault ORDER BY Count(News.NewsID) DESC"

cmdSelect.CommandText = TemplateSql
Dim drTemplate as IDataReader = cmdSelect.ExecuteReader()

Cursor = 0
Do While drTemplate.Read()
	Cursor = Cursor + 1
	If Cursor = 1 Then
		Response.Write(("<TR>"))
	End If
	Response.Write("<TD align=center><A HREF=""#"" OnClick=""document.all('SelectedTemplateID').value='" & drTemplate("TemplateID") & "';document.all.LayoutSettings_Preview.src='Template_Preview.aspx?TemplateID=" & drTemplate("TemplateID") & "';document.all.TempParagraphTemplateIcon.value='" & drTemplate("TemplateIcon") & "';""><IMG SRC=""" & FileHome & "Templates/images/" & drTemplate("TemplateIcon") & """ BORDER=""0""></A></TD>")
	If Cursor = 1 Then
		Response.Write(("<TD>&nbsp;</TD>"))
	End If
	If Cursor = 2 Then
		Response.Write(("</TR>"))
		Cursor = 0
	End If
	
Loop 

Response.Write(("						</TABLE>"))
Response.Write(("					</DIV>"))
Response.Write(("					</TD>"))
Response.Write(("					<TD VALIGN=""TOP""><IFRAME ID=""LayoutSettings_Preview"" SRC="""" WIDTH=""100%"" HEIGHT=""300"" FRAMEBORDER=""0"" LEFTMARGIN=0 TOPMARGIN=0 MARGINHEIGHT=0 MARGINWIDTH=0></IFRAME>"))
Response.Write(("					<TABLE BORDER=""0"" ALIGN=""right""><TR><TD>" & Gui.Button(Translate.Translate("OK"), "doOk();", 0) & "</TD><TD>" & Gui.Button(Translate.Translate("Annuller"), "self.close();", 0) & "</TD></TR></TR></TABLE>"))
Response.Write(("					</TD>"))
Response.Write(("				</TR>"))
Response.Write(("				<TR>"))
Response.Write(("					<TD COLSPAN=""2"" HEIGHT=""5""></TD>"))
Response.Write(("				</TR>"))
Response.Write(("			</TABLE>"))
Response.Write(("		</TD>"))
Response.Write(("	</TR>"))
Response.Write(("</TABLE>"))
Response.Write(("</DIV>"))

drTemplate.Dispose()
cnTemplate.Dispose()
cmdSelect.Dispose()
%>
</body>
</html>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>