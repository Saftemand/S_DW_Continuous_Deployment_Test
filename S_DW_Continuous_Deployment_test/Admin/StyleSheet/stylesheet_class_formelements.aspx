<INPUT TYPE="HIDDEN" NAME="StylesheetClassSettings" VALUE="InputFontSize, InputFont, InputBold, InputItalic, InputColor">
<DIV ID="Tab1" STYLE="DISPLAY:">
<TABLE WIDTH="100%" HEIGHT="280" BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable">
<TR>
	<TD valign="top"><br>
		<%=Gui.GroupBoxStart(Translate.Translate("Font"))%>
		<TABLE>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Størrelse")%></TD>
				<TD>
					<%=Gui.FontSizeListExt(objProp.Value("InputFontSize"), "InputFontSize")%>
					<%=StyleSheet.CSSTagSubFields("InputFontSize", "font-size", 2)%>
					<%=StyleSheet.PseudoClass("InputFontSize", "")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Font")%></TD>
				<TD>
					<%=Gui.FontFamilyList(objProp.Value("InputFont"), "InputFont")%>
					<%=StyleSheet.CSSTag("InputFont", "font-family")%>
					<%=StyleSheet.PseudoClass("InputFont", "")%></TD>
			</TR>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Fed")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("InputBold"), "Bold", "InputBold")%>
					<%=StyleSheet.CSSTag("InputBold", "font-weight")%>
					<%=StyleSheet.PseudoClass("InputBold", "")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Kursiv")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("InputItalic"), "Italic", "InputItalic")%>
					<%=StyleSheet.CSSTag("InputItalic", "font-style")%>
					<%=StyleSheet.PseudoClass("InputItalic", "")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("InputColor"), "InputColor")%>
					<%=StyleSheet.CSSTag("InputColor", "color")%>
					<%=StyleSheet.PseudoClass("InputColor", "")%></TD>
			</TR>
			
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<!-- #INCLUDE FILE="stylesheet_class_submit.aspx" -->
