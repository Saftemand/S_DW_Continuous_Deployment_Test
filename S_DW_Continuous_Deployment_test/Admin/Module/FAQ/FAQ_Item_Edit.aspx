<%@ Page CodeBehind="FAQ_Item_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.FAQ_Item_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim FAQItemDate As String
Dim FAQItemASenderMail As String
Dim FAQItemActive As String
Dim FAQItemQSenderName As String
Dim FAQItemID As String
Dim FAQItemCategoryID As Integer
Dim FAQID As String
Dim FAQItemASenderName As String
Dim FAQItemAText As String
Dim FAQItemQSenderMail As String
Dim FAQItemWorkflowID As Integer
Dim FAQItemValidTo As String
Dim FAQItemSort As Integer
Dim FAQItemWorkflowState As String
Dim FAQItemValidFrom As String
Dim FAQItemQHeader As String
Dim FAQItemQText As String
Dim FAQItemAHeader As String

Dim dato as New Dates
Dim strHeaders As String
Dim StrSQLTop As String
Dim LinkToArchive As String
Dim NewsVersionComment As String
Dim CategoryID As String

Dim FAQItemApprovalState As Integer 
Dim FAQItemApprovalType As Integer


CategoryID = Request.QueryString.Item("CategoryID")
FAQItemID = Request.QueryString.Item("FAQID")
FAQID = Request.QueryString.Item("FAQID")

Dim cnFaqItem		As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdFaqItem		As IDbCommand		= cnFaqItem.CreateCommand

If Not FAQID = "" Then

	Dim strSql as string = "SELECT * FROM FAQItem WHERE FAQItemID = " & FAQID
	Dim drFAQItem		as IDataReader


	cmdFaqItem.CommandText = strSql
	drFaqItem = cmdFaqItem.ExecuteReader()
	drFaqItem.Read()
	
	FAQItemCategoryID		= drFaqItem("FAQItemCategoryID").ToString()
	FAQItemSort				= drFaqItem("FAQItemCategoryID").ToString()
	FAQItemActive			= Base.ChkChecked(drFaqItem("FAQItemActive"))
	FAQItemDate				= drFaqItem("FAQItemDate").ToString()
	FAQItemQSenderName		= Server.HtmlEncode(drFaqItem("FAQItemQSenderName").ToString())
	FAQItemQSenderMail		= drFaqItem("FAQItemQSenderMail").ToString()
	FAQItemQHeader			= Server.HtmlEncode(drFaqItem("FAQItemQHeader").ToString())
	FAQItemQText			= drFaqItem("FAQItemQText").ToString()
	FAQItemASenderName		= Server.HtmlEncode(drFaqItem("FAQItemASenderName").ToString())
	FAQItemASenderMail		= drFaqItem("FAQItemASenderMail").ToString()
	FAQItemAHeader			= Server.HtmlEncode(drFaqItem("FAQItemAHeader").ToString())
	FAQItemAText			= drFaqItem("FAQItemAText").ToString()

	FAQItemValidFrom		= drFaqItem("FAQItemValidFrom").ToString()
	FAQItemValidTo			= drFaqItem("FAQItemValidTo").ToString()
	
	FAQItemApprovalState = Base.chkNumber(drFAQItem("FAQItemApprovalState"))
	FAQItemApprovalType = Base.chkNumber(drFAQItem("FAQItemApprovalType"))
	If FAQItemApprovalType > 0 AND FAQItemApprovalState = 0 Then
		FAQItemApprovalState = -1
	End If 
	
	drFaqItem.Close()
Else
	FAQItemValidFrom		= dato.DWNow()
	FAQItemValidTo			= ""

	FAQItemActive			= Base.ChkChecked(0)
	FAQItemDate				= Date.Now
	FAQItemValidFrom		= Date.Now
	FAQItemValidTo			= "2999-12-31 23:59"
	
	FAQItemApprovalState = -100
	

'	cmdFaqItem.CommandText	= "SELECT FAQCategoryWorkflowID FROM FAQCategory WHERE FAQCategoryID = " & CategoryID
'	Dim drFaqItem As IDataReader = cmdFaqItem.ExecuteReader()
	
'	If drFaqItem.Read() Then
'		FAQItemWorkflowID = drFaqItem("FAQCategoryWorkflowID")
'	End If
	
'	drFaqItem.Dispose()
End If

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<script>
function show(i) {
	hideEditor();
	if (document.all[i].style.display=='none') {
		document.all[i].style.display='';
	}
	else{
		document.all[i].style.display='none';
	}
}
	
	function validateForm() {
		var objTarget = document.getElementById('FAQForm');
		if (objTarget.FAQItemQHeader.value.length<1) {
			alert('<%=Translate.JsTranslate("Indtast venligst en overskrift til spørgsmålet")%>');
			objTarget.FAQItemQHeader.focus();
			return false;
		}
		else if (objTarget.FAQItemQHeader.value.length > 100) {
			alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","100")%><%=Translate.JSTranslate("Overskrift")%>");
			objTarget.FAQItemQHeader.focus();
			return false;
		} 
		else {
			objTarget.submit()
			return true;
		}
	}
