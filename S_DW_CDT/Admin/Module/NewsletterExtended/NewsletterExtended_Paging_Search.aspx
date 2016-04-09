<%@ Page CodeBehind="NewsletterExtended_Paging_Search.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Paging_Search" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
    Dim PageType As String
    Dim SearchStr As String
    Dim NextPosition As String
    Dim Position As String
    Dim TypeID As String
    Dim PrevPosition As Double
    Dim SortOrder As String
    Dim NLAllwaysSearchInAllCategories As String
    Dim NLShowAllOnList As String
    Dim AllCategoryField As String
    Dim Amount As String
    Dim NextPostion As Double
    Dim NLRowNumbers As String
    Dim InActive As String

    If NLRowNumbers = "" Then
        NLRowNumbers = 20
    End If
    If NLShowAllOnList = "1" Then
        NLRowNumbers = 32000
    End If

    Position = Request.Item("Position")
    Amount = Request.Item("Amount")
    PageType = Request.Item("Type")
    TypeID = Request.Item("TypeID")
    SearchStr = Request.Item("SearchStr")
    SortOrder = Request.Item("SortOrder")
    AllCategoryField = Request.Item("AllCategoryField")
    InActive = Request.Item("InActive")
    
    NextPostion = CInt(Position) + NLRowNumbers

    If NextPosition = "" Then
        NextPosition = NLRowNumbers
    End If

    PrevPosition = CInt(Position) - NLRowNumbers
%>
<SCRIPT LANGUAGE="JavaScript">
<!--

function Delete() {
	if(confirm("<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("brugere"))%>")) {
		parent.document.ListRight.document.Checkmailform.DeleteField.value = 'Delete';
		parent.document.ListRight.document.Checkmailform.submit();
	}
}

function Page(ID) {
	var sortCol = '<%=Base.ChkString(Base.Request("SortColumn"))%>';
	if(sortCol != ''){
		sortCol = '&SortColumn=' + sortCol;
	}

    var inActive = '<%=InActive%>';
	if(inActive != ''){
		inActive = '&InActive=' + inActive;
	}	
	
	
	//alert(inActive);
	
	if(ID==1) {
		if(document.getElementById("AllCategoryField")) {
			if(document.getElementById('AllCategoryField').checked) {
				parent.document.getElementById("ListRight").setAttribute("src", "<%=PageType%>.aspx?ID=<%=TypeID%>&SortOrder=<%=SortOrder%>&Position=<%=CStr(NextPostion)%>&SearchStr=<%=Server.URLEncode(SearchStr)%>" + "&AllCategoryField=yes" + sortCol + inActive);
			} else {
				parent.document.getElementById("ListRight").setAttribute("src", "<%=PageType%>.aspx?ID=<%=TypeID%>&SortOrder=<%=SortOrder%>&Position=<%=CStr(NextPostion)%>&SearchStr=<%=Server.URLEncode(SearchStr)%>" + sortCol + inActive);
			}
		} else {
			parent.document.getElementById("ListRight").setAttribute("src", "<%=PageType%>.aspx?ID=<%=TypeID%>&SortOrder=<%=SortOrder%>&Position=<%=CStr(NextPostion)%>&SearchStr=<%=Server.URLEncode(SearchStr)%>" + sortCol + inActive);
		}
	} if(ID==2) {
		if(document.getElementById("AllCategoryField")) {
			if(document.getElementById('AllCategoryField').checked) {
				parent.document.getElementById("ListRight").setAttribute("src", "<%=PageType%>.aspx?ID=<%=TypeID%>&SortOrder=<%=SortOrder%>&Position=<%=CStr(PrevPosition)%>&SearchStr=<%=Server.URLEncode(SearchStr)%>" + "&AllCategoryField=yes" + sortCol + inActive);
			} else {
				parent.document.getElementById("ListRight").setAttribute("src", "<%=PageType%>.aspx?ID=<%=TypeID%>&SortOrder=<%=SortOrder%>&Position=<%=CStr(PrevPosition)%>&SearchStr=<%=Server.URLEncode(SearchStr)%>" + sortCol + inActive);
			}
		} else {
			parent.document.getElementById("ListRight").setAttribute("src", "<%=PageType%>.aspx?ID=<%=TypeID%>&SortOrder=<%=SortOrder%>&Position=<%=CStr(PrevPosition)%>&SearchStr=<%=Server.URLEncode(SearchStr)%>" + sortCol + inActive);
		}
	}
}
function Send()
{
if(document.getElementById("AllCategoryField")) {
	if(document.getElementById('AllCategoryField').checked) {
		parent.document.getElementById("ListRight").setAttribute("src", "<%=PageType%>.aspx?ID=<%=TypeID%>&SearchStr=" + (document.getElementById('SearchForm').SearchField.value) + "&AllCategoryField=yes");
	} else {
		parent.document.getElementById("ListRight").setAttribute("src", "<%=PageType%>.aspx?ID=<%=TypeID%>&SearchStr=" + (document.getElementById('SearchForm').SearchField.value));	
	}
} else {
	parent.document.getElementById("ListRight").setAttribute("src", "<%=PageType%>.aspx?ID=<%=TypeID%>&SearchStr=" + (document.getElementById('SearchForm').SearchField.value));
	}
}

