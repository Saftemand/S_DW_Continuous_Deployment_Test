
<INPUT TYPE="HIDDEN" NAME="StylesheetClassSettings" VALUE="LinkFontSize, LinkFont, LinkBold, LinkItalic, LinkUnderline, LinkColor, LinkMouseoverBold, LinkMouseoverItalic, LinkMouseoverUnderline, LinkMouseoverColor, LinkMouseoverImage, LinkVisitedColor">
<DIV ID="Tab1" STYLE="DISPLAY:">
<TABLE WIDTH="100%" HEIGHT="280" BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable">
<TR>
	<TD><br>
		<%=Gui.GroupBoxStart(Translate.Translate("Font"))%>
		<TABLE>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Størrelse")%></TD>
				<TD><%=Gui.FontSizeListExt(objProp.Value("LinkFontSize"), "LinkFontSize")%>
					<%=StyleSheet.CSSTagSubFields("LinkFontSize", "font-size", 2)%>
					<%=StyleSheet.PseudoClass("LinkFontSize", " A")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Font")%></TD>
				<TD>
					<%=Gui.FontFamilyList(objProp.Value("LinkFont"), "LinkFont")%>
					<%=StyleSheet.CSSTag("LinkFont", "font-family")%>
					<%=StyleSheet.PseudoClass("LinkFont", " A")%>
				</TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Link"))%>
		<TABLE>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Fed")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("LinkBold"), "Bold", "LinkBold")%>
					<%=StyleSheet.CSSTag("LinkBold", "font-weight")%>
					<%=StyleSheet.PseudoClass("LinkBold", " A")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Kursiv")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("LinkItalic"), "Italic", "LinkItalic")%>
					<%=StyleSheet.CSSTag("LinkItalic", "font-style")%>
					<%=StyleSheet.PseudoClass("LinkItalic", " A")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Understregning")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("LinkUnderline"), "Underline", "LinkUnderline")%>
					<%=StyleSheet.CSSTag("LinkUnderline", "text-decoration")%>
					<%=StyleSheet.PseudoClass("LinkUnderline", " A")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("LinkColor"), "LinkColor")%>
					<%=StyleSheet.CSSTag("LinkColor", "color")%>
					<%=StyleSheet.PseudoClass("LinkColor", " A")%></TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Mouseover"))%>
		<TABLE>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Fed")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("LinkMouseoverBold"), "Bold", "LinkMouseoverBold")%>
					<%=StyleSheet.CSSTag("LinkMouseoverBold", "font-weight")%>
					<%=StyleSheet.PseudoClass("LinkMouseoverBold", " A:Hover")%>
				</TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Kursiv")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("LinkMouseoverItalic"), "Italic", "LinkMouseoverItalic")%>
					<%=StyleSheet.CSSTag("LinkMouseoverItalic", "font-style")%>
					<%=StyleSheet.PseudoClass("LinkMouseoverItalic", " A:Hover")%>
					</TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Understregning")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("LinkMouseoverUnderline"), "Underline", "LinkMouseoverUnderline")%>
					<%=StyleSheet.CSSTag("LinkMouseoverUnderline", "text-decoration")%>
					<%=StyleSheet.PseudoClass("LinkMouseoverUnderline", " A:Hover")%>
				</TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("LinkMouseoverColor"), "LinkMouseoverColor", true)%>
					<%=StyleSheet.CSSTag("LinkMouseoverColor", "color")%>
					<%=StyleSheet.PseudoClass("LinkMouseoverColor", " A:Hover")%>
				</TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<TR style="display:none"><!--Removed due to problems with the link color of navigation...-->
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Aktiv"))%>
		<TABLE>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("LinkActiveColor"), "LinkActiveColor", true)%>
					<%=StyleSheet.CSSTag("LinkActiveColor", "color")%>
					<%=StyleSheet.PseudoClass("LinkActiveColor", " A:Active")%>
				</TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<!-- #INCLUDE FILE="stylesheet_class_submit.aspx" -->
