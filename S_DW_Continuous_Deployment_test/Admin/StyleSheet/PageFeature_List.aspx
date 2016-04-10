<%@ Page CodeBehind="PageFeature_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.PageFeature_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			07-10-2002
'	Last modfied:		07-10-2002
'
'	Purpose: Page features lists
'
'	Revision history:
'		1.0 - 07-10-2002 - Rasmus Foged
'		First version
'**************************************************************************************************
%>

<HTML>
	<HEAD>
		<TITLE><%=Translate.JsTranslate("Side egenskaber")%></TITLE>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
		<SCRIPT LANGUAGE="javascript">
		<!--
			function DeleteLegend(LegendID, Title) {
				if (confirm('<%=Translate.JsTranslate("Slet %%?","%%",Translate.JsTranslate("Brødkrummesti"))%>\n(' + Title + ')')==true) {
					location.href = "PageFeature_Legend_Del.aspx?ID=" + LegendID;
				}
			}

			function DeletePrintthis(PrintthisID, Title) {
				if (confirm('<%=Translate.JsTranslate("Slet %%?","%%",Translate.JsTranslate("Printvenlig side"))%>\n(' + Title + ')')==true) {
					location.href = "PageFeature_Printthis_Del.aspx?ID=" + PrintthisID;
				}
			}

			function DeleteFavorites(FavoritesID, Title) {
				if (confirm('<%=Translate.JsTranslate("Slet %%?","%%",Translate.JsTranslate("Mine favoritter"))%>\n(' + Title + ')')==true) {
					location.href = "PageFeature_Favorites_Del.aspx?ID=" + FavoritesID;
				}
            }

            function init() {
                // Checking if the page is called from the Management Center
                // (this probably not the best but the simplest way to setup the page layout).
                if (window.parent && typeof (window.parent.SettingsPage) != 'undefined') {
                    hideCloseButton('spanCloseBreadcrumbTrail');
                    hideCloseButton('spanClosePrintFriendly');
                    hideCloseButton('spanCloseFavorites');
                }
            }

            function hideCloseButton(placeholderID) {
                var span = document.getElementById(placeholderID);

                if (span) {
                    span.style.display = 'none';
                    
                }
            }

		//-->
		</SCRIPT>
	</HEAD>
	<BODY onload="init();">
	<%
	If Base.HasAccess("Personalize", "") Then
	        Response.Write(Gui.MakeHeaders(Translate.Translate("Side egenskaber"), Translate.Translate("Brødkrummesti") & ", " & Translate.Translate("Printvenlig side") & ", " & Translate.Translate("Mine favoritter"), "all", True))
	Else
	        Response.Write(Gui.MakeHeaders("", Translate.Translate("Brødkrummesti") & ", " & Translate.Translate("Printvenlig side"), "all", True))
	End If
	%>
		<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable" style="width:512px;">
			<TR>
				<TD VALIGN="TOP">
					<BR>
					<DIV ID="Tab1" STYLE="display:;">
						<TABLE width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
							<TR valign="top"><TD>
								<TABLE border="0" width="100%" cellpadding="0">
									<TR>
										<td width="425"><strong>&nbsp;<%=Translate.Translate("Navn")%></strong></td>
										<td width="35"><strong><%=Translate.Translate("Slet")%></strong></td>
									</TR>
									<%= getLengend() %>
									<TR>
									<td colspan="3" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
									</TR>
									<TR>
									<TD COLSPAN="3">&nbsp;</TD>
									</TR>	
								</TABLE>
							</TD></TR>
							<TR valign="bottom"><TD align="right">
								<BR>
								<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
									<TR>
										<TD>
											<%=Gui.Button(Translate.JsTranslate("Ny brødkrummesti"), "location='PageFeature_Legend_Edit.aspx'", 0)%>
											<span id="spanCloseBreadcrumbTrail" style="display: inline">
											    &nbsp;<%=Gui.Button(Translate.Translate("Luk"), "location='about:blank'", 0)%>
											</span>
										</TD>
										<td>&nbsp;</td>
									</TR>
									<TR>
										<TD HEIGHT="5"></TD>
									</TR>
								</TABLE>
							</TD></TR>
						</TABLE>
					</DIV>
					<DIV ID="Tab2" STYLE="display:none;">
						<TABLE width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
							<TR valign="top"><TD>
								<TABLE border="0" width="100%" cellpadding="0" >
									<TR>
										<td width="425"><strong>&nbsp;<%=Translate.Translate("Navn")%></strong></td>
										<td width="35"><strong><%=Translate.Translate("Slet")%></strong></td>
									</TR>
									<%= GetPrintThis()%>
									<TR>
									<td colspan="3" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
									</TR>
									<TR>
									<TD COLSPAN="3">&nbsp;</TD>
									</TR>	
								</TABLE>
							</TD></TR>
							<TR valign="bottom"><TD align="right">
								<BR>
								<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
									<TR>
										<TD>
											<%=Gui.Button(Translate.JsTranslate("Ny printvenlig side"), "location='PageFeature_Printthis_Edit.aspx'", 0)%>
											<span id="spanClosePrintFriendly" style="display: inline">
											    &nbsp;<%=Gui.Button(Translate.Translate("Luk"), "location='about:blank'", 0)%>
											</span>
										</TD>
										<td>&nbsp;</td>
									<TR>
										<TD HEIGHT="5"></TD>
									</TR>
								</TABLE>
							</TD></TR>
						</TABLE>
					</DIV>

					<% If Base.HasAccess("Personalize", "") Then %>
						<DIV ID="Tab3" STYLE="display:none;">
						<TABLE width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
							<TR valign="top"><TD>
								<TABLE border="0" width="100%" cellpadding="0">
									<TR>
										<td width="425"><strong>&nbsp;<%=Translate.Translate("Navn")%></strong></td>
										<td width="35"><strong><%=Translate.Translate("Slet")%></strong></td>
									</TR>
										<%=	GetFavorites() %>
									<TR>
										<td colspan="3" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
									</TR>
									<TR>
										<TD COLSPAN="3">&nbsp;</TD>
									</TR>	
								</TABLE>
							</TD></TR>
							<TR valign="bottom"><TD align="right">
								<BR>
								<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
									<TR>
										<TD>
											<%=Gui.Button(Translate.JsTranslate("Ny Mine favoritter"), "location='PageFeature_Favorites_Edit.aspx'", 0)%>
											<span id="spanCloseFavorites" style="display: inline">
											    &nbsp;<%=Gui.Button(Translate.Translate("Luk"), "location='about:blank'", 0)%>
											</span>
										</TD>
										<td>&nbsp;</td>
									</TR>
									<TR>
										<TD HEIGHT="5"></TD>
									</TR>
								</TABLE>
							</TD></TR>
						</TABLE>
						</DIV>
					<%End If%>
					
				</TD>
			</TR>

		</TABLE>
	</BODY>
</HTML>
<%
Response.write(Gui.SelectTab())

Translate.GetEditOnlineScript()
%>