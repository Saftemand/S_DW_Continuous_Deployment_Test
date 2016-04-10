<%@ Page ValidateRequest="false" CodeBehind="Paragraph_SortAll.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Paragraph_SortAll" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim ID As String
Dim PageID As String
Dim intRecordCount As Integer
Dim sql, sqlCount As String


Dim cnDynamic As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
        
PageID = Request.QueryString.Item("PageID")
ID = Request.QueryString.Item("PageID")

' CPK: Fixed SQL to select Header for Global paragraphs too
sql =	" SELECT Paragraph.ParagraphID, Paragraph.ParagraphPageID, Paragraph.ParagraphHeader, Paragraph.ParagraphGlobalID, GlobalTab.ParagraphHeader AS GlobalHeader " & _
		" FROM Paragraph LEFT JOIN Paragraph as GlobalTab ON Paragraph.ParagraphGlobalID = GlobalTab.ParagraphID" & _
		" WHERE Paragraph.ParagraphPageID = " & PageID & _
		" ORDER BY Paragraph.ParagraphSort "

sqlCount =	" SELECT COUNT(Paragraph.ParagraphID) " & _
			" FROM Paragraph " & _
			" WHERE Paragraph.ParagraphPageID = " & PageID
			
Dim myCountCmd As System.Data.IDbCommand = cnDynamic.CreateCommand
myCountCmd.CommandText = sqlCount
intRecordCount = Base.ChkNumber(myCountCmd.ExecuteScalar)

Dim myCmd As System.Data.IDbCommand = cnDynamic.CreateCommand
myCmd.CommandText = sql
Dim dr as System.Data.IDataReader = myCmd.ExecuteReader()

Dim intOpParagraphID as integer = dr.GetOrdinal("ParagraphID")
Dim intOpParagraphHeader as integer = dr.GetOrdinal("ParagraphHeader")
Dim intOpParagraphGlobalID as integer = dr.GetOrdinal("ParagraphGlobalID")
Dim intOpGlobalHeader as integer = dr.GetOrdinal("GlobalHeader")
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
function Send() {
	window.opener.reloac;
	window.close();
}


function ValidateInt(obj) {
	if (!parseInt(obj.value)) {
		obj.value=0;
		alert('<%=Translate.JsTranslate("Angiv heltal")%>');
	}
	else {
		obj.value = parseInt(obj.value);
	}
}

	function checkInput(theForm) {
		document.getElementById('rang').ParagraphSort.multiple = true;
		setTimeout("submitit()", 200);
	}

	function submitit(){
		for (i = 0; i < document.getElementById('rang').ParagraphSort.length; i++) {
			document.getElementById('rang').ParagraphSort.options[i].selected = true;
		}
//		document.getElementById('rang').action = "Menu_sort.aspx";
		document.getElementById('rang').submit();
	}
	
	function MoveUp(){
		ID = document.getElementById('rang').ParagraphSort.selectedIndex
		if(ID > 0) {
			val1 = document.getElementById('rang').ParagraphSort[ID - 1].value;
			val2 = document.getElementById('rang').ParagraphSort[ID - 1].text;
			document.getElementById('rang').ParagraphSort.options[ID - 1] = new Option(document.getElementById('rang').ParagraphSort[ID].text, document.getElementById('rang').ParagraphSort[ID].value);
			document.getElementById('rang').ParagraphSort.options[ID] = new Option(val2, val1);
			document.getElementById('rang').ParagraphSort.options[ID - 1].selected = true;
			ToggleImage(ID - 1);
		}
	}
	
	function MoveDown(){
		ID = document.getElementById('rang').ParagraphSort.selectedIndex
		if(ID + 1 < <%=intRecordCount%>) {
			val1 = document.getElementById('rang').ParagraphSort[ID + 1].value;
			val2 = document.getElementById('rang').ParagraphSort[ID + 1].text;
			document.getElementById('rang').ParagraphSort.options[ID + 1] = new Option(document.getElementById('rang').ParagraphSort[ID].text, document.getElementById('rang').ParagraphSort[ID].value);
			document.getElementById('rang').ParagraphSort.options[ID] = new Option(val2, val1);
			document.getElementById('rang').ParagraphSort.options[ID + 1].selected = true;
			ToggleImage(ID + 1);
		}
	}
	
	function ToggleImage(ID){
		if(ID > -1){
			if(ID == 0){
				document.images["up"].src = "../images/Collapse_inactive.GIF";
				document.images["up"].alt = "";
			}else{
				document.images["up"].src = "../images/Collapse.GIF";
				document.images["up"].alt = "<%=Translate.JsTranslate("Flyt op")%>";
			}
		
			if(ID == document.getElementById('rang').ParagraphSort.length - 1){
				document.images["down"].src = "../images/Expand_inactive.GIF";
				document.images["down"].alt = "";
			}else{
				document.images["down"].src = "../images/Expand_active.GIF";
				document.images["down"].alt = "<%=Translate.JsTranslate("Flyt ned")%>";
			}
		}else{
			document.images["up"].src = "../images/Collapse_inactive.GIF";
			document.images["up"].alt = "";
			document.images["down"].src = "../images/Expand_inactive.GIF";
			document.images["down"].alt = "";
		}
	}

