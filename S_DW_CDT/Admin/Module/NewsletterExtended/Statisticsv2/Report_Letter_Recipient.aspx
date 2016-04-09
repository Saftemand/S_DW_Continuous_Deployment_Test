<%@ Page CodeBehind="Report_Letter_Recipient.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Report_Letter_Recipient" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%

Dim RecipientID As String = CStr(Request.Item("RecipientID"))
Dim strSqlRecipientLetters As String =  "SELECT NewsletterExtendedCategory.NewsletterCategoryID, NewsletterExtendedCategory.NewsletterCategoryName, NewsletterExtendedRecipient.NewsletterRecipientID FROM (NewsletterExtendedCategoryRecipient INNER JOIN NewsletterExtendedRecipient ON NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientRecipientID = NewsletterExtendedRecipient.NewsletterRecipientID) INNER JOIN NewsletterExtendedCategory ON NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientCategoryID = NewsletterExtendedCategory.NewsletterCategoryID WHERE (((NewsletterExtendedRecipient.NewsletterRecipientID)=" & RecipientID & "));"
Dim cnStatistics As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdStatistics As IDbCommand = cnStatistics.CreateCommand

%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function hide(strDiv)
{
	document.getElementById(strDiv + "open").style.display= 'none'
	document.getElementById(strDiv + "close").style.display= 'block'
	document.getElementById(strDiv + "open").outerHTML = document.getElementById(strDiv + "open").outerHTML
	document.getElementById(strDiv + "close").outerHTML = document.getElementById(strDiv + "close").outerHTML

}

function unhide(strDiv)
{
	document.getElementById(strDiv + "open").style.display= 'block'
	document.getElementById(strDiv + "close").style.display= 'none'
	document.getElementById(strDiv + "open").outerHTML = document.getElementById(strDiv + "open").outerHTML
	document.getElementById(strDiv + "close").outerHTML = document.getElementById(strDiv + "close").outerHTML

}
//-->
</SCRIPT>

<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
<style type="text/css">
.barBG {
	height:18px;
	width:240px;
	font-family:verdana;
	font-size:10px;
	background-color:#d1d1d1;
}

.bar {
	height:100%;
	filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#0000dd', EndColorStr='#000066');
}
</style>

<!-- Stats Begin ------------------------------------------------------------------------------------------------------------------------------- -->

<!-- Make Space -->
<tr><td><br></td></tr>
			
<table width=612 border="0">
	<tr>
		<td valign=top rowspan=4><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Modtager Info")%></strong></td>
		<td align=right style="width:75px;"></td>
	</tr>
	<tr>
		<td style="background-color:#CCCCCC;height:1px;width:100%" colspan=2></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td colspan=2>
			<%=GetStandardInfo(RecipientID)%>
		</td>		
	</tr>
</table>

<!-- Make Space -->
<tr><td><br></td></tr>
					
<table width=612 border="0">
	<tr>
		<td valign=top rowspan=4><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Tilmeldte nyhedsbreve")%></strong></td>
		<td align=right style="width:75px;"></td>
	</tr>
	<tr>
		<td style="background-color:#CCCCCC;height:1px;width:100%" colspan=2></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td colspan=2>
			<%=GetCategories(RecipientID)%>
		</td>		
	</tr>
</table>

<!-- Make Space -->
<tr><td><br></td></tr>

<table width=612 border="0">
	<tr>
		<td valign=top rowspan=4><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Tilsendte Nyhedsbreve")%></strong></td>
		<td align=right style="width:75px;"></td>
	</tr>
	<tr>
		<td style="background-color:#CCCCCC;height:1px;width:100%" colspan=2></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td colspan=2>
			<%=GetLettersSendToRecipient(RecipientID)%>
		</td>		
	</tr>
</table>

<!-- Make Space -->
<tr><td><br></td></tr>

<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>