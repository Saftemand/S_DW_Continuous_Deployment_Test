
<INPUT TYPE="HIDDEN" NAME="StylesheetClassSettings" VALUE="TableBorderSize, TableBorderColor, TableBorderType, TableRowOneColor, TableRowOneFontColor, TableRowOneHeight, TableRowTwoColor, TableRowTwoFontColor, TableRowTwoHeight, TableRowSpacerColor, TableRowSpacerHeight">
<DIV ID="Tab1" STYLE="DISPLAY:">
<TABLE WIDTH="100%" HEIGHT="280" BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable" style="width:512px;">
<TR>
	<TD><br>
		<%=Gui.GroupBoxStart(Translate.Translate("Ramme"))%>
		<TABLE>
			<TR>
				<TD WIDTH="100">&nbsp;<%=Translate.Translate("Størrelse")%></TD>
				<TD><INPUT TYPE="TEXT" NAME="TableBorderSize" MAXLENGTH="255" VALUE="<%=objProp.Value("TableBorderSize")%>">
					<%=StyleSheet.CSSTag("TableBorderSize", "FONT-SIZE")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("TableBorderColor"), "TableBorderColor")%>
					<%=StyleSheet.CSSTag("TableBorderColor", "FONT-SIZE")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Type")%></TD>
				<TD>
					<%=StyleSheet.ListDropdownLayout(objProp.Value("PageNavigationDropdownLayout"), "PageNavigationDropdownLayout")%>
					<%=StyleSheet.CSSTag("PageNavigationDropdownLayout", "FONT-SIZE")%></TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("1. Række"))%>
		<TABLE>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("TableRowOneColor"), "TableRowOneColor")%>
					<%=StyleSheet.CSSTag("TableRowOneColor", "FONT-SIZE")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Tekstfarve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("TableRowOneFontColor"), "TableRowOneFontColor")%>
					<%=StyleSheet.CSSTag("TableRowOneFontColor", "FONT-SIZE")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Højde")%></TD>
				<TD><INPUT TYPE="TEXT" NAME="TableRowOneHeight" MAXLENGTH="255" VALUE="<%=objProp.Value("TableRowOneHeight")%>">
					<%=StyleSheet.CSSTag("TableRowOneHeight", "FONT-SIZE")%></TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("2. Række"))%>
		<TABLE>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("TableRowTwoColor"), "TableRowTwoColor")%>
					<%=StyleSheet.CSSTag("TableRowTwoColor", "FONT-SIZE")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Tekstfarve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("TableRowTwoFontColor"), "TableRowTwoFontColor")%>
					<%=StyleSheet.CSSTag("TableRowTwoFontColor", "FONT-SIZE")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Højde")%></TD>
				<TD><INPUT TYPE="TEXT" NAME="TableRowTwoHeight" MAXLENGTH="255" VALUE="<%=objProp.Value("TableRowTwoHeight")%>">
					<%=StyleSheet.CSSTag("TableRowTwoHeight", "FONT-SIZE")%></TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Rækkemellemrum"))%>
		<TABLE>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Farve")%></TD>
				<TD>
					<%=Gui.ColorSelect(objProp.Value("TableRowSpacerColor"), "TableRowSpacerColor")%>
					<%=StyleSheet.CSSTag("TableRowSpacerColor", "FONT-SIZE")%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Translate.Translate("Højde")%></TD>
				<TD><INPUT TYPE="TEXT" NAME="TableRowSpacerHeight" MAXLENGTH="255" VALUE="<%=objProp.Value("TableRowSpacerHeight")%>">
					<%=StyleSheet.CSSTag("TableRowSpacerHeight", "FONT-SIZE")%></TD>
			</TR>
		</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<!-- #INCLUDE FILE="stylesheet_class_submit.aspx" -->
