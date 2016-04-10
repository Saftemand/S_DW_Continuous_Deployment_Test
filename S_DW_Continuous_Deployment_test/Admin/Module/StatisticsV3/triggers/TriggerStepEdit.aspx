<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TriggerStepEdit.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.TriggerStepEdit"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <title>Ip Edit</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
<LINK href="../StatCss.css" type="text/css" rel="STYLESHEET">
	<script language="javascript">
	function changeType(elm){
		var ind = elm.selectedIndex;
		for (var i=0;i<elm.options.length;i++){
			var obj = document.getElementById('t'+i);
			if (!obj){
				continue;
			}
			if (i==ind){
				obj.style.display = 'block';
			}else{
				obj.style.display = 'none';
			}
		}
	}
	</script>
  </head>
  <body MS_POSITIONING="GridLayout">
    <form id="Form1" method="post" runat="server">
				<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("Pattern")), Translate.translate("Pattern"), "all")%>
				<table border="0" cellpadding="0" cellspacing="0" class="tabTable" style="WIDTH:550px">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">
							<dw:groupboxstart id="StepInfo" title="Summary" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150px">&nbsp;<dw:translatelabel id="TextLabel" runat="server" Text="Type"></dw:translatelabel></td>
									<td width="0,100%"><asp:DropDownList ID="lstType" CssClass="std" Runat="server"></asp:DropDownList></td>
									<td>&nbsp;</td>
								</tr>
								<tr id="t0" runat="server">
									<td width="150">&nbsp;<dw:translatelabel id="PageLabel" runat="server" Text="Side"></dw:translatelabel></td>
									<td><%=Gui.LinkManager(pStep.PageUrl.ToString, "StepPage", "")%></td>
									<td><asp:CustomValidator id="CorrectPageValidator" EnableClientScript="false" ErrorMessage="- Page not choosen" OnServerValidate="CorrectPageValidation" runat="server"/></td>
								</tr>
								<tr id="t1" runat="server">
									<td width="150">&nbsp;<dw:translatelabel id="FileLabel" runat="server" Text="Vælg fil"></dw:translatelabel></td>
									<td><%=Gui.FileManager(pStep.Value, "", "StepFile")%></td>
									<td><asp:CustomValidator id="CorrectFileValidator" EnableClientScript="false" ErrorMessage="- File not choosen" OnServerValidate="CorrectFileValidation" runat="server"/></td>
								</tr>
								<tr id="t2" runat="server">
									<td width="150">&nbsp;<dw:translatelabel id="SearchLabel" runat="server" Text="Tekststreng"></dw:translatelabel></td>
									<td><asp:TextBox ID="txSearch" CssClass="std" Runat="server"></asp:TextBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr id="t3" runat="server">
									<td width="150">&nbsp;<dw:translatelabel id="FormLabel" runat="server" Text="Vælg formular"></dw:translatelabel></td>
									<td><asp:DropDownList ID="lstForms" CssClass="std" Runat="server"></asp:DropDownList></td>
									<td>&nbsp;</td>
								</tr>
								<tr id="t4" runat="server">
									<td width="150">&nbsp;<dw:translatelabel id="NewsLabel" runat="server" Text="Vælg nyhed"></dw:translatelabel></td>
									<td><asp:DropDownList ID="lstNews" CssClass="std" Runat="server"></asp:DropDownList></td>
									<td>&nbsp;</td>
								</tr>
							</table>
							<dw:groupboxend id="StepInfoEnd" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="right" valign="bottom">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td><input type="submit" name="btnSubmit" id="btnSubmit" class="ButtonSubmit" value="<%=Translate.translate("OK")%>"></td>
									<td width="5">&nbsp;</td>
									<td><%=Gui.Button(Translate.translate("Annuller"), "location='TriggersEdit.aspx?TriggerID=" & pStep.TriggerID.ToString &"'", 0)%></td>
									<td width="5">&nbsp;</td>
									<%=Gui.HelpButton("", "modules.statisticsv3.general.toolbar.triggers.edit.pattern.edit")%>
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

  </body>
</html>
<% 
	Translate.GetEditOnlineScript()
%>