<%@ Page CodeBehind="Dropdown_edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Dropdown_edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
	<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
</head>
<script>
function Dropdown_save(FileToHandle){
	if(document.getElementById('StylesheetClassForm').DropdownLayoutName.value.length<1){
		alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
		document.getElementById('StylesheetClassForm').DropdownLayoutName.focus();
	}else{
		document.getElementById('StylesheetClassForm').action = FileToHandle;
		document.getElementById('StylesheetClassForm').submit();
	}
}

function validerColor(obj,col){
	if ((col.charAt(0)=="#") && (col.charAt(1)<="f") && (col.charAt(2)<="f") && (col.charAt(3)<="f") && (col.charAt(4)<="f") && (col.charAt(5)<="f") && (col.charAt(6)<="f") && (col.length==7)){
		document.all[obj].value = col;
	}
}

function CheckWidth(elm){
	if(elm.value.length<1){
		elm.value = 0;
	}
	if(parseInt(elm.value)!=elm.value){
		alert("<%=Translate.JsTranslate("Det skal være en numerisk værdi")%>...");
		elm.value = 0;
		elm.focus();
	}
}

function ColorPicker(exColor, fieldName){
	colorWin = window.open("colorpicker.aspx?fieldname=" + fieldName, "", "resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=320,height=360");
}

