<%@ Page CodeBehind="PageFeature_Legend_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.PageFeature_Legend_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>

<HTML>
	<HEAD>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<TITLE><%=Translate.JsTranslate("Brødkrummesti")%></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
		<script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
		<SCRIPT LANGUAGE="javascript">
		<!--
			function SaveLegend() {
				var ret = false;
				
				ret = (IsControlValid(document.getElementById("LegendLayoutName"), 
						"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>") &&
					IsButtonTextControlValid("LegendLayoutSeperator", 250,
						"<%=Translate.JSTranslate("Max_%%_tegn_i:_", "%%", "250") & Translate.Translate("Mellemgrafik")%>"));
				
				if(ret)
					document.getElementById("LegendForm").submit();
			}
			
		//-->
		</SCRIPT>
	</HEAD>
		<BODY>
		<%= Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("Brødkrummesti")), Translate.Translate("Indstillinger"), "all", True) %>
		<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable" style="width:512px;">
			<FORM method="post" id="LegendForm" name="LegendForm" action="PageFeature_Legend_Save.aspx<%=Base.IIf(LegendLayoutID <> "", "?id=" & LegendLayoutID, "")%>">
			<input type=hidden name="Opener" value="<%=Request.QueryString.Item("Opener")%>">
			<TR>
				<TD VALIGN="TOP">
					<BR>
					<DIV ID="Tab1" STYLE="display:;">
						<TABLE border="0" width="100%" cellpadding="0" cellspacing="0">
							<TR>
								<TD>
									<BR>
									<%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
										<TABLE>
											<TR>
												<TD width="170"><%=Translate.Translate("Navn")%></TD>
												<TD><INPUT type="text" id="LegendLayoutName" name="LegendLayoutName" value="<%=LegendLayoutName%>" maxlength="250" class="std"></td>
											</TR>
										</TABLE>
									<%=Gui.GroupBoxEnd%>
									<%=Gui.GroupBoxStart(Translate.Translate("Layout"))%>
										<TABLE>
											<%If Base.HasAccess("Area", "") Then%>
											<TR>
												<TD valign="top" width="170"><%=Translate.Translate("Vis")%></TD>
												<TD><%=  Gui.Checkbox(LegendLayoutIncludeArea, "LegendLayoutIncludeArea")%><label for="LegendLayoutIncludeArea"><%=Translate.Translate("Sproglag")%></label></td>
											</TR>
											<%End If%>
											<TR>
												<TD valign="top" width="170"></TD>
												<TD><%= Gui.Checkbox(LegendLayoutIncludeFrontpage, "LegendLayoutIncludeFrontpage")%><label for="LegendLayoutIncludeFrontpage"><%=Translate.Translate("Forside")%></label></td>
											</TR>
											<tr>
												<td valign="top" width="170"></td>
												<td><%= Gui.Checkbox(LegendLayoutIncludeAreaFrontpage, "LegendLayoutIncludeAreaFrontpage")%><label for="LegendLayoutIncludeAreaFrontpage"><%=Translate.Translate("Første side i sproglag")%></label></td>
											</tr>
										</TABLE>
									<%=Gui.GroupBoxEnd%>
									<%=Gui.GroupBoxStart(Translate.Translate("Mellemrum"))%>
										<TABLE>
											<TR>
												<TD valign="top" width="170"><%=Translate.Translate("Mellemgrafik")%></TD>
												<TD><%= Gui.ButtonText("LegendLayoutSeperator", LegendLayoutSeperator, LegendLayoutSeperatorImage, LegendLayoutSeperatorText)%></td>
											</TR>
											<TR>
												<TD valign="top" width="170"><%=Translate.Translate("Højde")%></TD>
												<TD><%= Gui.FontSizeList(LegendLayoutHeight, "LegendLayoutHeight")%></td>
											</TR>
										</TABLE>
									<%=Gui.GroupBoxEnd%>
									<%=Gui.GroupBoxStart(Translate.Translate("Font"))%>
									<TABLE>
										<tr>
											<TD WIDTH="170"><%=Translate.Translate("Størrelse")%></TD>
											<td><%= Gui.FontSizeList(LegendLayoutFontSize, "LegendLayoutFontSize")%></td>
										</tr>
										<tr>
											<TD><%=Translate.Translate("Font")%></TD>
											<td><%= Gui.FontFamilyList(LegendLayoutFont, "LegendLayoutFont")%>&nbsp;</td>
										</tr>
									</table>
									<%=Gui.GroupBoxEnd%>
									<%=Gui.GroupBoxStart(Translate.Translate("Link"))%>
									<table border="0" cellpadding="0">
										<tr>
											<td><%=Translate.Translate("Fed")%></td>
											<td><%= StyleSheet.StyleCheckbox(LegendLayoutFontWeight, "Bold", "LegendLayoutFontWeight")%></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Kursiv")%></td>
											<td><%= StyleSheet.StyleCheckbox(LegendLayoutFontStyle, "italic", "LegendLayoutFontStyle")%></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Understregning")%></td>
											<td><%= StyleSheet.StyleCheckbox(LegendLayoutTextdecoration, "true", "LegendLayoutTextdecoration")%></td>
										</tr>
										<tr>
											<TD><%=Translate.Translate("Farve")%></TD>
											<td><%= Gui.ColorSelect(LegendLayoutFontColor, "LegendLayoutFontColor")%>&nbsp;</td>
										</tr>
										<tr>
											<td width="170"><%=Translate.Translate("Baggrund")%></td>
											<td><%= Gui.ColorSelect(LegendLayoutBGColor, "LegendLayoutBGColor", true)%></td>
										</tr>
									</table>
									<%=Gui.GroupBoxEnd%>
									<%=Gui.GroupBoxStart(Translate.Translate("Mouseover"))%>
									<table border=0 cellpadding=0>
										<tr>
											<td width=170><%=Translate.Translate("Fed")%></td>
											<td><%= StyleSheet.StyleCheckbox(LegendLayoutFontWeightActive, "Bold", "LegendLayoutFontWeightActive")%></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Kursiv")%></td>
											<td><%= StyleSheet.StyleCheckbox(LegendLayoutFontStyleActive, "italic", "LegendLayoutFontStyleActive")%></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Understregning")%></td>
											<td><%=StyleSheet.StyleCheckbox(LegendLayoutTextdecorationActive, "true", "LegendLayoutTextdecorationActive")%></td>
										</tr>
										<tr>
											<TD><%=Translate.Translate("Farve")%></TD>
											<td><%= Gui.ColorSelect(LegendLayoutFontColorActive, "LegendLayoutFontColorActive", true)%>&nbsp;</td>
										</tr>
										<tr>
											<td width="170"><%=Translate.Translate("Baggrund")%></td>
											<td><%= Gui.ColorSelect(LegendLayoutBGColorActive, "LegendLayoutBGColorActive", true)%></td>
										</tr>
									</table>
									<%=Gui.GroupBoxEnd%>
								</TD>
							</TR>
						</TABLE>
					</DIV>
				</TD>
			</TR>
			</FORM>
			<TR>
				<TD ALIGN="RIGHT" VALIGN="BOTTOM">
				  	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
						<TR>
							<td>
								<%=Gui.Button(Translate.Translate("Ok"), "SaveLegend();", 0)%></td>
							<TD WIDTH="5"></TD>
					        <%If Base.ChkString(Base.Request("Opener")) <> "" Then%>
						        <TD><%=	Gui.Button(Translate.Translate("Luk"), "self.close();", 0)%></TD>
					        <%Else%>
							<td><%=Gui.Button(Translate.Translate("Annuller"), "location = 'PageFeature_List.aspx?tab=1';", 0)%></td>
							<%End if %>
							<TD WIDTH="10"></TD>
						</TR>
						<TR>
							<TD COLSPAN="4" HEIGHT="5"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
		<br />
	</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>