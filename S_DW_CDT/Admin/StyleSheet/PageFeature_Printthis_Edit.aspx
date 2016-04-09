<%@ Page CodeBehind="PageFeature_Printthis_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.PageFeature_Printthis_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<HTML>
	<HEAD>
		<TITLE><%=Translate.JsTranslate("Printvenlig side")%></TITLE>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
		<script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
		<SCRIPT LANGUAGE="javascript">
		<!--
			function SavePrintThis() {
				var ret = false;
				
				ret = (IsControlValid(document.getElementById("PrintthisLayoutName"), 
						"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>") &&
					IsButtonTextControlValid("PrintthisLayoutButton", 250,
						"<%=Translate.JSTranslate("Max_%%_tegn_i:_", "%%", "250") & Translate.Translate("Ikon")%>"));
				
				if(ret)
					document.getElementById("frmPrintThis").submit();
			}
		//-->
		</SCRIPT>
	</HEAD>
	<BODY>
	<FORM method="post" action="PageFeature_Printthis_Save.aspx<%=Base.IIf(Not IsNothing(Request.QueryString("ID")), "?id=" & Request.QueryString("ID"), "")%>" name="frmPrintThis" id="frmPrintThis">
	<%= Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("Printvenlig side")), Translate.Translate("Indstillinger"), "all", true)	%>
		<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable" style="width:512px;">
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
												<TD><INPUT type="text" id="PrintthisLayoutName" name="PrintthisLayoutName" value="<%=PrintthisLayoutName%>" maxlength="250" class="std"></td>
											</TR>
										</TABLE>
									<%=Gui.GroupBoxEnd%>
									<%=Gui.GroupBoxStart(Translate.Translate("Billeder"))%>
										<TABLE>
											<TR>
												<TD width="170" valign="top"><%=Translate.Translate("Ikon")%></TD>
												<TD><%= Gui.ButtonText("PrintthisLayoutButton", PrintthisLayoutButton, PrintthisLayoutButtonImage, PrintthisLayoutButtonText)%></td>
											</TR>
										</TABLE>
									<%=Gui.GroupBoxEnd%>
									<%=Gui.GroupBoxStart(Translate.Translate("Layout"))%>
										<TABLE>
											<TR>
												<TD width="170"><%=Translate.Translate("Stylesheet")%></TD>
												<TD><%= Gui.StylesheetList(PrintthisLayoutStylesheetID, "PrintthisLayoutStylesheetID")%></td>
											</TR>
											<TR>
												<TD width="170"><%=Translate.Translate("Vis printdialog")%></TD>
												<TD><%= Gui.Checkbox(PrintthisLayoutShowDialog, "PrintthisLayoutShowDialog")%></td>
											</TR>
										</TABLE>
									<%=Gui.GroupBoxEnd%>
								</TD>
							</TR>
						</TABLE>
					</DIV>
				</TD>
			</TR>
			<TR>
				<TD ALIGN="RIGHT" VALIGN="BOTTOM">
				  	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
						<TR>
							<td><%= Gui.Button(Translate.Translate("Ok"), "SavePrintThis()", 0)%></td>
							<TD WIDTH="5"></TD>
					        <%If Base.ChkString(Base.Request("Opener")) <> "" Then%>
						        <TD><%=	Gui.Button(Translate.Translate("Luk"), "self.close();", 0)%></TD>
					        <%Else%>
							<td><%= Gui.Button(Translate.Translate("Annuller"), "location = 'PageFeature_List.aspx?tab=2';", 0)%></td>
							<%End If%>
							<TD WIDTH="10"></TD>
						</TR>
						<TR>
							<TD COLSPAN="4" HEIGHT="5"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	</FORM>
	</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>