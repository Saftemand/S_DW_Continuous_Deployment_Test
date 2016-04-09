<%@ Page CodeBehind="font_list.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.font_list" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			03-12-2001
'	Last modfied:		01-03-2002
'
'	Purpose: Edits stylesheet classes
'
'	Revision history:
'		1.0 - 03-12-2001 - Michael Lykke
'		First version
'**************************************************************************************************
%>

<HTML>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE><%=Translate.JsTranslate("Fontfamily")%></TITLE>
	<LINK REL="STYLESHEET" TYPE="text/css" HREF="../stylesheet.css">
	<SCRIPT Language="JavaScript">
	    function DWDelete(dwmsg, dwurl) {
	        if (confirm('<%=Translate.JSTranslate("Slet %%?","%%",Translate.JSTranslate("font family"))%>\n(' + dwmsg + ')')) {
	            location = dwurl;
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
        </SCRIPT>
</HEAD>
<body onload="init();">
<%= Gui.MakeHeaders(Translate.Translate("Skrifttyper"), Translate.Translate("Fontfamily"), "all", true)%>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable" style="width:512px;">
	<TR>
		<TD VALIGN="TOP">
			<BR>
			<DIV ID="Tab1" STYLE="display:;">
			<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%">
				<TR>
					<td width="425"><strong>&nbsp;<%=Translate.Translate("Navn")%></strong></td>
					<td width="35"><strong><%=Translate.Translate("Slet")%></strong></td>
				</TR>
				<%= GetFontList()%>
			    <tr>
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
					<td align="right">
				        <%=Gui.Button(Translate.Translate("Ny fontfamilie"), "location='font_edit.aspx'", 0)%>
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
</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>