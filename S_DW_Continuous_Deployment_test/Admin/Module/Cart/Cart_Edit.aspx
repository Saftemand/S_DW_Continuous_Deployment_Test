<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim sql As String
Dim ParagraphID As Integer
Dim ButtonText As String

If Request("ID") <> "" Then
	ParagraphID = Base.Chknumber(request("ID"))
Elseif Request("ParagraphID") <> "" Then
	ParagraphID = Base.Chknumber(request("ParagraphID"))
Else
	ParagraphID = 0
End If



Dim prop As new Properties

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

<input type="Hidden" name="Cart_settings" value="CartOrderConfirmSubject, CartOrderMailTemplate, CartOrderRecipient, CartOrderRecipientCC, CartOrderFromName, CartOrderFromMail, CartOrderConfirmTemplate, CartOrderConfirmPage, CartOrderTemplate, CartOrder, CartOrderPicture, CartOrderText, CartShowTemplate, CartShowTemplateItem, CartEmptyBasketPage, CartShowNext, CartShowNextPicture, CartShowNextText">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("cart", "Indkøbskurv")%>
		<%=Gui.GroupBoxStart(Translate.Translate("Warning"))%>
		<img src="/Admin/Images/Icons/Alert.gif" alt="" align="left">
		This is an incompatible version of the cart module - it should be upgraded to the latest version. Contact support at Dynamic Systems A/S for help on this issue, support@dynamicsystems.dk.
		<%=Gui.GroupBoxEnd()%>
	</TD>
</TR>
<tr>
	<td>
		<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
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
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Varelinie"))%></td>
				<td><%=Gui.FileManager(prop.Value("CartShowTemplateItem"), "Templates/Shop", "CartShowTemplateItem")%></td>
			</tr>
			<tr>
				<td valign="top"><%=Translate.Translate("Side ved tom indkøbskurv")%>&nbsp;&nbsp;</td>
				<td><%=Gui.LinkManager(prop.Value("CartEmptyBasketPage"), "CartEmptyBasketPage", "")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupBoxStart(Translate.Translate("Ordreindstillinger"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Indtastning"))%></td>
				<td><%=Gui.FileManager(prop.Value("CartOrderTemplate"), "Templates/Shop", "CartOrderTemplate")%></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Afgiv ordre")%></td>
				<td valign=top><%=Gui.ButtonText("CartOrder", prop.Value("CartOrder"), prop.Value("CartOrderPicture"), prop.Value("CartOrderText"))%></td>
			</tr>
			<tr>
				<td valign="top"><%=Translate.Translate("Side efter indsendelse")%>&nbsp;&nbsp;</td>
				<td><%=Gui.LinkManager(prop.Value("CartOrderConfirmPage"), "CartOrderConfirmPage", "")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupBoxStart(Translate.Translate("Ordrebekræftelse"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("E-mail"))%></td>
				<td><%=Gui.FileManager(prop.Value("CartOrderConfirmTemplate"), "Templates/Shop", "CartOrderConfirmTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Afsender e-mail")%></td>
				<td><input type="Text" name="CartOrderFromMail" value="<%=prop.Value("CartOrderFromMail")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Afsender navn")%></td>
				<td><input type="Text" name="CartOrderFromName" value="<%=prop.Value("CartOrderFromName")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Emne")%></td>
				<td><input type="Text" name="CartOrderConfirmSubject" value="<%=prop.Value("CartOrderConfirmSubject")%>" maxlength="255" class="std"></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupBoxStart(Translate.Translate("Ordre e-mail"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("E-mail"))%></td>
				<td><%=Gui.FileManager(prop.Value("CartOrderMailTemplate"), "Templates/Shop", "CartOrderMailTemplate")%></td>
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
	</td>
</tr>

<%
'Translate.GetEditOnlineScript()
%>