//-->
</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

<HEAD>
</HEAD>

<body bottommargin=0 leftmargin=0 topmargin=0 rightmargin=0 style="background-color:#ECE9D8;margin:0px;">
<form method="post" name="SearchForm" id="SearchForm" action="javascript:Send();">

<table width="100%">
	<tr>
		<td height="3px">
		</td>
	</tr>
	<tr width="100%">
	<td>
		<table>
			<tr>
				<td align="right"><table cellpadding=0 cellspacing=0 height=21 width=60>
			<tr height=4>
				<td width=4 style="BACKGROUND: url(../../images/btnLeftEdgeSmall.gif) no-repeat left top;" rowspan=3></td>
				<td class=btnTop></td>
				<td width=3 style="BACKGROUND: url(../../images/btnRightEdgeSmall.gif) no-repeat left top;" rowspan=3></td>
			</tr>
			<tr onClick="Send();">
				<td style="BACKGROUND: url(../../images/btnFill.gif);	CURSOR: hand;" align=center><%=Translate.Translate("Søg")%></td>
			</tr>
			<tr height=4>
				<td style="BACKGROUND: url(../../images/btnBottomEdge.gif);"></td>
			</tr>
		</table>
	</td>

	<td><img src="../../images/btnBottomEdge.gif" height="1"><input type="text" size="15" style="BACKGROUND-COLOR: #F4F4F4; BORDER-BOTTOM: #666666 solid 1px;    BORDER-LEFT: #666666 solid 1px;    BORDER-RIGHT: #666666 solid 1px;    BORDER-TOP: #666666 solid 1px;    COLOR: #333333;    FONT-FAMILY: Verdana, Helvetica, Arial, Tahoma, Verdana, Arial; FONT-SIZE: 11px; z-index:10; width:130px;" name="SearchField" value=""></td>
	<td>
	<td width="6px">
	</td>
	<td width="100%">
	<%
If PageType = "NewsletterExtended_Recipient" Then
	If NLAllwaysSearchInAllCategories = "1" Then
		%>
		<input style="display: none;" type="Checkbox" ID="Checkbox1" name="AllCategoryField" <%	If AllCategoryField <> "" Then Response.Write("Checked")
		If AllCategoryField <> "" Then Response.Write("Checked")%> value="yes">
		<%		
	Else
		%>
		<input type="Checkbox" ID="AllCategoryField" name="AllCategoryField" <%	If AllCategoryField <> "" Then Response.Write("Checked")
		If AllCategoryField <> "" Then Response.Write("Checked")%> value="yes">	
		<%		
		Response.Write((Translate.Translate("Søg i alle nyhedslister")))
	End If
End If
%>
	</td>
	<td width="100px" valign="middle" align=Right>
	<%
If PageType = "newsletter_recipient_checkemail_list" Then
	Response.Write("<table cellpadding=0 cellspacing=0 height=21 width=100>" & "	<tr height=4>" & "		<td width=4 style=""BACKGROUND: url(../../images/btnLeftEdgeSmall.gif) no-repeat left top;"" rowspan=3></td>" & "		<td class=btnTop></td>" & "		<td width=3 style=""BACKGROUND: url(../../images/btnRightEdgeSmall.gif) no-repeat left top;"" rowspan=3></td>" & "	</tr>" & "	<tr onClick=""Delete();"">" & "		<td style=""BACKGROUND: url(../../images/btnFill.gif);	CURSOR: hand;"" align=center>" & Translate.Translate("Slet %%", "%%", Translate.Translate("valgte")) & "</td>" & "	</tr>" & "	<tr height=4>" & "		<td style=""BACKGROUND: url(../../images/btnBottomEdge.gif);""></td>" & "	</tr>" & "</table>")
Else
	If Position <> "0" Then
		Response.Write("<img src='../../images/Page_Previous.gif' class='H' onclick='Page(2);'>")
	Else
		Response.Write("<img src='../../images/Nothing.gif' width='20'>")
	End If
	
	If Cint(Position) + NLRowNumbers <= Cint(Amount) Then
		Response.Write("<img src='../../images/Page_Next.gif' class='H' onclick='Page(1);'>")
	Else
		Response.Write("<img src='../../images/Nothing.gif' width='20'>")
	End If
End If
%>
	<img src="../../images/Nothing.gif" width="5">
	</td>
	</tr>
</table>
</form>
</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
document.getElementById('SearchForm').SearchField.value = "<%=(SearchStr)%>"
//-->
</SCRIPT>
