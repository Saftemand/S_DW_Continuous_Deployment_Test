<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="ac" TagName="patlist" Src="TriggerStepList.ascx"%>
<%@ Register TagPrefix="ac" TagName="iplist" Src="TriggerIpList.ascx"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TriggersEdit.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.TriggersEdit"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Survey Edit</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<LINK href="../StatCss.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="Survey.js"></script>
		<script language="javascript">
			function Validate()
			{
				if(typeof(Page_ClientValidate) == 'function')
					Page_ClientValidate();
			}
	function changeType(elm){
		var ind = elm.selectedIndex;
		var obj = document.getElementById('showpageelement');
		if (!obj){
			return;
		}
		if (0==ind){
			obj.style.display = 'block';
		}else{
			obj.style.display = 'none';
		}
	}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<div style="OVERFLOW-X: hidden; OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100%">
			<form id="Form1" method="post" runat="server">
				<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("Trigger")), Translate.Translate("Trigger"), "all")%>
				<table border="0" cellpadding="0" cellspacing="0" class="tabTable" style="WIDTH:550px">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">
							<dw:groupboxstart id="TriggerInfo" title="Summary" runat="server"></dw:groupboxstart>
							<table cellspacing="5" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="NameLabel" runat="server" Text="Navn"></dw:translatelabel></td>
									<td><asp:TextBox ID="txName" CssClass="std" Runat="server"></asp:TextBox></td>
									<td><asp:RequiredFieldValidator ID="NameValidator" ControlToValidate="txName" ErrorMessage="- required field" Runat="server"></asp:RequiredFieldValidator>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="TypeLabel" runat="server" Text="Type"></dw:translatelabel></td>
									<td><asp:DropDownList ID="lstType" CssClass="std" Runat="server" AutoPostBack="True"></asp:DropDownList></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="UserLabel" runat="server" Text="Bruger"></dw:translatelabel></td>
									<td><asp:DropDownList ID="lstUser" CssClass="std" Runat="server"></asp:DropDownList></td>
									<td>&nbsp;</td>
								</tr>
								<tr id="showpageelement" runat="server">
									<td width="150">&nbsp;<dw:translatelabel id="NumberLabel" runat="server" Text="Antal sidevisninger"></dw:translatelabel></td>
									<td><asp:TextBox ID="txNumber" CssClass="std" Runat="server"></asp:TextBox></td>
									<td><asp:RequiredFieldValidator ID="NumberValidator" ControlToValidate="txNumber" ErrorMessage="- required field"
											Runat="server" display="dynamic"></asp:RequiredFieldValidator>
										<asp:CompareValidator ID="PageViewValidator" ControlToValidate="txNumber" ValueToCompare="5" Type="integer"
											Operator="GreaterThanEqual" EnableClientScript="true" ErrorMessage="- must be integer equal or greater than 5"
											display="dynamic" Runat="server"></asp:CompareValidator>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
							</table>
							<dw:groupboxend id="TriggerInfoEnd" runat="server"></dw:groupboxend>
							<dw:groupboxstart id="IpSteps" title="IP adresser" runat="server"></dw:groupboxstart>
							<ac:iplist id="IpList" runat="server"></ac:iplist>
							<dw:groupboxend id="IpStepsEnd" title="IP adresser" runat="server"></dw:groupboxend>
							<dw:groupboxstart id="PatSteps" title="Pattern liste" runat="server"></dw:groupboxstart>
							<ac:patlist id="PatList" runat="server"></ac:patlist>
							<dw:groupboxend id="PatStepsEnd" title="Pattern liste" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="right" valign="bottom">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td><input type="submit" name="btnSubmit" id="btnSubmit" class="ButtonSubmit" onclick="Validate(); if (ValidatorOnSubmit()) return true;"
											value="<%=Translate.translate("OK")%>"></td>
									<td width="5">&nbsp;</td>
									<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Triggers_List.aspx'", 0)%></td>
									<td width="5">&nbsp;</td>
									<%=Gui.HelpButton("", "modules.statisticsv3.general.toolbar.triggers.edit")%>
									<td width="10">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="3" height="5"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</HTML>
<% 
	Translate.GetEditOnlineScript()
%>
