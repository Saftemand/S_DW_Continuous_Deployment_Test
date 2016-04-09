<%@ Page CodeBehind="PageFeature_Favorites_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.PageFeature_Favorites_Edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE><%=Translate.JsTranslate("Mine favoritter")%></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
		<script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
		<SCRIPT LANGUAGE="javascript">
		<!--
			function SaveFavorites() {
				ret = (IsControlValid(document.getElementById("FavoritesLayoutName"), 
						"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>") &&
					IsButtonTextControlValid("FavoritesLayoutButton", 50,
						"<%=Translate.JSTranslate("Max_%%_tegn_i:_", "%%", "50") & Translate.Translate("Ikon")%>"));
				
				if(ret)
					document.getElementById("frmFavorites").submit();
			}
		//-->
		</SCRIPT>
	</HEAD>
		<BODY>
		<%= Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("Mine favoritter")), Translate.Translate("Indstillinger"), "all", true) %>
		<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable" style="width:512px;">
			<FORM method="post" action="PageFeature_Favorites_Save.aspx<%=Base.IIf(Not IsNothing(Request.QueryString("ID")), "?id=" & Request.QueryString("ID"), "")%>" name="frmFavorites" id="frmFavorites">
			<input type=hidden name="Opener" value="<%=Request.QueryString("Opener")%>">
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
											<TD><INPUT type="text" id="FavoritesLayoutName" name="FavoritesLayoutName" value="<%=FavoritesLayoutName%>" maxlength="250" class="std"></td>
										</TR>
									</TABLE>
									<%=Gui.GroupBoxEnd%>
									<%=Gui.GroupBoxStart(Translate.Translate("Billeder"))%>
										<TABLE ID="Table1">
											<TR>
												<TD width="170" valign="top"><%=Translate.Translate("Ikon")%></TD>
												<TD><%= Gui.ButtonText("FavoritesLayoutButton", FavoritesLayoutButton, FavoritesLayoutButtonImage, FavoritesLayoutButtonText)%></td>
											</TR>
										</TABLE>
									<%=Gui.GroupBoxEnd%>
									<%=Gui.GroupBoxStart(Translate.Translate("Layout"))%>
									<TABLE>
										<TR>
											<TD width="170"><%=Translate.Translate("Template - %%", "%%",Translate.Translate("Liste"))%></TD>
											<TD><%= Gui.FileManager(FavoritesLayoutTemplateList, "Templates/PageFeatures", "FavoritesLayoutTemplateList")%></td>
										</TR>
										<TR>
											<TD width="170"><%=Translate.Translate("Template - %%", "%%",Translate.Translate("Element"))%></TD>
											<TD><%= Gui.FileManager(FavoritesLayoutTemplateElement, "Templates/PageFeatures", "FavoritesLayoutTemplateElement")%></td>
										</TR>
									</TABLE>
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
							<td><%= Gui.Button(Translate.Translate("Ok"), "SaveFavorites();", 0)%></td>
							<TD WIDTH="5"></TD>
					        <%If Base.ChkString(Base.Request("Opener")) <> "" Then%>
						        <TD><%=	Gui.Button(Translate.Translate("Luk"), "self.close();", 0)%></TD>
					        <%Else%>
							<td><%= Gui.Button(Translate.Translate("Annuller"), "location = 'PageFeature_List.aspx?tab=4';", 0)%></td>
							<%End If %>
							<TD WIDTH="10"></TD>
						</TR>
						<TR>
							<TD COLSPAN="4" HEIGHT="5"></TD>
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