</script>
<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<style>
.Settings{
	top:120px;
}
</style>

<%
strHeaders = Translate.Translate("Indlæg")
'IF Base.IsModuleInstalled("Versioncontrol", false) OR Base.IsModuleInstalled("Workflow", false)  Then'
'	strHeaders = strHeaders & ", " & Translate.Translate("Version og godkendelse") 
'End If
Response.Write(Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%", "%m%",Translate.Translate("FAQ",9),"%c%",Translate.Translate("indlæg")), strHeaders, "all"))
%>
<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
	<form action="FAQ_Item_Save.aspx<%=Base.IIf(FAQID <> "", "?version=" & FAQID, "")%>" method="post" name="FAQForm" id="FAQForm">
	<input type="hidden" name="CategoryID" value="<%=CategoryID%>">
	<input type="hidden" name="FAQID" value="<%=FAQID%>">
	<tr>
		<td valign="top">
			<DIV id="Tab1" Class="Display:;">
				<BR>
				<table border="0" cellpadding="2" cellspacing="0" width="100%">
					<tr>
						<td colspan=2>
							<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width=170><%=Translate.Translate("Dato")%></td>
									<td><%=dato.DateSelect(FAQItemDate, False, False, False, "FAQItemDate")%></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Aktiv")%></td>
									<td><input type="checkbox" name="FAQItemActive" <%=FAQItemActive%>  class="clean"></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
							<%=Gui.GroupBoxStart(Translate.Translate("Publicering"))%>
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="170"><%=Translate.Translate("Gyldig fra")%></td>
									<td><%=dato.DateSelect(FAQItemValidFrom, True, False, True, "FAQItemValidFrom")%></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Gyldig til")%></td>
									<td><%=dato.DateSelect(FAQItemValidTo, True, True, True, "FAQItemValidTo")%></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<%=Gui.GroupBoxStart(Translate.Translate("Spørgsmål"))%>
							<table cellpadding=0 cellspacing=0>
								<tr>
									<td width=170><%=Translate.Translate("Navn")%></td>	
									<td><input type="text" name="FAQItemQSenderName" value="<%=FAQItemQSenderName%>" maxlength="255" class="std"></td>
								</tr>
								<tr>
									<td width=170><%=Translate.Translate("E-mail")%></td>	
									<td><input type="text" name="FAQItemQSenderMail" value="<%=Server.HtmlEncode(FAQItemQSenderMail)%>" maxlength="255" class="std"></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Overskrift")%></td>	
									<td><input type="text" name="FAQItemQHeader" value="<%=FAQItemQHeader%>" maxlength="255" class="std"></td>
								</tr>
								<tr>
									<td width="170" valign="top"><%=Translate.Translate("Tekst")%></td>	
									<td><textarea name="FAQItemQText" class="std" rows=5><%=FAQItemQText%></textarea></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<%=Gui.GroupBoxStart(Translate.Translate("Svar"))%>
							<table cellpadding=0 cellspacing=0>
								<tr>
									<td width=170><%=Translate.Translate("Navn")%></td>	
									<td><input type="text" name="FAQItemASenderName" value="<%=FAQItemASenderName%>" maxlength="255" class="std"></td>
								</tr>
								<tr>
									<td width=170><%=Translate.Translate("E-mail")%></td>	
									<td><input type="text" name="FAQItemASenderMail" value="<%=Server.HtmlEncode(FAQItemASenderMail)%>" maxlength="255" class="std"></td>
								</tr>
								<tr>
									<td width=170><%=Translate.Translate("Overskrift")%></td>	
									<td><input type="text" name="FAQItemAHeader" value="<%=FAQItemAHeader%>" maxlength="255" class="std"></td>
								</tr>
							</table>
							<table cellpadding=0 cellspacing=0 width="100%">
								<tr>
									<td colspan="2"><br><strong><%=Translate.Translate("Tekst")%></strong></td>
								</tr>
								<tr>
									<td colspan="2"><%=Gui.Editor("FAQItemAText", 567, 200, FAQItemAText)%></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
						</td>
					</tr>
				</table>
			</DIV>
		</td>
	</tr>
	<tr>
		<td align="right">
			<table>
				<tr>
					<td><%=Gui.Button(Translate.Translate("OK"), "html();validateForm();", 0)%></td>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "location='FAQ_Item_List.aspx?categoryID=" & CategoryID & LinkToArchive & "'", 0)%></td>
					<%=Gui.HelpButton("faq_qcreate", "modules.faq.general.list.item.edit")%>
					<td width=1></td>
				</tr>
			</table>
		</td>
	</tr>
	</form>
</table>	
</body>
</html>
<%

'Cleanup
cmdFaqItem.Dispose()
cnFaqItem.Close()
cnFaqItem.Dispose()

%>

<%=Gui.SelectTab()%>

<%
Translate.GetEditOnlineScript()
%>