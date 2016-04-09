<%@ Page CodeBehind="stylesheet_create.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.stylesheet_create" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			19-12-2001
'	Last modfied:		07-01-2002
'
'	Purpose: Creates stylesheet
'
'	Revision history:
'		1.0 - 07-01-2002 - Michael Lykke
'		First version
'**************************************************************************************************
%>
<HTML>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE><%=Translate.JsTranslate("Stylesheet")%></TITLE>
	<LINK REL="STYLESHEET" TYPE="text/css" HREF="../stylesheet.css">
	<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
	<script language = "javascript">
		function ValidateThisForm()
		{
			var form = document.forms["StylesheetCreateForm"];
			var controlToValidate = form.elements["StylesheetStylesheetNodename"];
			ValidateForm(form, controlToValidate,
				"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
		}
	</script>
</HEAD>

<BODY onload="document.getElementById('StylesheetCreateForm').StylesheetStylesheetNodename.select();">
<%= Gui.MakeHeaders(Translate.Translate("Nyt stylesheet"), Translate.Translate("Indstillinger"), "all")%>
<DIV ID="Tab1" STYLE="DISPLAY:">
<form NAME="StylesheetCreateForm" id="StylesheetCreateForm" METHOD="POST" ACTION="stylesheet_create_save.aspx">
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable">
<tr valign="top">
	<td height=15>&nbsp;</td>
</tr>
<tr valign="top">
    <td>
        <table border="0" width="100%">
            <TR valign="top">
	            <TD VALIGN="TOP" WIDTH="170">&nbsp;<%=Translate.Translate("Navn")%></TD>
	            <TD VALIGN="TOP"><INPUT TYPE="TEXT" NAME="StylesheetStylesheetNodename" MAXLENGTH="50" CLASS="std" value="<%=Translate.Translate("Nyt stylesheet")%>"></TD>
            </TR>
            <TR>
	            <TD VALIGN="TOP" WIDTH="170">&nbsp;<%=Translate.Translate("Kopier fra")%></TD>
	            <TD VALIGN="TOP"><%= Gui.StylesheetList(Request.QueryString("StylesheetID"), "StylesheetStylesheetNodenameParent")%></TD>
            </TR>
        </table>
    </td>
</tr>
<%  If Not CalledFromManagementCenter Then%>
<TR>
    <TD COLSPAN="2" VALIGN="bottom">
        <TABLE ALIGN="RIGHT" BORDER="0">
            <TR>
	            <TD><%= Gui.Button(Translate.Translate("OK"), "ValidateThisForm();", 0)%></TD>
	            <TD><%= Gui.Button(Translate.Translate("Annuller"), "location='about:blank'", 0)%></TD>
            </TR>
        </TABLE>	
    </TD>
</TR>
<% End If%>
</TABLE>
<input type="hidden" id="Caller" name="Caller" value='<%=Request.QueryString("Caller")%>' />
</form>
</DIV>
</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
