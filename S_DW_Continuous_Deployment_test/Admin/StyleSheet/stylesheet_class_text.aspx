<!--
28/4-2003 - Nicolai:
Husk at der skal et P i stylesheet DB'en ved aktivering af H1 tags i stedet for span!
-->

<INPUT TYPE="HIDDEN" NAME="StylesheetClassSettings" VALUE="TextFontSize, TextFont, TextBold, TextItalic, TextUnderline, TextColor, TextLinespace<%	If Base.GetGs("/Globalsettings/Settings/TextEditor/Format") = "Heading" Then%>, TextMarginBottom, TextMarginTop<%	End If%>">
<DIV ID="Tab1" STYLE="DISPLAY:;width: 100%">
<TABLE WIDTH="100%" HEIGHT="280" BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable">
<TR>
	<TD><br>
		<%=Gui.GroupBoxStart(Translate.Translate("Font"))%>
		<TABLE>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Størrelse")%></TD>
				<TD>
					<%=Gui.FontSizeListExt(objProp.Value("TextFontSize"), "TextFontSize")%>
					<%=StyleSheet.CSSTagSubFields("TextFontSize", "font-size", 2)%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Font")%></TD>
				<TD>
					<%=Gui.FontFamilyList(objProp.Value("TextFont"), "TextFont")%>
					<%=StyleSheet.CSSTag("TextFont", "font-family")%></TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Skrifttype",1))%>
		<TABLE>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Fed")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("TextBold"), "Bold", "TextBold")%>
					<%=StyleSheet.CSSTag("TextBold", "font-weight")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Kursiv")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("TextItalic"), "Italic", "TextItalic")%>
					<%=StyleSheet.CSSTag("TextItalic", "font-style")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Understregning")%></TD>
				<TD>
					<%=StyleSheet.StyleCheckbox(objProp.Value("TextUnderline"), "Underline", "TextUnderline")%>
					<%=StyleSheet.CSSTag("TextUnderline", "text-decoration")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("TextColor"), "TextColor")%>
					<%=StyleSheet.CSSTag("TextColor", "color")%></TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Linieafstand"))%>
		<TABLE>
			<TR>
				<TD WIDTH="170">&nbsp;<%=Translate.Translate("Linieafstand")%></TD>
				<TD>
					<%=StyleSheet.LineHeight(objProp.Value("TextLinespace"), "TextLinespace")%>
					<%=StyleSheet.CSSTag("TextLinespace", "line-height")%></TD>
			</TR>
			<%	
			If Base.GetGs("/Globalsettings/Settings/TextEditor/Format") = "Heading" Then%>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Top margin")%></TD>
				<TD>
				<%'Response.write(Gui.SpacListExt(objProp.Value("TextMarginTop"), "TextMarginTop", 0, 10, 1, "px", , , , , "px"))%>
				<%=Gui.SpacListExt(objProp.Value("TextMarginTop"), "TextMarginTop", 0, 10, 1, "px", False, "55", "", "px")%>
				<%=StyleSheet.CSSTag("TextMarginTop", "margin-top")%>
				</TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Bund margin")%></TD>
				<TD>
				<%'Response.write(Gui.SpacListExt(objProp.Value("TextMarginBottom"), "TextMarginBottom", 0, 10, 1, "px", , , , , "px"))%>
				<%=Gui.SpacListExt(objProp.Value("TextMarginBottom"), "TextMarginBottom", 0, 10, 1, "px", False, "55", "", "px")%>
				<%=StyleSheet.CSSTag("TextMarginBottom", "margin-bottom")%>
				</TD>
			</TR>
			<%	End If%>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<!-- #INCLUDE FILE="stylesheet_class_submit.aspx" -->