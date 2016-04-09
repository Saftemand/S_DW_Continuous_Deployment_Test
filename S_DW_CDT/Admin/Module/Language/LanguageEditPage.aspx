<%@ Page Codebehind="LanguageEditPage.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.LanguageEditPage" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function cc(objRow){ //Change color of row when mouse is over... (ChangeColor)
	objRow.style.backgroundColor='#E1DED8';
}

function ccb(objRow){ //Remove color of row when mouse is out... (ChangeColorBack)
	objRow.style.backgroundColor='';
}

function SetSort(intSortField) {
		if(LanguageEditPage.SortField.value == intSortField) {
			if(LanguageEditPage.SortOrder.value == 'ASC') {	
				LanguageEditPage.SortOrder.value = 'DESC'
			} else {
				LanguageEditPage.SortOrder.value = 'ASC'
			}
			LanguageEditPage.submit();
		}else {
			LanguageEditPage.SortField.value = intSortField
			LanguageEditPage.submit();
		}
	}

function GoToEdit(PagePath, strJavaScript, strTranslated, strWord, intAlt, strKey){
	document.location.href = "LanguageEditWord.aspx?Page=" + PagePath + "&js=" + strJavaScript + "&translated=" + strTranslated + "&word=" + strWord + "&intAlt=" + intAlt + "&key=" + strKey
}
//-->
</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<title><%=Translate.JSTranslate("Terminologi Editor")%></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>
<BODY>
<%= Gui.MakeHeaders(Translate.Translate("%m% - %c%", "%m%", Translate.Translate("Terminologi Editor"), "%c%", PagePath), Translate.Translate("Ord liste"), "all") %>

			<table border="0" cellspacing="0" cellpadding="4" class=tabTable>
				<form method="post" name="LanguageEditPage" action="">
				<tr height=5>
					<td>
					<input type="hidden" id="SortField" Name="SortField" value="<%=SortField%>">
					<input type="hidden" id="SortOrder"  Name="SortOrder" value="<%=SortOrder%>">
					<input type="hidden" id="ResetLang" name="ResetLang" value="">
					</td>
				</tr>
				<tr>
					<td>
						<%=GetWordTable%>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td align="right" valign="bottom">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<!--td align="right"><%=Gui.Button(Translate.Translate("OK"), "checkInput(document.rang);", 0)%></td>
								<td width="5"></td-->
								<td align="right"><%=Gui.Button(Translate.Translate("Luk"), "window.close();", 0)%></td>
								<td width="5"></td>
							</tr>
							<tr>
								<td colspan="4" height="5"></td>
							</tr>			
						</table>
					</td>
				</tr>
				</form>
			</table>
</BODY>
</HTML>
<%
'	Translate.GetEditOnlineScript()
%>