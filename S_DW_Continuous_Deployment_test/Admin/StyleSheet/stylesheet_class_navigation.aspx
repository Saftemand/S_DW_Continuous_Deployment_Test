
<INPUT TYPE="HIDDEN" NAME="StylesheetClassSettings" VALUE="NavigationFontSize, NavigationFont, NavigationSpace, NavigationBold, NavigationItalic, NavigationUnderline, NavigationColor, NavigationImage, NavigationDividerImage, NavigationMouseoverColor, NavigationMouseoverBold, NavigationMouseoverItalic, NavigationMouseoverUnderline, NavigationMouseoverImage, NavigationActiveBold, NavigationActiveItalic, NavigationActiveUnderline, NavigationActiveColor, NavigationActiveImage, NavigationDividerImage, NavigationImgAfter, NavigationAlignRight, NavigationHideSpacer">
<DIV ID="Tab1" STYLE="DISPLAY:">
<TABLE WIDTH="100%" HEIGHT="280" BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable">
<TR>
	<TD><br>
		<%=Gui.GroupBoxStart(Translate.Translate("Font"))%>
		<TABLE>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Størrelse")%></TD>
				<TD>
					<%=Gui.FontSizeListExt(objProp.Value("NavigationFontSize"), "NavigationFontSize")%>
					<%=StyleSheet.CSSTagSubFields("NavigationFontSize", "font-size", 2)%>
					<%=StyleSheet.PseudoClass("NavigationFontSize", " A")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Font")%></TD>
				<TD>
					<%=Gui.FontFamilyList(objProp.Value("NavigationFont"), "NavigationFont")%>
					<%=StyleSheet.CSSTag("NavigationFont", "font-family")%>
					<%=StyleSheet.PseudoClass("NavigationFont", " A")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Mellemrum under menu")%></TD>
				<TD><%=Gui.SpacList(objProp.Value("NavigationSpace"), "NavigationSpace")%> px</TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Navigation"))%>
		<TABLE>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Fed")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("NavigationBold"), "Bold", "NavigationBold")%>
					<%=StyleSheet.CSSTag("NavigationBold", "font-weight")%>
					<%=StyleSheet.PseudoClass("NavigationBold", " A")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Kursiv")%></TD>
				<TD>	
					<%=StyleSheet.StyleCheckbox(objProp.Value("NavigationItalic"), "Italic", "NavigationItalic")%>
					<%=StyleSheet.CSSTag("NavigationItalic", "font-style")%>
					<%=StyleSheet.PseudoClass("NavigationItalic", " A")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Understregning")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("NavigationUnderline"), "Underline", "NavigationUnderline")%>
					<%=StyleSheet.CSSTag("NavigationUnderline", "text-decoration")%>
					<%=StyleSheet.PseudoClass("NavigationUnderline", " A")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Højrestil")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("NavigationAlignRight"), "right", "NavigationAlignRight")%>
					<%=StyleSheet.CSSTag("NavigationAlignRight", "text-align")%>
					<%=StyleSheet.PseudoClass("NavigationAlignRight", ", .dwne")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("NavigationColor"), "NavigationColor")%>
					<%=StyleSheet.CSSTag("NavigationColor", "color")%>
					<%=StyleSheet.PseudoClass("NavigationColor", " A")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Billede")%></TD>
				<TD><%=Gui.FileManager(objProp.Value("NavigationImage"), "Navigation", "NavigationImage")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Billede efter menupunkt")%></TD>
				<TD><%=StyleSheet.StyleCheckbox(objProp.Value("NavigationImgAfter"), "True", "NavigationImgAfter")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Grafik under menupunkt")%></TD>
				<TD><%=Gui.FileManager(objProp.Value("NavigationDividerImage"), "Navigation", "NavigationDividerImage")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Skjul mellemrum")%></TD>
				<TD><%=StyleSheet.StyleCheckbox(objProp.Value("NavigationHideSpacer"), "True", "NavigationHideSpacer")%></TD>
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
					<%=StyleSheet.StyleCheckbox(objProp.Value("NavigationMouseoverBold"), "Bold", "NavigationMouseoverBold")%>
					<%=StyleSheet.CSSTag("NavigationMouseoverBold", "font-weight")%>
					<%=StyleSheet.PseudoClass("NavigationMouseoverBold", " A:Hover")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Kursiv")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("NavigationMouseoverItalic"), "Italic", "NavigationMouseoverItalic")%>
					<%=StyleSheet.CSSTag("NavigationMouseoverItalic", "font-style")%>
					<%=StyleSheet.PseudoClass("NavigationMouseoverItalic", " A:Hover")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Understregning")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("NavigationMouseoverUnderline"), "Underline", "NavigationMouseoverUnderline")%>
					<%=StyleSheet.CSSTag("NavigationMouseoverUnderline", "text-decoration")%>
					<%=StyleSheet.PseudoClass("NavigationMouseoverUnderline", " A:Hover")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("NavigationMouseoverColor"), "NavigationMouseoverColor", true)%>
					<%=StyleSheet.CSSTag("NavigationMouseoverColor", "color")%>
					<%=StyleSheet.PseudoClass("NavigationMouseoverColor", " A:Hover")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Billede")%></TD>
				<TD><%=Gui.FileManager(objProp.Value("NavigationMouseoverImage"), "Navigation", "NavigationMouseoverImage")%></TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Aktiv"))%>
		<TABLE>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Fed")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("NavigationActiveBold"), "Bold", "NavigationActiveBold")%>
					<%=StyleSheet.CSSTag("NavigationActiveBold", "font-weight")%>
					<%=StyleSheet.PseudoClass("NavigationActiveBold", "_Active")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Kursiv")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("NavigationActiveItalic"), "Italic", "NavigationActiveItalic")%>
					<%=StyleSheet.CSSTag("NavigationActiveItalic", "font-style")%>
					<%=StyleSheet.PseudoClass("NavigationActiveItalic", "_Active")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Understregning")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("NavigationActiveUnderline"), "Underline", "NavigationActiveUnderline")%>
					<%=StyleSheet.CSSTag("NavigationActiveUnderline", "text-decoration")%>
					<%=StyleSheet.PseudoClass("NavigationActiveUnderline", "_Active")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("NavigationActiveColor"), "NavigationActiveColor", true)%>
					<%=StyleSheet.CSSTag("NavigationActiveColor", "color")%>
					<%=StyleSheet.PseudoClass("NavigationActiveColor", "_Active")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Billede")%></TD>
				<TD><%=Gui.FileManager(objProp.Value("NavigationActiveImage"), "Navigation", "NavigationActiveImage")%></TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<!-- #INCLUDE FILE="stylesheet_class_submit.aspx" -->