function ValidateColor(obj, col){
	if ((col.charAt(0)=="#") && (col.charAt(1)<="f") && (col.charAt(2)<="f") && (col.charAt(3)<="f") && (col.charAt(4)<="f") && (col.charAt(5)<="f") && (col.charAt(6)<="f") && (col.length==7)){
		document.all[obj].style.backgroundColor=col;
	}
}
</script>
<%= Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Stylesheet"),"%c%",Translate.Translate("dropdown")), Translate.Translate("Dropdown"), "all", true) %>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable" style="width:512px;">
	<TR>
		<TD VALIGN="TOP">
			<BR>
			<DIV ID="Tab1" STYLE="display:;">
			<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<form method=post name="StylesheetClassForm" id="StylesheetClassForm">
				<input type=hidden name="Opener" value="<%=Request.QueryString.Item("Opener")%>">
				<%'If Request.QueryString("ID").length > 0 Then%>
					<input type=hidden name="DropdownLayoutID" value="<%=DropdownLayoutID%>">
				<%'Else
				'	DropdownLayoutName = ""
				'End If%>
				<TR>
					<TD><br>
					<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
					<TABLE>
						<tr>
							<td width=170><%=Translate.Translate("Navn")%></td>
							<td><input type="text" name="DropdownLayoutName" value="<%=DropdownLayoutName%>" <%If CDbl(Request.QueryString.Item("ID")) = 1 Then Response.Write("disabled")%> maxlength="255" class=std></td>
						</tr>
					</TABLE>
					<%=Gui.GroupBoxEnd%>
					</TD>
				</TR>
				<TR>
					<TD>
					<%=Gui.GroupBoxStart(Translate.Translate("Layout"))%>
					<TABLE border=0 cellpadding=2 cellspacing=0 width=100%>
						<tr>
							<td width="170"><%=Translate.Translate("Minimum højde på menupunkt")%></td>
							<td><%= Gui.FontSizeList(DropdownLayoutItemHeight, "DropdownLayoutItemHeight")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Gennemsigtighed")%></td>
							<td>
								<select name="DropdownLayoutTableOpacity" class=std style="width=50px;">
									<option value="100"<%If DropdownLayoutTableOpacity = 100 Then Response.Write(" Selected")%>>0%</option>
									<option value="98"<%If DropdownLayoutTableOpacity = 98 Then Response.Write(" Selected")%>>2%</option>
									<option value="96"<%If DropdownLayoutTableOpacity = 96 Then Response.Write(" Selected")%>>4%</option>
									<option value="94"<%If DropdownLayoutTableOpacity = 94 Then Response.Write(" Selected")%>>6%</option>
									<option value="92"<%If DropdownLayoutTableOpacity = 92 Then Response.Write(" Selected")%>>8%</option>
									<option value="90"<%If DropdownLayoutTableOpacity = 90 Then Response.Write(" Selected")%>>10%</option>
									<option value="88"<%If DropdownLayoutTableOpacity = 88 Then Response.Write(" Selected")%>>12%</option>
									<option value="86"<%If DropdownLayoutTableOpacity = 86 Then Response.Write(" Selected")%>>14%</option>
									<option value="84"<%If DropdownLayoutTableOpacity = 84 Then Response.Write(" Selected")%>>16%</option>
									<option value="82"<%If DropdownLayoutTableOpacity = 82 Then Response.Write(" Selected")%>>18%</option>
									<option value="80"<%If DropdownLayoutTableOpacity = 80 Then Response.Write(" Selected")%>>20%</option>
								</select>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Ramme"))%>
					<table border=0 cellpadding=2 cellspacing=0 width=100%>
						<tr>
							<td width="170"><%=Translate.Translate("Bredde")%></td>
							<td><input type="text" value="<%=DropdownLayoutTableWidth%>" name="DropdownLayoutTableWidth" size="3" maxlength="3" onblur="CheckWidth(this);" class="std" style="width=50px;">&nbsp;px</td>
						</tr>
						<tr>
							<td valign="top" width="170"><%=Translate.Translate("Type")%></td>
							<td align="left">
								<select name="DropdownLayoutTableBorderStyle" class=std style="width=75px;">
									<option value="Solid"<%If DropdownLayoutTableBorderStyle = "Solid" Then Response.Write(" Selected")%>><%=Translate.Translate("Streg")%>
									<option value="Dashed"<%If DropdownLayoutTableBorderStyle = "Dashed" Then Response.Write(" Selected")%>><%=Translate.Translate("Stiplet")%>
									<option value="Dotted"<%If DropdownLayoutTableBorderStyle = "Dotted" Then Response.Write(" Selected")%>><%=Translate.Translate("Prikket")%>
								</select>
							</td>
						</tr>
						<tr>
							<td valign="top" width="170"><%=Translate.Translate("Tykkelse")%></td>
							<td align="left">
								<%=Gui.Dropdown("DropdownLayoutTableBorderWidth",0,5,DropdownLayoutTableBorderWidth.ToString,"px","class=std style='width=50px;'")%>
							</td>
						</tr>
						<tr>
							<td valign="top" width="170"><%=Translate.Translate("Farve")%></td>
							<td align="left">
								<%= Gui.ColorSelect(DropdownLayoutTableBorderColor, "DropdownLayoutTableBorderColor")%>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Mellemrum"))%>
					<table border=0 cellpadding=2 cellspacing=0 width=100%>
						<tr>
							<td width="170"><%=Translate.Translate("Farve")%></td>
							<td><%= Gui.ColorSelect(DropdownLayoutSpacerBGColor, "DropdownLayoutSpacerBGColor", true)%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Højde")%></td>
							<td><%=Gui.Dropdown("DropdownLayoutSpacerHeight",1,5,DropdownLayoutSpacerHeight.ToString,"px","class=std style='width=50px;'")%></td>
						</tr>
					</TABLE>
					<%=Gui.GroupBoxEnd%>
					</TD>
				</TR>
				<TR>
					<TD>
					<%=Gui.GroupBoxStart(Translate.Translate("Menupunkt"))%>
					<TABLE>
						<tr>
							<td width="170"><%=Translate.Translate("Font")%></td>
							<td><%= Gui.FontFamilyList(DropdownLayoutItemFont, "DropdownLayoutItemFont")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Fontstørrelse")%></td>
							<td><%= Gui.FontSizeList(DropdownLayoutItemFontSize, "DropdownLayoutItemFontSize")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Typografi")%></td>
							<td valign=bottom><%= StyleSheet.StyleCheckbox(DropdownLayoutItemFontWeight, "Bold", "DropdownLayoutItemFontWeight")%><label for "DropdownLayoutItemFontWeight"><%=Translate.Translate("Fed")%></label> </td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Fontfarve")%></td>
							<td><%= Gui.ColorSelect(DropdownLayoutItemFontColor, "DropdownLayoutItemFontColor", true)%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Baggrundsfarve")%></td>
							<td><%= Gui.ColorSelect(DropdownLayoutItemBGColor, "DropdownLayoutItemBGColor", true)%></td>
						</tr>
					</TABLE>
					<%=Gui.GroupBoxEnd%>
					</TD>
				</TR>
				<TR>
					<TD>
					<%=Gui.GroupBoxStart(Translate.Translate("Menupunkt - mouseover"))%>
					<TABLE>
						<tr>
							<td width="170"><%=Translate.Translate("Font")%></td>
							<td align="right"><%= Gui.FontFamilyList(DropdownLayoutItemFontActive, "DropdownLayoutItemFontActive")%></td>
						</tr>
						<tr>
							<td width="170"><%=Translate.Translate("Fontstørrelse")%></td>
							<td><%= Gui.FontSizeList(DropdownLayoutItemFontSizeActive, "DropdownLayoutItemFontSizeActive")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Typografi")%></td>
							<td><%=StyleSheet.StyleCheckbox(DropdownLayoutItemFontWeightActive, "Bold", "DropdownLayoutItemFontWeightActive")%><label for "DropdownLayoutItemFontWeightActive"><%=Translate.Translate("Fed")%></label> </td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Fontfarve")%></td>
							<td><%= Gui.ColorSelect(DropdownLayoutItemFontColorActive, "DropdownLayoutItemFontColorActive", true)%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Baggrundsfarve")%></td>
							<td><%= Gui.ColorSelect(DropdownLayoutItemBGColorActive, "DropdownLayoutItemBGColorActive", true)%></td>
						</tr>
					</TABLE>
					<%=Gui.GroupBoxEnd%>
					</TD>
				</TR>
				</form>
				</table>
				</DIV>
		</TD>
	</TR>
	<TR>
		<TD ALIGN="RIGHT" VALIGN="BOTTOM">
		  	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
				<TR>
					<td><%=Gui.Button(Translate.Translate("Ok"), "Dropdown_save('Dropdown_save.aspx');", 0)%></td>
					<TD WIDTH="5"></TD>
					<%If Base.ChkString(Base.Request("Opener")) <> "" Then%>
						<TD><%=	Gui.Button(Translate.Translate("Luk"), "self.close();", 0)%></TD>
					<%Else%>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Dropdown_List.aspx'", 0)%></td>
					<%End If %>
					<TD WIDTH="10"></TD>
				</TR>
				<TR>
					<TD COLSPAN="4" HEIGHT="5"></TD>
				</TR>
			</TABLE><br />
		</TD>
	</TR>
</TABLE>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>