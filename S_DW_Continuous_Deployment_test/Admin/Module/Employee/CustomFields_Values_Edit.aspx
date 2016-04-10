<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CustomFields_Values_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Employee.CustomFields_Values_Edit" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script runat="server">
			Sub ServerValidate (sender As Object, _
					value As ServerValidateEventArgs)
				If Not ValueTypeIsValid(_txValue.Text) Then
					_cusvalidator.ErrorMessage = "<b>ERROR:</b> the specified value is invalid: type mismatch."
					value.IsValid = False
				Else
					If Not IsValidInput Then
						_cusvalidator.ErrorMessage = "<b>ERROR:</b> the specified value is already exits. Please type another."
						value.IsValid = False
					End If	
				End If
			End sub
			
			Sub ValidateCaptionValue(ByVal sender As Object, _
					ByVal value As ServerValidateEventArgs)
				If _txCaption.Text.Length = 0 Then
					value.IsValid = False
				End If
			End Sub
			
		</script>
		<script language="javascript">
			var cap_changed = false;
			
			function ValueChanged()
			{
				var cap = document.getElementById('_txCaption');
				var val = document.getElementById('_txValue');
				
				if(!cap_changed)
					cap.value = val.value;	
			}
			function CaptionChanged()
			{
				cap_changed = true;
			}
		</script>
	</HEAD>
	<body>
		<%=Gui.MakeHeaders(Translate.Translate("Dropdown list items for """) & _fSysname & """", Translate.Translate("Edit"), "all")%>
		<table border="0" cellpadding="2" cellspacing="0" width="598" class="tabTable">
			<div id="Tab1" style="DISPLAY:"/>
			<form method="post" runat="server" ID="Form1">
				<TBODY>
					<tr valign="top">
						<td colspan="2">
							<%=Gui.GroupBoxStart(Translate.Translate("General"))%>
							<table border="0" cellpadding="5" cellspacing="0">
								<TBODY>
									<tr>
										<td width="120"><%=Translate.Translate("Value")%></td>
										<input type="hidden" name="_loaded_Key" value="<%=_loaded_Key%>">
										<td><asp:TextBox ID="_txValue" CssClass="std" MaxLength="50" Runat="server"></asp:TextBox></td>
										<td><asp:RequiredFieldValidator ID="_ValueValidator" Runat="server" ErrorMessage="- Required field" ControlToValidate="_txValue"></asp:RequiredFieldValidator>
										</td>
									</tr>
									<tr>
										<td width="120"><%=Translate.Translate("Caption")%></td>
										<td><asp:TextBox ID="_txCaption" CssClass="std" MaxLength="50" Runat="server"></asp:TextBox></td>
										<td><asp:RequiredFieldValidator ID="_CaptionValidator" Runat="server" ErrorMessage="- Required field" ControlToValidate="_txCaption"></asp:RequiredFieldValidator>
										</td>
									</tr>
					</tr>
				</TBODY>
		</table>
		<%=Gui.GroupBoxEnd()%>
		</TD></TR>
		<tr valign="bottom">
			<td vAlign="bottom" align="left" width="70%"><asp:customvalidator OnServerValidate="ServerValidate" id="_cusValidator" Runat="server" Display="Static"
					ErrorMessage="<b>ERROR:</b> the specified value is already exits. Please type another." ControlToValidate="_txValue"></asp:customvalidator></td>
			<td valign="bottom" align="right">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td align="right"><asp:Button ID="_btnSubmit" CausesValidation="True" CssClass="buttonSubmit" Text="OK" Runat="server"></asp:Button></td>
						<td width="5"></td>
						<td align="right"><%=Gui.Button("Cancel", "history.go(-1);", 0)%></td>
						<td width="10"></td>
					</tr>
					<tr>
						<td colspan="2" height="5"></td>
					</tr>
				</table>
			</td>
		</tr>
		</FORM></TBODY></TABLE>
	</body>
</HTML>
<%Translate.GetEditOnlineScript()%>
