<%@ Register TagPrefix="uc1" TagName="ClassMethodSelector" Src="ClassMethodSelector.ascx" %>
<%@ Page validateRequest="false" Language="vb" AutoEventWireup="false" Codebehind="TaskEdit.aspx.vb" Inherits="Dynamicweb.Admin.ScheduledTask_cpl.TaskEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Scheduled Task Edit</title>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript">
		function ConfirmDelete(elm)
		{
			return confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JsTranslate("task"))%>\n(' +  elm.ClientCommandArgument + ')');
		}
		function OnClick()
		{
			var dwpage = document.getElementById("DwPageRow");
			var dwfile = document.getElementById("DwFileRow");
			var url = document.getElementById("UrlRow");
			var cmethod = document.getElementById("ClassMethodRow");
			var dbintegrationjob = document.getElementById("DBIntegrationJobRow");
			
			SetVisible(dwpage, IsPageType());
			SetVisible(dwfile, IsFileType());
			SetVisible(url, IsUrlType());
			SetVisible(cmethod, IsMethodType());
			SetVisible(dbintegrationjob, IsDBIntegrationJobType());
						
			SetMethodValidation();
		}
		
		function IsPageType()
		{
			return document.getElementById("TargetType_0").checked;
		}
		function IsFileType()
		{
			return document.getElementById("TargetType_1").checked;
		}
		function IsUrlType()
		{
			return document.getElementById("TargetType_2").checked;
		}
		function IsMethodType()
		{
			return document.getElementById("TargetType_3").checked;
		}
		function IsDBIntegrationJobType()
		{
		    
			return document.getElementById("TargetType_4").checked;
		}

		
		function SetMethodValidation()
		{
			__classMethodValidationEnabled = IsMethodType();		
		}
		
		function SetVisible(elm, bVisible)
		{
			elm.style.display = bVisible ? "" : "none";
		}

		function OnChangeDay()
		{
			document.getElementById("Wdays").selectedIndex = 0;
		}
		
		function OnChangeWday()
		{
			document.getElementById("Days").selectedIndex = 0;
		}
		function OnChangeDBIntegrationJob()
		{
		    
			document.getElementById("DBIntegrationJob").selectedIndex = 0;
		}


		function ValidateUrl(source, arguments)
		{
			arguments.IsValid = !IsUrlType() || document.getElementById("Url").value.length > 0;
		}
        function ValidateDBIntegrationJob(source, arguments)
		{
			arguments.IsValid =  !IsDBIntegrationJobType() || document.getElementById("DBIntegrationJob").value  > -1;
	    }
		function ValidatePage(source, arguments)
		{
			arguments.IsValid = !IsPageType() || document.getElementById("DwPage").value.length > 0;
		}
		function ValidateFile(source, arguments)
		{
			arguments.IsValid = !IsFileType() || document.getElementById("DwFile").value.length > 0;
		}
								
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" onload="SetMethodValidation();">
		<form id="theForm" method="post" runat="server">
			<dw:tabheader id="EditTab" runat="server" ToolTip="Task" Headers="Task"></dw:tabheader>
			<table class="tabTable" cellSpacing="0" cellPadding="0" width="598" border="0">
				<TR>
					<td vAlign="top"><br>
						<dw:groupboxstart id="SettingsStart" title="Indstillinger" runat="server"></dw:groupboxstart>
						<table cellSpacing="1" cellPadding="1" width="100%" border="0">
							<tr>
								<td width="150"><dw:translatelabel id="NameLabel" runat="server" Text="Navn"></dw:translatelabel></td>
								<td width="300"><asp:textbox id="Name" MaxLength="255" runat="server" CssClass="std"></asp:textbox></td>
								<td align="left"><asp:requiredfieldvalidator id="NameValidator" runat="server" ControlToValidate="Name" ErrorMessage="Enter task name"></asp:requiredfieldvalidator></td>
							</tr>
							<tr>
								<td><dw:translatelabel id="BeginLabel" runat="server" Text="Start dato"></dw:translatelabel></td>
								<td colSpan="2">
									<%=Dates.DateSelect(_begin, True, False, False, "Begin")%>
								</td>
							</tr>
							<tr>
								<td><dw:translatelabel id="EndLabel" runat="server" Text="Slut dato"></dw:translatelabel></td>
								<td colSpan="2">
									<%=Dates.DateSelect(_end, True, True, True, "End")%>
								</td>
							</tr>
							<tr>
								<td><dw:translatelabel id="ActiveLabel" runat="server" Text="Aktiv"></dw:translatelabel></td>
								<td colSpan="2">
									<asp:CheckBox id="Active" runat="server"></asp:CheckBox>
								</td>
							</tr>
						</table>
						<dw:groupboxend id="SettingsEnd" runat="server"></dw:groupboxend></td>
				</TR>
				<TR>
					<td vAlign="top"><br>
						<dw:groupboxstart id="TargetStart" title="Objekt" runat="server"></dw:groupboxstart>
						<table cellSpacing="1" cellPadding="1" width="100%" border="0">
							<tr>
								<td width="150" valign="top"><dw:translatelabel id="TypeLabel" runat="server" Text="Type"></dw:translatelabel></td>
								<td><asp:RadioButtonList id="TargetType" runat="server" DataTextField="Name" DataValueField="ID" onclick="OnClick()"></asp:RadioButtonList></td>
							</tr>
							<tr id="DwPageRow" runat="server" style="DISPLAY:none">
								<td><dw:translatelabel id="DwPageLabel" runat="server" Text="Side"></dw:translatelabel></td>
								<td>
									<%=Gui.LinkManagerExt(_dwPage, "DwPage", String.Empty)%>&nbsp;
									<asp:CustomValidator ClientValidationFunction="ValidatePage" id="PageValidator" runat="server" ErrorMessage="*" Display="Dynamic"></asp:CustomValidator>
								</td>
							</tr>
							<tr id="DwFileRow" runat="server" style="DISPLAY:none">
								<td><dw:translatelabel id="DwFileLabel" runat="server" Text="Fil"></dw:translatelabel></td>
								<td>
									<dw:filemanager id="DwFile" runat="server"></dw:filemanager>&nbsp;
									<asp:CustomValidator ClientValidationFunction="ValidateFile" id="FileValidator" runat="server" ErrorMessage="*" Display="Dynamic"></asp:CustomValidator>
								</td>
							</tr>
							<tr id="UrlRow" runat="server" style="DISPLAY:none">
								<td><dw:translatelabel id="UrlLabel" runat="server" Text="URL"></dw:translatelabel></td>
								<td>
									<asp:textbox id="Url" runat="server" MaxLength="255" CssClass="std"></asp:textbox>&nbsp;
									<asp:CustomValidator ClientValidationFunction="ValidateUrl" id="UrlValidator" runat="server" ErrorMessage="*" Display="Dynamic"></asp:CustomValidator>
								</td>
							</tr>
							<tr id="ClassMethodRow" runat="server" style="DISPLAY:none">
								<td valign="top"><dw:translatelabel id="ClassMethodLabel" runat="server" Text="Class method"></dw:translatelabel></td>
								<td><uc1:ClassMethodSelector id="TheMethod" runat="server"></uc1:ClassMethodSelector></td>
							</tr>
							<tr id="DBIntegrationJobRow" runat="server" style="DISPLAY:none">
								<td><dw:translatelabel id="DBIntegrationJobRowLabel" runat="server" Text="DBIntegrationJob"></dw:translatelabel></td>
								<td>
									<asp:DropDownList id="DBIntegrationJob" runat="server" CssClass="std" > </asp:DropDownList>
									<asp:CustomValidator ClientValidationFunction="ValidateDBIntegrationJob" id="DBIntegrationJobValidator" runat="server" ErrorMessage="*" Display="Dynamic"></asp:CustomValidator>
								</td>
							</tr>

						</table>
						<dw:groupboxend id="TargetEnd" runat="server"></dw:groupboxend></td>
				</TR>
				<TR>
					<td vAlign="top"><br>
						<dw:groupboxstart id="ScheduleStart" title="Afvikling" runat="server"></dw:groupboxstart>
						<table cellSpacing="1" cellPadding="1" width="100%" border="0">
							<tr>
								<td width="150"><dw:translatelabel id="DayLabel" runat="server" Text="Dag"></dw:translatelabel></td>
								<td>
									<asp:DropDownList id="Days" runat="server" CssClass="std" onchange="OnChangeDay()">
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td><dw:translatelabel id="WdayLabel" runat="server" Text="Ugedag"></dw:translatelabel></td>
								<td>
									<asp:DropDownList id="Wdays" runat="server" CssClass="std" onchange="OnChangeWday()">
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td><dw:translatelabel id="HourLabel" runat="server" Text="Time"></dw:translatelabel></td>
								<td>
									<asp:DropDownList id="Hours" runat="server" CssClass="std">
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td><dw:translatelabel id="MinuteLabel" runat="server" Text="Minut"></dw:translatelabel></td>
								<td>
									<asp:DropDownList id="Minutes" runat="server" CssClass="std">
									</asp:DropDownList>
								</td>
							</tr>
						</table>
						<dw:groupboxend id="ScheduleEnd" runat="server"></dw:groupboxend></td>
				</TR>
				<tr>
					<td vAlign="bottom" align="right">
						<table cellSpacing="0" cellPadding="0" border="0">
							<tr>
								<td colspan="4" height="5"></td>
							</tr>
							<tr>
								<td>
								<asp:button id="Ok" runat="server" Text="OK" CssClass="buttonSubmit"></asp:button>
								<asp:button id="Cancel" runat="server" Text="Cancel" CssClass="buttonSubmit" CausesValidation="False"></asp:button>
                                <%=Gui.HelpButton("form", "administration.controlpanel.scheduledtasks.edit", , 5)%>
								</td>
								<td width="10"></td>
							</tr>
							<tr>
								<td colspan="4" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
			<%  Translate.GetEditOnlineScript()%>
    </body>
</HTML>