//-->
</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=Translate.JsTranslate("Sorter %%", "%%", Translate.JsTranslate("afsnit"))%></title>
<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css">

<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
<%= Gui.MakeHeaders(Translate.Translate("Sorter %%", "%%",Translate.Translate("afsnit")), Translate.Translate("Sortering"), "all", false, "330") %>

			<table border="0" cellspacing="0" cellpadding="0" class=tabTable style="width:330px;">
				<form method="post" name="rang" id="rang" action="Paragraph_SortAll_Save.aspx">
				<tr height=5>
					<td><input type="hidden" Name="PageID" value="<%=PageID%>"></td>
				</tr>
				<tr>
					<td colspan=2 valign=top >
						<DIV ID=Tab1><br>
						<%=GUI.Groupboxstart(Translate.Translate("Afsnit"))%>
						<table>
							<tr>
								<td>&nbsp;
									<select size=<%=intRecordCount+1%> name=ParagraphSort onChange="ToggleImage(this.selectedIndex);" class=std>
										<%
										Dim strHeader as string
										Do While dr.Read
										  if Base.ChkNumber(dr(intOpParagraphGlobalID)) <> 0 then
										     strHeader = Base.ChkString(dr(intOpGlobalHeader))
										  else 	
										    strHeader = Base.ChkString(dr(intOpParagraphHeader))
										  end if
										%>
										  <option value="<%=dr(intOpParagraphID).ToString%>"><%=Left(strHeader, 100)%></option>
										<%	
										Loop 
										
										dr.Close
										dr.Dispose
										myCmd.dispose
										cnDynamic.close
										cnDynamic.dispose
										
										%>
									</select>
								</td>
								<td>
								<a href="JavaScript:void(0);" onmousedown="MoveUp();"><img src="../images/Collapse.GIF" width="16" height="16" alt="" border="0" name="up"></a>
								<br>
								<a href="JavaScript:void(0);" onmousedown="MoveDown();"><img src="../images/Expand_active.GIF" width="16" height="16" alt="" border="0" name="down"></a>
								</td>
							</tr>
						</table>
						<%=GUI.GroupboxEnd%>
						</DIV>
					</td>
				</tr>
				<tr>
					<td align="right" valign="bottom">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td align="right"><%= Gui.Button(Translate.Translate("OK"), "checkInput(document.getElementById('rang'));", 0)%></td>
								<td width="5"></td>
								<td align="right"><%= Gui.Button(Translate.Translate("Annuller"), "javascript: history.go(-1)", 0)%></td>
								<%=Gui.HelpButton("paragraph_edit", "page.paragraph.sort",,5)%>
								<td width="5"></td>
							</tr>
							<tr>
								<td colspan="4" height="5"></td>
							</tr>			
						</table>
					</td>
				</tr>
			</table>
		<FORM>
</BODY>
</HTML>
<script language="JavaScript">
	document.getElementById('rang').ParagraphSort.selectedIndex = 0;
	ToggleImage(0);
</script>
<%
Translate.GetEditOnlineScript()
%>
