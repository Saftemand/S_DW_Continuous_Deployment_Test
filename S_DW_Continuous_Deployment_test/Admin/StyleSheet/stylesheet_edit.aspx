<%@ Page CodeBehind="stylesheet_edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.stylesheet_edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.SystemTools" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
'**************************************************************************************************
'	Current version:	0.9
'	Created:			04-12-2001
'	Last modfied:		19-12-2001
'
'	Purpose: Edits stylesheet classes
'
'	Revision history:
'		1.0 - 03-12-2001 - Michael Lykke
'		First version
'**************************************************************************************************

%>
<HTML>
<HEAD>
	<TITLE><%=Translate.JsTranslate("Stylesheet")%></TITLE>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<LINK REL="STYLESHEET" TYPE="text/css" HREF="../stylesheet.css">
	<SCRIPT LANGUAGE="JavaScript">
		function ValidateColor(obj, col){
			if ((col.charAt(0)=="#") && (col.charAt(1)<="f") && (col.charAt(2)<="f") && (col.charAt(3)<="f") && (col.charAt(4)<="f") && (col.charAt(5)<="f") && (col.charAt(6)<="f") && (col.length==7)){
				document.getElementById(obj).style.backgroundColor=col;
			}
		}
		
		function ValidateInt(obj) {
			if (!parseInt(obj.value)) {
				alert('<%=Translate.JsTranslate("Ugyldig værdi!")%>');
				obj.value='';
				obj.focus();
			}
			else {
				obj.value = parseInt(obj.value);
			}

		}

		function calcSize(){
			objForm = document.getElementById('StylesheetClassForm');
			PageWidth = 0;
			PageWidth += parseInt(objForm.PageLeftMargin.value);
			PageWidth += parseInt(objForm.PageRightMargin.value);
			PageWidth += parseInt(objForm.PageMenuWidth.value);
			PageWidth += parseInt((objForm.PageColumnWidth.value*6));
			PageWidth += parseInt((objForm.PageColumnSpace.value*5));
			document.getElementById("pagewidth").innerHTML = PageWidth;
		}

		function PageNavigationDropdown(){
			if(document.getElementById('StylesheetClassForm').PageNavigation.selectedIndex == 4 || document.getElementById('StylesheetClassForm').PageNavigation.selectedIndex == 5){
				document.getElementById("PageNaviagtionDropdownLayout").style.display = "";
			}else{
				document.getElementById("PageNaviagtionDropdownLayout").style.display = "none";
			}
		}

		function ColorPicker(exColor, fieldName, formId){
			colorWin = window.open("colorpicker.aspx?fieldname=" + fieldName + "&formid=" + formId, "", "resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=320,height=360");
		}

		function edit(strLink, strWidth, strHeight){
			editWin = window.open(strLink, "", "resizable=no,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width="+strWidth+",height="+strHeight+"");
		}
	</SCRIPT>
	<script src="/Admin/Color.js" type="text/javascript"></script>
</HEAD>

<BODY topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" width="100%">
<form NAME="StylesheetClassForm" id="StylesheetClassForm" METHOD="POST" ACTION="stylesheet_save.aspx">
	<INPUT TYPE="HIDDEN" NAME="ClassID" VALUE="<%=Request.QueryString.Item("ClassID")%>">
	<INPUT TYPE="HIDDEN" NAME="StylesheetID" VALUE="<%=Request.QueryString.Item("StylesheetID")%>">
	<INPUT TYPE="HIDDEN" NAME="StylesheetName" VALUE="<%=Server.HtmlEncode(Request.QueryString.Item("StylesheetName"))%>">
	<input type="hidden" id="Caller" name="Caller" value='<%=Request.QueryString("Caller") %>' />
    <input type="hidden" id="SaveOnly" name="SaveOnly" value="0" />
	
	<TR>
		<TD>
			<%If ClassType = 1 Then %>
				<%=Gui.MakeHeaders(Translate.Translate("Rediger stylesheet (%s%) - %c%", "%s%", Server.HtmlEncode(Request.QueryString.Item("StylesheetName")), "%c%",Translate.Translate("Tekster")), Translate.Translate(ClassName,8), "all", True)%>
				<!-- #INCLUDE FILE="stylesheet_class_text.aspx" -->
			<%ElseIf ClassType = 2 Then %>
			    <%=Gui.MakeHeaders(Translate.Translate("Rediger stylesheet (%s%) - %c%", "%s%", Request.QueryString.Item("StylesheetName"),"%c%",Translate.Translate("Link")), Translate.Translate(ClassName,8), "all", True)%>
				<!-- #INCLUDE FILE="stylesheet_class_link.aspx" -->
			<%ElseIf ClassType = 3 Then %>
				<%=Gui.MakeHeaders(Translate.Translate("Rediger stylesheet (%s%) - %c%", "%s%", Request.QueryString.Item("StylesheetName"),"%c%",Translate.Translate("Navigation")), Translate.Translate(ClassName,8), "all", True)%>
				<!-- #INCLUDE FILE="stylesheet_class_navigation.aspx" -->
			<%ElseIf ClassType = 4 Then %>
				<%=Gui.MakeHeaders(Translate.Translate("Rediger stylesheet (%s%) - %c%", "%s%", Request.QueryString.Item("StylesheetName"),"%c%",Translate.Translate("Side",8)), Translate.Translate("Side") & "," & Translate.Translate("Template") & "," & Translate.Translate("Sidefod") & "," & Translate.Translate("Side egenskaber"), "all", true)%>
				<!-- #INCLUDE FILE="stylesheet_class_page.aspx" -->
			<%ElseIf ClassType = 5 Then %>
				<%=Gui.MakeHeaders(Translate.Translate("Rediger stylesheet (%s%) - %c%", "%s%", Request.QueryString.Item("StylesheetName"),"%c%",Translate.Translate("Tabel")), Translate.Translate(ClassName,8), "all", True)%>
				<!-- #INCLUDE FILE="stylesheet_class_table.aspx" -->
			<%ElseIf ClassType = 6 Then %>
				<%=Gui.MakeHeaders(Translate.Translate("Rediger stylesheet (%s%) - %c%", "%s%", Request.QueryString.Item("StylesheetName"),"%c%",Translate.Translate("Form felter")), Translate.Translate(ClassName,8), "all", True)%>
				<!-- #INCLUDE FILE="stylesheet_class_formelements.aspx" -->
			<%End If%>
			
			<%=Dynamicweb.Gui.SelectTab() %>
		</TD>
	</TR>
</form>
</TABLE>
</BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>