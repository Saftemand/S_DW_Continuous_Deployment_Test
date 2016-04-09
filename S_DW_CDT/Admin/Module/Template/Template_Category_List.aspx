<%@ Page CodeBehind="Template_Category_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_Category_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%

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
'**************************************************************************************************
    Dim strSql As String
    If Base.GetGs("/Globalsettings/Settings/Designs/UseOnlyDesignsAndLayouts") = "True" Then
        strSql = "SELECT * FROM TemplateCategory WHERE [TemplateCategoryID] NOT IN (1, 3) ORDER BY [TemplateCategorySort] ASC"
    Else
        strSql = "SELECT * FROM TemplateCategory ORDER BY [TemplateCategorySort] ASC"
    End If

    

Dim cnTemplateCategory As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect As IDbCommand = cnTemplateCategory.CreateCommand
cmdSelect.CommandText = strSql
Dim drTemplateCategory as IDataReader = cmdSelect.ExecuteReader()

%>
<HTML>
<HEAD>
	<TITLE></TITLE>
	<LINK REL="STYLESHEET" TYPE="text/css" HREF="../../stylesheet.css">
</HEAD>

<BODY>
<%=Gui.MakeHeaders(Translate.Translate("Templates"), Translate.Translate("Kategorier"), "all")%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="TabTable">
<TR>
	<TD VALIGN="TOP">
		<BR>
		<DIV ID="Tab1" STYLE="DISPLAY:">
		<TABLE WIDTH="598" CELLPADDING="0">
		<TR>
			<TD><B><%=Translate.Translate("Kategori")%></B></TD>
		</TR>
		<%
Do While drTemplateCategory.Read()
	Response.Write(("<TR><TD COLSPAN=""2"" BGCOLOR=""#C4C4C4""><IMG SRC=""../../images/Nothing.gif"" WIDTH=""1"" HEIGHT=""1""></TD></TR>"))
	Response.Write(("<TR>"))
	Response.Write(("<TD height=17>" & IIf(Base.HasAccess("TemplateCategories", drTemplateCategory("TemplateCategoryID")), "<A HREF=""Template_List.aspx?TemplateCategoryID=" & drTemplateCategory("TemplateCategoryID") & """>", "") & Translate.Translate(drTemplateCategory("TemplateCategoryName")) & IIf(Base.HasAccess("TemplateCategories", drTemplateCategory("TemplateCategoryID")), "</A>", "") & "</TD>"))
	Response.Write(("</TR>"))	
Loop 

'Cleanup
drTemplateCategory.Close()
drTemplateCategory.Dispose()
%>
		<TR>
			<TD COLSPAN="2" BGCOLOR="#C4C4C4"><IMG SRC="../../images/Nothing.gif" WIDTH="1" HEIGHT="1"></TD>
		</TR>
		<TR>
			<TD COLSPAN="2">&nbsp;</TD>
		</TR>
		</TABLE>
		</DIV>
	</TD>
	</TR>
	<TR>
		<TD ALIGN="RIGHT" valign=bottom>
			<TABLE>
				<TR>
					<TD><%= Gui.Button(Translate.Translate("Luk"), "location='/Admin/Content/Management/Start.aspx'", 0)%></TD>
					<%=Gui.HelpButton("templates", "modules.template.general")%>
				</TR>
			</TABLE>
		</TD>
	</TR>
</TABLE>
</BODY>
</HTML>
<%
cmdSelect.Dispose()
cnTemplateCategory.Dispose()

Translate.GetEditOnlineScript()
%>
