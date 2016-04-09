<%@ Page CodeBehind="colorpicker.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.colorpicker" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
    Dim FieldName As String
    Dim FormId As String
</script>

<%
    If Not IsNothing(Request.QueryString.GetValues("formid")) AndAlso Not Base.ChkString(Request.QueryString("formid")) = "undefined" Then
        FormId = Request.QueryString.Item("formid")
    Else
        FormId = "StylesheetClassForm"
    End If
FieldName = Request.QueryString.Item("fieldname")
%>
<HTML>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE><%=Translate.JsTranslate("Farvevælger")%></TITLE>
	<LINK REL="STYLESHEET" TYPE="text/css" HREF="../STYLEsheet.css">
	<STYLE type="text/css">
	#visfarve {
		position: relative;
	}
	#visfarve2 {
		position: relative;
	}
	</STYLE>

	<SCRIPT LANGUAGE="JavaScript">
	function SetColor() {
	    var field = top.opener.document.getElementById('<%=FieldName%>');
	    var button = top.opener.document.getElementById('<%=FieldName%>Preview');
		field.value = document.getElementById('ColorPicker').ChosenColor.value;
		button.style.backgroundColor = document.getElementById('ColorPicker').ChosenColor.value;
		window.opener.focus();
		window.close();
	}
	
	function Cancel() {
		window.close();
	}
	
	function init(){
	    var _chosencolor = document.getElementById('ChosenColor');
	    var _origcolor = document.getElementById('OriginalColor');
		_chosencolor.value = window.opener.document.getElementById('<%=FormId%>').<%=FieldId%>.value;
		_origcolor.style.backgroundColor = window.opener.document.getElementById('<%=FormId%>').<%=FieldName%>.value;
	}
	
	function c(ColorCode) {
	    var _chosencolor = document.getElementById('ChosenColor');
	    var _newcolor = document.getElementById('NewColor');
		_chosencolor.value = ColorCode;
		_newcolor.style.backgroundColor = ColorCode;
	}
	
	function ValidateColor(obj, col) {
		if ((col.charAt(0)=="#") && (col.charAt(1)<="f") && (col.charAt(2)<="f") && (col.charAt(3)<="f") && (col.charAt(4)<="f") && (col.charAt(5)<="f") && (col.charAt(6)<="f") && (col.length==7)) {
		    var _newcolor = document.getElementById(obj);
		    _newcolor.style.backgroundColor = col;
		}
	}
	</SCRIPT>
</HEAD>
<BODY onLoad="init();">
<form NAME="ColorPicker" id="ColorPicker">
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" WIDTH="302">
<TR>
	<TD ALIGN="CENTER"><STRONG><%=Translate.Translate("Farvevælger")%></STRONG></TD>
</TR>
<TR>
	<TD ALIGN="LEFT">
		<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="302">
			<TR>
				<TD CLASS="hiddentab" HEIGHT="20" WIDTH="4"><BR></TD>
				<TD ID="Farve" CLASS="seltab" HEIGHT="20" ALIGN="CENTER" VALIGN="MIDDLE"><%=Translate.Translate("Farve")%></TD>
				<TD CLASS="hiddentab" HEIGHT="20" WIDTH="222"><BR></TD>
			</TR>
		</TABLE>
	</TD>
