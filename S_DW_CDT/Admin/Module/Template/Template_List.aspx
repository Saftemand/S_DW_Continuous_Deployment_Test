<%@ Page CodeBehind="Template_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			12-02-2002
'	Last modfied:		03-06-2004
'
'	Purpose: Lists template categories
'
'	Revision history:
'		1.0 - 12-02-2002 - Michael Lykke
'		First version
'		1.1 - 03-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************

%>
<HTML>
<HEAD>
	<TITLE></TITLE>
	<LINK REL="STYLESHEET" TYPE="text/css" HREF="../../stylesheet.css">
	
	<script language="JavaScript">
	function DeleteTemplate(templateCatID, templateID, templateName){
		if (confirm("<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("template"))%>\n(" + templateName +")")){
			location = "Template_Del.aspx?TemplateCategoryID=" + templateCatID + "&TemplateID=" + templateID;
		}
	}
	
	function setDefaultClick(url) {
	    if(top.left && top.left.hidePageFrame) {
	        top.left.hidePageFrame();
	        top.right.location.href = url;
	    }
	}
</script>	


<style type="text/css">
    .default-disabled
    {
    	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=30);
    	progid: DXImageTransform.Microsoft.BasicImage(grayscale=1);
    	-moz-opacity: 0.4;
    	cursor: default;
    }
</style>

</HEAD>

<BODY>
<%=Gui.MakeHeaders(Translate.Translate("%m% kategori - %c%", "%m%", Translate.Translate("Templates",9), "%c%", Translate.Translate(TemplateCategoryName)), Translate.Translate("Templates"), "all")%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="TabTable">
<TR>
	<TD VALIGN="TOP">
		<BR>
		<DIV ID="Tab1" STYLE="DISPLAY:">
		<TABLE WIDTH="598" CELLPADDING="0">
		<tr>
		    <td colspan="7" style="padding-right: 5px">
		        <dw:Infobar ID="barNoDefault" Type="Information" Message="Click here to set the default template." runat="server" />
		    </td>
		</tr>
		<TR>
			<TD WIDTH="260"><strong><%=Translate.Translate("Template")%></strong></TD>
			<TD WIDTH="300"><strong><%=Translate.Translate("Templatefil")%></strong></TD>
			<TD><strong><%=Translate.Translate("Sorter")%></strong></TD>
			<TD><strong><%=Translate.Translate("Aktiv")%></strong></TD>
			<TD><strong><%=Translate.Translate("Default")%></strong></TD>
			<TD><strong><%=Translate.Translate("Kopier")%></strong></TD>
			<TD><strong><%=Translate.Translate("Slet")%></strong></TD>
		</TR>
		<%=TemplateList%>
		<TR>
			<TD COLSPAN="7" BGCOLOR="#C4C4C4"><IMG SRC="../../images/Nothing.gif" WIDTH="1" HEIGHT="1"></TD>
		</TR>
		<TR>
			<TD COLSPAN="7">&nbsp;</TD>
		</TR>
		</TABLE>
		</DIV>
	</TD>
	</TR>
	<TR>
		<TD ALIGN="RIGHT" valign=bottom>
			<TABLE>
				<TR>
					<%If Base.HasAccess("TemplateCreate", "") Then%>
						<TD><%=Gui.Button(Translate.Translate("Ny template"), "location='Template_Admin_Edit.aspx?TemplateCategoryID=" & Request.QueryString.Item("TemplateCategoryID") & "'", 85)%></TD>
					<%End If%>
					<TD><%=Gui.Button(Translate.Translate("Luk"), "location='Template_Category_List.aspx'", 0)%></TD>
					<%=Gui.HelpButton("templates", "modules.template.general.list.item")%>
				</TR>
			</TABLE>
		</TD>
	</TR>
</TABLE>
</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
