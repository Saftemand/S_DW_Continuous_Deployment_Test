<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%
    Dim ParagraphID As Object
    Dim ButtonText As Object
    Dim sql As String

    If Request("ID") <> "" Then
        ParagraphID = Base.ChkNumber(Request("ID"))
    ElseIf Request("ParagraphID") <> "" Then
        ParagraphID = Base.ChkNumber(Request("ParagraphID"))
    Else
        ParagraphID = 0
    End If

    Dim prop As New Properties

    If Base.ChkString(Request.QueryString("ParagraphModuleSystemName")) = "" Then 'ParagraphID > 0 Then
        prop = Base.GetParagraphModuleSettings(ParagraphID, True)
    Else
        prop.Value("CartShowNext") = "1"
        prop.Value("CartShowNextText") = Translate.Translate("Videre...")
        prop.Value("CartShowTemplate") = "CartList.html"
        prop.Value("CartShowTemplateItem") = "CartListPart.html"
        prop.Value("CartOrderTemplate") = "CartOrderForm.html"
        prop.Value("CartOrderConfirmTemplate") = "CartOrderConfirmMail.html"
        prop.Value("CartOrderMailTemplate") = "CartOrderMail.html"
    End If

%>

<SCRIPT language="javascript">
<!--
	function SwapVisible(vis, skjul) {
		document.all[vis].style.display = '';
		document.all[skjul].style.display = 'none';
	}
//-->
</SCRIPT>

