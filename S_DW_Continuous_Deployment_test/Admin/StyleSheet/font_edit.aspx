<%@ Page CodeBehind="font_edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.font_edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			01-03-2002
'	Last modfied:		01-03-2002
'
'	Purpose: Edits fontfamily
'
'	Revision history:
'		1.0 - 01-03-2002 - Michael Lykke
'		First version
'**************************************************************************************************
%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<TITLE><%=Translate.JSTranslate("Fontfamily")%></TITLE>
	<LINK REL="STYLESHEET" TYPE="text/css" HREF="../stylesheet.css">
	<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
	<script language = "javascript">
		
		function ValidateThisFrom()
		{
			var form = document.forms["FontFamilyForm"];
			var controlToValidate = form.elements["FontFamilyName"];
			ValidateForm(form, controlToValidate,
				"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
		}
		
	</script>
</head>
<body>
<%= Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("Fontfamily")), Translate.Translate("Indstillinger"), "all", true) %>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable" style="width:512px;">
<FORM NAME="FontFamilyForm" ACTION="font_save.aspx" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="FontFamilyID" VALUE="<%=FontFamilyID%>">
	<TR>
		<TD VALIGN="TOP">
			<BR>
			<DIV ID="Tab1" STYLE="display:;">
			<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%">
				<TR>
					<TD WIDTH="170"><%=Translate.Translate("Navn")%></TD>
					<TD><INPUT TYPE="TEXT" NAME="FontFamilyName" VALUE="<%=FontFamilyName%>" MAXLENGTH="255" CLASS="std"></TD>
				</TR>
			</TABLE>	
			</DIV>
		</TD>
	</TR>
	<TR>
		<TD ALIGN="RIGHT" VALIGN="BOTTOM">
		  	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
				<TR>
					<td><%=Gui.Button(Translate.Translate("OK"), "ValidateThisFrom();", 0)%></td>
					<TD WIDTH="5"></TD>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "location='font_list.aspx'", 0)%></td>
					<TD WIDTH="10"></TD>
				</TR>
				<TR>
					<TD COLSPAN="4" HEIGHT="5"></TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
</FORM>
</TABLE>
</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>