</TR>
</TABLE>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="300" STYLE="BORDER-left :1pt solid #003366;BORDER-RIGHT :1pt solid #003366;">
<TR><TD VALIGN="top">

	<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="2" WIDTH="300">
	<!--Main table-->
	<TR>
		<TD>
			<TABLE CELLSPACING="1" CELLPADDING="1" BORDER="0">
			<!--Colorpicker table-->
			<TR>
				<TD VALIGN="TOP">
					<!--Top colorpicker-->
					<TABLE BGCOLOR="#999999" CELLSPACING="1" CELLPADDING="1" BORDER="0">
					<TR>
						<TD BGCOLOR="#000000"><A HREF="JavaScript:c('#000000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#0F0000"><A HREF="JavaScript:c('#0F0000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#1E0000"><A HREF="JavaScript:c('#1E0000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#2D0000"><A HREF="JavaScript:c('#2D0000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#3C0000"><A HREF="JavaScript:c('#3C0000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#4B0000"><A HREF="JavaScript:c('#4B0000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#5A0000"><A HREF="JavaScript:c('#5A0000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#690000"><A HREF="JavaScript:c('#690000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#780000"><A HREF="JavaScript:c('#780000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#870000"><A HREF="JavaScript:c('#870000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#960000"><A HREF="JavaScript:c('#960000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#A50000"><A HREF="JavaScript:c('#A50000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#B40000"><A HREF="JavaScript:c('#B40000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#C30000"><A HREF="JavaScript:c('#C30000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#D20000"><A HREF="JavaScript:c('#D20000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#E10000"><A HREF="JavaScript:c('#E10000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#F00000"><A HREF="JavaScript:c('#F00000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#FF0000"><A HREF="JavaScript:c('#FF0000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#000000"><A HREF="JavaScript:c('#000000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#000F00"><A HREF="JavaScript:c('#000F00');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#001E00"><A HREF="JavaScript:c('#001E00');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#002D00"><A HREF="JavaScript:c('#002D00');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#003C00"><A HREF="JavaScript:c('#003C00');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#004B00"><A HREF="JavaScript:c('#004B00');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#005A00"><A HREF="JavaScript:c('#005A00');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#006900"><A HREF="JavaScript:c('#006900');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#007800"><A HREF="JavaScript:c('#007800');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#008700"><A HREF="JavaScript:c('#008700');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#009800"><A HREF="JavaScript:c('#009800');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00A500"><A HREF="JavaScript:c('#00A500');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00B400"><A HREF="JavaScript:c('#00B400');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00C300"><A HREF="JavaScript:c('#00C300');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00D200"><A HREF="JavaScript:c('#00D200');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00E100"><A HREF="JavaScript:c('#00E100');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00F000"><A HREF="JavaScript:c('#00F000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00FF00"><A HREF="JavaScript:c('#00FF00');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#000000"><A HREF="JavaScript:c('#000000');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00000F"><A HREF="JavaScript:c('#00000F');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00001E"><A HREF="JavaScript:c('#00001E');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00002D"><A HREF="JavaScript:c('#00002D');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00003C"><A HREF="JavaScript:c('#00003C');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00004B"><A HREF="JavaScript:c('#00004B');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#00005A"><A HREF="JavaScript:c('#00005A');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#000069"><A HREF="JavaScript:c('#000069');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#000078"><A HREF="JavaScript:c('#000078');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#000087"><A HREF="JavaScript:c('#000087');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#000096"><A HREF="JavaScript:c('#000096');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#0000A5"><A HREF="JavaScript:c('#0000A5');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#0000B4"><A HREF="JavaScript:c('#0000B4');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#0000C3"><A HREF="JavaScript:c('#0000C3');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#0000D2"><A HREF="JavaScript:c('#0000D2');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#0000E1"><A HREF="JavaScript:c('#0000E1');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#0000F0"><A HREF="JavaScript:c('#0000F0');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
						<TD BGCOLOR="#0000FF"><A HREF="JavaScript:c('#0000FF');"><IMG SRC="../images/nothing.gif" WIDTH="10" HEIGHT="10" BORDER="0"></A></TD>
					</TR>
					</TABLE>
					<!--Top colorpicker end-->
				</TD>
				<TD>&nbsp;</TD>
				<TD ROWSPAN="2" VALIGN="TOP">
					<!--Right colorpicker-->
					<TABLE BGCOLOR="#999999" CELLSPACING="1" CELLPADDING="1" BORDER="0">
						<TR><TD BGCOLOR="#000000"><A HREF="JavaScript:c('#000000');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#111111"><A HREF="JavaScript:c('#111111');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#222222"><A HREF="JavaScript:c('#222222');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#333333"><A HREF="JavaScript:c('#333333');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#444444"><A HREF="JavaScript:c('#444444');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#555555"><A HREF="JavaScript:c('#555555');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#666666"><A HREF="JavaScript:c('#666666');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#777777"><A HREF="JavaScript:c('#777777');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#888888"><A HREF="JavaScript:c('#888888');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#999999"><A HREF="JavaScript:c('#999999');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#AAAAAA"><A HREF="JavaScript:c('#AAAAAA');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#BBBBBB"><A HREF="JavaScript:c('#BBBBBB');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#CCCCCC"><A HREF="JavaScript:c('#CCCCCC');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#DDDDDD"><A HREF="JavaScript:c('#DDDDDD');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#EEEEEE"><A HREF="JavaScript:c('#EEEEEE');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
						<TR><TD BGCOLOR="#FFFFFF"><A HREF="JavaScript:c('#FFFFFF');"><IMG SRC="../images/nothing.gif" WIDTH="20" HEIGHT="10" BORDER="0"></A></TD></TR>
					</TABLE>
					<!--Right colorpicker end-->
				</TD>
			</TR>
			<TR>
				<TD COLSPAN="2" VALIGN="BOTTOM">
					<!--Main colorpicker-->
					<TABLE BGCOLOR="#999999" CELLSPACING="1" CELLPADDING="1" BORDER="0">
					<TR>
						<TD BGCOLOR="#FF0000""><A HREF="JavaScript:c('#FF0000');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF0033""><A HREF="JavaScript:c('#FF0033');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF0066"><A HREF="JavaScript:c('#FF0066');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF0099"><A HREF="JavaScript:c('#FF0099');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF00CC"><A HREF="JavaScript:c('#FF00CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF00FF"><A HREF="JavaScript:c('#FF00FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF3300"><A HREF="JavaScript:c('#FF3300');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF3333"><A HREF="JavaScript:c('#FF3333');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF3366"><A HREF="JavaScript:c('#FF3366');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF3399"><A HREF="JavaScript:c('#FF3399');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF33CC"><A HREF="JavaScript:c('#FF33CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF33FF"><A HREF="JavaScript:c('#FF33FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF6600"><A HREF="JavaScript:c('#FF6600');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF6633"><A HREF="JavaScript:c('#FF6633');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF6666"><A HREF="JavaScript:c('#FF6666');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF6699"><A HREF="JavaScript:c('#FF6699');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF66CC"><A HREF="JavaScript:c('#FF66CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF66FF"><A HREF="JavaScript:c('#FF66FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#CC0000"><A HREF="JavaScript:c('#CC0000');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC0033"><A HREF="JavaScript:c('#CC0033');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC0066"><A HREF="JavaScript:c('#CC0066');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC0099"><A HREF="JavaScript:c('#CC0099');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC00CC"><A HREF="JavaScript:c('#CC00CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC00FF"><A HREF="JavaScript:c('#CC00FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC3300"><A HREF="JavaScript:c('#CC3300');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC3333"><A HREF="JavaScript:c('#CC3333');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC3366"><A HREF="JavaScript:c('#CC3366');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC3399"><A HREF="JavaScript:c('#CC3399');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC33CC"><A HREF="JavaScript:c('#CC33CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC33FF"><A HREF="JavaScript:c('#CC33FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC6600"><A HREF="JavaScript:c('#CC6600');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC6633"><A HREF="JavaScript:c('#CC6633');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC6666"><A HREF="JavaScript:c('#CC6666');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC6699"><A HREF="JavaScript:c('#CC6699');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC66CC"><A HREF="JavaScript:c('#CC66CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC66FF"><A HREF="JavaScript:c('#CC66FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#990000"><A HREF="JavaScript:c('#990000');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#990033"><A HREF="JavaScript:c('#990033');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#990066"><A HREF="JavaScript:c('#990066');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#990099"><A HREF="JavaScript:c('#990099');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#9900CC"><A HREF="JavaScript:c('#9900CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#9900FF"><A HREF="JavaScript:c('#9900FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#993300"><A HREF="JavaScript:c('#993300');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#993333"><A HREF="JavaScript:c('#993333');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#993366"><A HREF="JavaScript:c('#993366');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#993399"><A HREF="JavaScript:c('#993399');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#9933CC"><A HREF="JavaScript:c('#9933CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#9933FF"><A HREF="JavaScript:c('#9933FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#996600"><A HREF="JavaScript:c('#996600');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#996633"><A HREF="JavaScript:c('#996633');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#996666"><A HREF="JavaScript:c('#996666');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#996699"><A HREF="JavaScript:c('#996699');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#9966CC"><A HREF="JavaScript:c('#9966CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#9966FF"><A HREF="JavaScript:c('#9966FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#660000"><A HREF="JavaScript:c('#660000');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#660033"><A HREF="JavaScript:c('#660033');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#660066"><A HREF="JavaScript:c('#660066');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#660099"><A HREF="JavaScript:c('#660099');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#6600CC"><A HREF="JavaScript:c('#6600CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#6600FF"><A HREF="JavaScript:c('#6600FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#663300"><A HREF="JavaScript:c('#663300');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#663333"><A HREF="JavaScript:c('#663333');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#663366"><A HREF="JavaScript:c('#663366');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#663399"><A HREF="JavaScript:c('#663399');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#6633CC"><A HREF="JavaScript:c('#6633CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#6633FF"><A HREF="JavaScript:c('#6633FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#666600"><A HREF="JavaScript:c('#666600');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#666633"><A HREF="JavaScript:c('#666633');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#666666"><A HREF="JavaScript:c('#666666');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#666699"><A HREF="JavaScript:c('#666699');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#6666CC"><A HREF="JavaScript:c('#6666CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#6666FF"><A HREF="JavaScript:c('#6666FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#330000"><A HREF="JavaScript:c('#330000');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#330033"><A HREF="JavaScript:c('#330033');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#330066"><A HREF="JavaScript:c('#330066');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#330099"><A HREF="JavaScript:c('#330099');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#3300CC"><A HREF="JavaScript:c('#3300CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#3300FF"><A HREF="JavaScript:c('#3300FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#333300"><A HREF="JavaScript:c('#333300');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#333333"><A HREF="JavaScript:c('#333333');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#333366"><A HREF="JavaScript:c('#333366');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#333399"><A HREF="JavaScript:c('#333399');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#3333CC"><A HREF="JavaScript:c('#3333CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#3333FF"><A HREF="JavaScript:c('#3333FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#336600"><A HREF="JavaScript:c('#336600');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#336633"><A HREF="JavaScript:c('#336633');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#336666"><A HREF="JavaScript:c('#336666');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#336699"><A HREF="JavaScript:c('#336699');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#3366CC"><A HREF="JavaScript:c('#3366CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#3366FF"><A HREF="JavaScript:c('#3366FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#000000"><A HREF="JavaScript:c('#000000');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#000033"><A HREF="JavaScript:c('#000033');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#000066"><A HREF="JavaScript:c('#000066');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#000099"><A HREF="JavaScript:c('#000099');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#0000CC"><A HREF="JavaScript:c('#0000CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#0000FF"><A HREF="JavaScript:c('#0000FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#003300"><A HREF="JavaScript:c('#003300');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#003333"><A HREF="JavaScript:c('#003333');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#003366"><A HREF="JavaScript:c('#003366');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#003399"><A HREF="JavaScript:c('#003399');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#0033CC"><A HREF="JavaScript:c('#0033CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#0033FF"><A HREF="JavaScript:c('#0033FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#006600"><A HREF="JavaScript:c('#006600');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#006633"><A HREF="JavaScript:c('#006633');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#006666"><A HREF="JavaScript:c('#006666');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#006699"><A HREF="JavaScript:c('#006699');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#0066CC"><A HREF="JavaScript:c('#0066CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#0066FF"><A HREF="JavaScript:c('#0066FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#009900"><A HREF="JavaScript:c('#009900');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#009933"><A HREF="JavaScript:c('#009933');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#009966"><A HREF="JavaScript:c('#009966');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#009999"><A HREF="JavaScript:c('#009999');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#0099CC"><A HREF="JavaScript:c('#0099CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#0099FF"><A HREF="JavaScript:c('#0099FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00CC00"><A HREF="JavaScript:c('#00CC00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00CC33"><A HREF="JavaScript:c('#00CC33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00CC66"><A HREF="JavaScript:c('#00CC66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00CC99"><A HREF="JavaScript:c('#00CC99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00CCCC"><A HREF="JavaScript:c('#00CCCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00CCFF"><A HREF="JavaScript:c('#00CCFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00FF00"><A HREF="JavaScript:c('#00FF00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00FF33"><A HREF="JavaScript:c('#00FF33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00FF66"><A HREF="JavaScript:c('#00FF66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00FF99"><A HREF="JavaScript:c('#00FF99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00FFCC"><A HREF="JavaScript:c('#00FFCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#00FFFF"><A HREF="JavaScript:c('#00FFFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#339900"><A HREF="JavaScript:c('#339900');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#339933"><A HREF="JavaScript:c('#339933');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#339966"><A HREF="JavaScript:c('#339966');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#339999"><A HREF="JavaScript:c('#339999');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#3399CC"><A HREF="JavaScript:c('#3399CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#3399FF"><A HREF="JavaScript:c('#3399FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33CC00"><A HREF="JavaScript:c('#33CC00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33CC33"><A HREF="JavaScript:c('#33CC33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33CC66"><A HREF="JavaScript:c('#33CC66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33CC99"><A HREF="JavaScript:c('#33CC99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33CCCC"><A HREF="JavaScript:c('#33CCCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33CCFF"><A HREF="JavaScript:c('#33CCFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33FF00"><A HREF="JavaScript:c('#33FF00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33FF33"><A HREF="JavaScript:c('#33FF33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33FF66"><A HREF="JavaScript:c('#33FF66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33FF99"><A HREF="JavaScript:c('#33FF99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33FFCC"><A HREF="JavaScript:c('#33FFCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#33FFFF"><A HREF="JavaScript:c('#33FFFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#669900"><A HREF="JavaScript:c('#669900');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#669933"><A HREF="JavaScript:c('#669933');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#669966"><A HREF="JavaScript:c('#669966');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#669999"><A HREF="JavaScript:c('#669999');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#6699CC"><A HREF="JavaScript:c('#6699CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#6699FF"><A HREF="JavaScript:c('#6699FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66CC00"><A HREF="JavaScript:c('#66CC00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66CC33"><A HREF="JavaScript:c('#66CC33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66CC66"><A HREF="JavaScript:c('#66CC66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66CC99"><A HREF="JavaScript:c('#66CC99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66CCCC"><A HREF="JavaScript:c('#66CCCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66CCFF"><A HREF="JavaScript:c('#66CCFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66FF00"><A HREF="JavaScript:c('#66FF00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66FF33"><A HREF="JavaScript:c('#66FF33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66FF66"><A HREF="JavaScript:c('#66FF66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66FF99"><A HREF="JavaScript:c('#66FF99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66FFCC"><A HREF="JavaScript:c('#66FFCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#66FFFF"><A HREF="JavaScript:c('#66FFFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#999900"><A HREF="JavaScript:c('#999900');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#999933"><A HREF="JavaScript:c('#999933');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#999966"><A HREF="JavaScript:c('#999966');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#999999"><A HREF="JavaScript:c('#999999');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#9999CC"><A HREF="JavaScript:c('#9999CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#9999FF"><A HREF="JavaScript:c('#9999FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99CC00"><A HREF="JavaScript:c('#99CC00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99CC33"><A HREF="JavaScript:c('#99CC33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99CC66"><A HREF="JavaScript:c('#99CC66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99CC99"><A HREF="JavaScript:c('#99CC99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99CCCC"><A HREF="JavaScript:c('#99CCCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99CCFF"><A HREF="JavaScript:c('#99CCFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99FF00"><A HREF="JavaScript:c('#99FF00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99FF33"><A HREF="JavaScript:c('#99FF33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99FF66"><A HREF="JavaScript:c('#99FF66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99FF99"><A HREF="JavaScript:c('#99FF99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99FFCC"><A HREF="JavaScript:c('#99FFCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#99FFFF"><A HREF="JavaScript:c('#99FFFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#CC9900"><A HREF="JavaScript:c('#CC9900');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC9933"><A HREF="JavaScript:c('#CC9933');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC9966"><A HREF="JavaScript:c('#CC9966');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC9999"><A HREF="JavaScript:c('#CC9999');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC99CC"><A HREF="JavaScript:c('#CC99CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CC99FF"><A HREF="JavaScript:c('#CC99FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCCC00"><A HREF="JavaScript:c('#CCCC00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCCC33"><A HREF="JavaScript:c('#CCCC33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCCC66"><A HREF="JavaScript:c('#CCCC66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCCC99"><A HREF="JavaScript:c('#CCCC99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCCCCC"><A HREF="JavaScript:c('#CCCCCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCCCFF"><A HREF="JavaScript:c('#CCCCFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCFF00"><A HREF="JavaScript:c('#CCFF00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCFF33"><A HREF="JavaScript:c('#CCFF33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCFF66"><A HREF="JavaScript:c('#CCFF66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCFF99"><A HREF="JavaScript:c('#CCFF99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCFFCC"><A HREF="JavaScript:c('#CCFFCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#CCFFFF"><A HREF="JavaScript:c('#CCFFFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					<TR>
						<TD BGCOLOR="#FF9900"><A HREF="JavaScript:c('#FF9900');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF9933"><A HREF="JavaScript:c('#FF9933');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF9966"><A HREF="JavaScript:c('#FF9966');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF9999"><A HREF="JavaScript:c('#FF9999');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF99CC"><A HREF="JavaScript:c('#FF99CC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FF99FF"><A HREF="JavaScript:c('#FF99FF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFCC00"><A HREF="JavaScript:c('#FFCC00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFCC33"><A HREF="JavaScript:c('#FFCC33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFCC66"><A HREF="JavaScript:c('#FFCC66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFCC99"><A HREF="JavaScript:c('#FFCC99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFCCCC"><A HREF="JavaScript:c('#FFCCCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFCCFF"><A HREF="JavaScript:c('#FFCCFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFFF00"><A HREF="JavaScript:c('#FFFF00');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFFF33"><A HREF="JavaScript:c('#FFFF33');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFFF66"><A HREF="JavaScript:c('#FFFF66');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFFF99"><A HREF="JavaScript:c('#FFFF99');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFFFCC"><A HREF="JavaScript:c('#FFFFCC');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
						<TD BGCOLOR="#FFFFFF"><A HREF="JavaScript:c('#FFFFFF');"><IMG SRC='../images/nothing.gif' WIDTH=10 HEIGHT=10 BORDER=0></A></TD>
					</TR>
					</TABLE>
					<!--Main colorpicker end-->
				</TD>
			</TR>
			<!--Colorpicker table end-->
			</TABLE>
		</TD>
	</TR>
	<TR>
		<TD BGCOLOR="#CCCCCC"><IMG SRC="../images/nothing.gif" WIDTH="1" HEIGHT="1" BORDER="0"></TD>
	</TR>
	<TR>
		<TD><STRONG><%=Translate.Translate("Valgt farve")%></STRONG>&nbsp;<input class="std" style="width:68px" type="text" size="9" maxlength="7" id="ChosenColor" name="ChosenColor" onchange="ValidateColor('NewColor',this.value)" onpropertychange="ValidateColor('NewColor',this.value);" /></TD>
	</TR>
	<TR>
		<TD>
			<!--Colortable-->
			<TABLE BGCOLOR="#999999" BORDER="0" CELLSPACING="1">
			<TR>
				<TD><DIV ID="NewColor"><IMG SRC="../images/nothing.gif" WIDTH="140" HEIGHT="18" BORDER="0"></DIV></TD>
				<TD><DIV ID="OriginalColor"><IMG SRC="../images/nothing.gif" WIDTH="140" HEIGHT="18" BORDER="0"></DIV></TD>
			</TR>
			</TABLE>
			<!--Colortable end-->
		</TD>
	</TR>
	<!--Main table-->
	</TABLE>

</TD>
</TR>
<tr>
	<td align="right" valign="bottom">
		<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
		<tr>
			<td colspan="4" height="5"></td>
		</tr>
		<TR>
			<TD ALIGN="RIGHT">
				<%=Gui.Button(Translate.Translate("OK"), "SetColor();", 0)%></TD>
			<td width="5"></td>
			<TD ALIGN="RIGHT">
				<%=Gui.Button(Translate.Translate("Annuller"), "Cancel();", 0)%></TD>
			<td width="10"></td>
		</TR>
		<tr>
			<td colspan="4" height="5"></td>
		</tr>
		</TABLE>
	</td>
</tr>
</TABLE>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="302" STYLE="BORDER-BOTTOM:1px solid #003366; BORDER-LEFT:1px solid #003366; BORDER-RIGHT:1px solid #003366;">
<TR>
	<TD ALIGN=RIGHT><IMG SRC="../images/bund_hojre.gif" WIDTH="110" HEIGHT="4" alt="" BORDER="0" ALIGN="absbottom"></TD>
</TR>
</TABLE>
</form>
</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>