<input type="Hidden" name="CartV2_settings" value="CartOrderSubject, CartOrderConfirmSubject, CartOrderMailTemplate, CartOrderRecipient, CartOrderRecipientCC, CartOrderFromName, CartOrderFromMail, CartOrderConfirmFromName, CartOrderConfirmFromMail, CartOrderConfirmTemplate, CartOrderConfirmPage, CartOrderCancelPage, CartOrderTemplate, CartOrder, CartOrderPicture, CartOrderText, CartShowTemplate, CartShowAlternativeTemplate, CartShowTemplateItem, CartEmptyBasketPage, CartShowNext, CartShowNextPicture, CartShowNextText, CartShowReceipt, CartShowReceiptTemplate, CartMailEncoding">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("cartv2", "Indkøbskurv")%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupboxStart(Translate.Translate("Indstillinger"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width="170" valign=top><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Videre") & "</em>" )%></td>
				<td valign=top><%=Gui.ButtonText("CartShowNext", prop.Value("CartShowNext"), prop.Value("CartShowNextPicture"), prop.Value("CartShowNextText"))%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template")%></td>
				<td><%=Gui.FileManager(prop.Value("CartShowTemplate"), "Templates/Shop", "CartShowTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("1. side alternativ"))%></td>
				<td><%=Gui.FileManager(prop.Value("CartShowAlternativeTemplate"), "Templates/Shop", "CartShowAlternativeTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Varelinie"))%></td>
				<td><%=Gui.FileManager(prop.Value("CartShowTemplateItem"), "Templates/Shop", "CartShowTemplateItem")%></td>
			</tr>
			<tr>
				<td valign="top"><%=Translate.Translate("Side ved tom indkøbskurv")%>&nbsp;&nbsp;</td>
				<td <%=Gui.LinkManager(prop.Value("CartEmptyBasketPage"), "CartEmptyBasketPage", "")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupboxStart(Translate.Translate("Ordreindstillinger"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Indtastning"))%></td>
				<td><%=Gui.FileManager(prop.Value("CartOrderTemplate"), "Templates/Shop", "CartOrderTemplate")%></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Afgiv ordre")%></td>
				<td valign=top><%=Gui.ButtonText("CartOrder", prop.Value("CartOrder"), prop.Value("CartOrderPicture"), prop.Value("CartOrderText"))%></td>
			</tr>
			<TR>
				<TD width="170"><LABEL for="CartPageAfterType"><%=Translate.Translate("Efter betaling") %></LABEL></TD>
				<TD><INPUT type="radio" class="clean" <%=Base.IIf(prop.Value("CartShowReceipt")<>"2","checked","") %> OnClick="javascript:SwapVisible('CartPageAfterReceipt', 'CartPageAfterPage');" name="CartShowReceipt" id="radio" value="1"> <%=Translate.Translate("Statisk side") %> 
				<INPUT type="radio" class="clean" <%=Base.IIf(prop.Value("CartShowReceipt")="2","checked","") %> OnClick="javascript:SwapVisible('CartPageAfterPage', 'CartPageAfterReceipt');" name="CartShowReceipt" id="radio" value="2" <%=Base.iif(prop.Value("CartShowReceipt")="2","checked","")%>> <%=Translate.Translate("Kvittering")%></TD>
			</TR>
			<TR id="CartPageAfterReceipt" style="display:<%=Base.IIf(prop.Value("CartShowReceipt")<>"2","","none") %>;">
				<TD width="170"><%=Translate.Translate("Kvitteringsside") %></TD>
				<TD><%=Gui.LinkManager(prop.Value("CartOrderConfirmPage"), "CartOrderConfirmPage", "")%></TD>
			</TR>
			<TR id="CartPageAfterPage" style="display:<%=Base.IIf(prop.Value("CartShowReceipt")="2","","none") %>;">
				<TD width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Kvittering")) %></TD>
				<TD><%=Gui.FileManager(prop.Value("CartShowReceiptTemplate"), "Templates/Shop", "CartShowReceiptTemplate")%></TD>
			</TR>
			<tr>
				<td valign="top"><%=Translate.Translate("Side ved afbrydelse")%>&nbsp;&nbsp;</td>
				<td><%=Gui.LinkManager(prop.Value("CartOrderCancelPage"), "CartOrderCancelPage", "")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupboxStart(Translate.Translate("Ordrebekræftelse"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("E-mail"))%></td>
				<td><%=Gui.FileManager(prop.Value("CartOrderConfirmTemplate"), "Templates/Shop", "CartOrderConfirmTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Afsender e-mail")%></td>
				<td><input type="Text" name="CartOrderConfirmFromMail" value="<%=prop.Value("CartOrderConfirmFromMail")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Afsender navn")%></td>
				<td><input type="Text" name="CartOrderConfirmFromName" value="<%=prop.Value("CartOrderConfirmFromName")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Emne")%></td>
				<td><input type="Text" name="CartOrderConfirmSubject" value="<%=prop.Value("CartOrderConfirmSubject")%>" maxlength="255" class="std"></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupboxStart(Translate.Translate("Ordre e-mail"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("E-mail"))%></td>
				<td><%=Gui.FileManager(prop.Value("CartOrderMailTemplate"), "Templates/Shop", "CartOrderMailTemplate")%></td>
			</tr>
				<td><%=Translate.Translate("Afsender e-mail")%></td>
				<td><input type="Text" name="CartOrderFromMail" value="<%=prop.Value("CartOrderFromMail")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Afsender navn")%></td>
				<td><input type="Text" name="CartOrderFromName" value="<%=prop.Value("CartOrderFromName")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Emne")%></td>
				<td><input type="Text" name="CartOrderSubject" value="<%=prop.Value("CartOrderSubject")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Modtager")%></td>
				<td><input type="Text" name="CartOrderRecipient" value="<%=prop.Value("CartOrderRecipient")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Modtager CC")%></td>
				<td><input type="Text" name="CartOrderRecipientCC" value="<%=prop.Value("CartOrderRecipientCC")%>" maxlength="255" class="std"></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>
<%If Base.HasVersion("18.3.1.0") Then%>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("E-Mail Encoding"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td width=170><%=Translate.Translate("Encoding")%></td>
				<td><%=Gui.EncodingList(prop.Value("CartMailEncoding"), "CartMailEncoding", True, "ms_access", true) %></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<%End If%>

<%
 Translate.GetEditOnlineScript()
%>
