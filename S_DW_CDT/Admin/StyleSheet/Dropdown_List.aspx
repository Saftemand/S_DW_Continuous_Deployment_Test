<%@ Page CodeBehind="Dropdown_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Dropdown_List" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=Translate.JsTranslate("Dropdown")%></title>
	<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
</head>
<script>
function Dropdown_delete(id, strName){
	if (confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JsTranslate("dropdown"))%>\n(' + strName + ')')){
		this.location= "Dropdown_delete.aspx?ID=" + id
	}
}
			function DeleteLegend(LegendID, Title) {
				if (confirm('<%=Translate.JsTranslate("Slet %%","%%",Translate.JsTranslate("brødkrummesti"))%>\n(' + Title + ')')==true) {
					location.href = "PageFeature_Legend_Del.aspx?ID=" + LegendID;
				}
}

function init() {
    // Checking if the page is called from the Management Center
    // (this probably not the best but the simplest way to setup the page layout).
    if (window.parent && typeof (window.parent.SettingsPage) != 'undefined') {
        hideCloseButton('spanClose');
    }
}

function hideCloseButton(placeholderID) {
    var span = document.getElementById(placeholderID);

    if (span) {
        span.style.display = 'none';

    }
}
</script>

<body onload="init();">

<%= Gui.MakeHeaders(Translate.Translate("Dropdowns"), Translate.Translate("Dropdown"), "all", true) %>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable" style="width:512px;">
	<TR>
		<TD VALIGN="TOP">
			<BR>
			<DIV ID="Tab1" STYLE="display:;">
			<table border="0" width="100%" cellpadding="0">
				<TR>
					<td width="425"><strong>&nbsp;<%=Translate.Translate("Navn")%></strong></td>
					<td width="35"><strong><%=Translate.Translate("Slet")%></strong></td>
				</tr>
				<%= GetDropDownList() %>
			    <TR>
			      <td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
			    </TR>
				<TR>
				  <TD COLSPAN="4">&nbsp;</TD>
				</TR>	
			</TABLE>	
			</DIV>
		</TD>
	</TR>
	<TR>
		<TD ALIGN="RIGHT" VALIGN="BOTTOM">
		  	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
				<TR>
					<td>
					    <%=Gui.Button(Translate.Translate("Ny dropdown"), "location='Dropdown_edit.aspx'", 100)%>
					    <span id="spanClose" style="display: inline">
				            &nbsp;<%=Gui.Button(Translate.Translate("Luk"), "location='about:blank'", 0)%>
				        </span>
					</td>
					
					<TD WIDTH="5"></TD>
				</TR>
				<TR>
					<TD HEIGHT="5"></TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
</TABLE>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>