<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCDataSource.ascx.vb" Inherits="Dynamicweb.Admin.DBIntegration.UCDataSource" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
<script src="/Admin/FileManager/FileManager_browse2.js" type="text/javascript"></script>
<script language="javascript">	
	function validateDelimiter_custom(source, arguments)
	{
		if(document.getElementById("<%=Me.ID%>_DdlJobDS2Delimiter").value == "Custom")
		{
			var ln = document.getElementById("<%=Me.ID%>_TbJobDS2Delimiter").value.length
			if( ln >= 0 && ln < 2)
			{
				arguments.IsValid = true;
				return true;
			}
			else
			{
				arguments.IsValid = false;
				return false;				
			}
		}
		arguments.IsValid = true;
		return true;
	}
	
	
	function validateDecimal(source, arguments)
	{
			var ln = document.getElementById("<%=Me.ID%>_TbJobDS2Decimal").value.length
			if( ln >= 0 && ln < 2)
			{
				arguments.IsValid = true;
				return true;
			}
			else
			{
				arguments.IsValid = false;
				return false;				
			}
	}
	
	function CustomDelimiter()
	{
		if(document.getElementById("<%=Me.ID%>_DdlJobDS2Delimiter").value == "Custom")
		{
			document.getElementById("SpanJobDS2Delimiter").style.display = "";
		}
		else
		{
			document.getElementById("SpanJobDS2Delimiter").style.display = "none";
		}
	}
</script>
<%FillConnectFields()%>
<table width="100%">
	<tr>
		<td>
			<table>
				<tr>
					<td style="PADDING-TOP: 5px" vAlign="top" width="170"><%=Translate.translate("Database type")%></td>
					<td width="320"><asp:radiobutton id="Type1" Runat="server" Text="Access from filearchive" GroupName="JobDataSource"
							Checked="False" AutoPostBack="True"></asp:radiobutton><br>
						<asp:radiobutton id="Type2" Runat="server" Text="CSV file" GroupName="JobDataSource" Checked="False"
							AutoPostBack="True"></asp:radiobutton><br>
						<asp:radiobutton id="Type3" Runat="server" Text="External SQL Database" GroupName="JobDataSource"
							Checked="False" AutoPostBack="True"></asp:radiobutton><br>
						<asp:radiobutton id="Type4" Runat="server" Text="WebService" GroupName="JobDataSource" Checked="False"
							AutoPostBack="True"></asp:radiobutton></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
	<asp:panel id="_panelAccessDS" Runat="server">
		<TR>
			<TD>
				<TABLE>
					<TR>
						<TD width="170"><%=Translate.translate("Database")%></TD>
						<TD><%= Gui.FileManager(_fmJobDS1File, Dynamicweb.Content.Management.Installation.FilesFolderName, "fmJobDS1Filemanager", "mdb")%></TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<asp:Button id="BtnJobDS1" Runat="server" OnCommand="OnConnectClick" Text="Connect" CssClass="buttonSubmit"
								CommandArgument="ACCESSDS"></asp:Button></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</asp:panel><asp:panel id="_panelCSVDS" Runat="server">
		<TR>
			<TD>
				<TABLE>
					<TR>
						<TD width="170"><%=Translate.Translate("Folder")%></TD>
						<TD><%=Gui.FolderManager(_fmJobDS2Folder, "fmJobDS2Foldermanager", True, True) %></TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<asp:checkbox id="ChbJobDS2" Width="300" Text="First line column names" Checked="True" BorderStyle="None"
								runat="server"></asp:checkbox></TD>
					</TR>
					<TR>
						<TD vAlign="top"><%=Translate.translate("Decimal symbol")%></TD>
						<TD>
							<asp:textbox id="TbJobDS2Decimal" Width="300" CssClass="std" runat="server"></asp:textbox>
							<asp:CustomValidator id="CvJobDS2Decimal" runat="server" ErrorMessage=" allowed not more one symbol"
								ClientValidationFunction="validateDecimal"></asp:CustomValidator></TD>
					</TR>
					<TR>
						<TD><%=Translate.translate("Karaktersæt")%></TD>
						<TD>
							<asp:dropdownlist id="DdlJobDS2Character" Width="300" CssClass="std" runat="server">
							</asp:dropdownlist></TD>
					</TR>
					<TR>
						<TD><%=Translate.translate("Separator")%></TD>
						<TD>
							<asp:dropdownlist id="DdlJobDS2Delimiter" onclick="CustomDelimiter();" Width="300" CssClass="std"
								runat="server">
							</asp:dropdownlist><BR>
							<SPAN id="SpanJobDS2Delimiter" style="DISPLAY: none">
								<asp:textbox id="TbJobDS2Delimiter" Width="300" CssClass="std" runat="server"></asp:textbox>
								<asp:CustomValidator id="CvJobDS2Delimiter" runat="server" ErrorMessage=" allowed only one symbol" ClientValidationFunction="validateDelimiter_custom"></asp:CustomValidator></SPAN></TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<asp:Button id="BtnJobDS2" Runat="server" OnCommand="OnConnectClick" Text="Connect" CssClass="buttonSubmit"
								CommandArgument="CSVDS"></asp:Button></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</asp:panel><asp:panel id="_panelSQLDS" Runat="server">
		<TR>
			<TD>
				<TABLE>
					<TR>
						<TD width="170"><%=Translate.translate("Server")%></TD>
						<TD>
							<asp:TextBox id="TbJobDS3Server" Runat="server" Width="300" CssClass="std"></asp:TextBox></TD>
					</TR>
					<TR>
						<TD><%=Translate.translate("Database")%></TD>
						<TD>
							<asp:TextBox id="TbJobDS3Database" Runat="server" Width="300" CssClass="std"></asp:TextBox></TD>
					</TR>
					<TR>
						<TD><%=Translate.translate("Bruger")%></TD>
						<TD>
							<asp:TextBox id="TbJobDS3User" Runat="server" Width="300" CssClass="std"></asp:TextBox></TD>
					</TR>
					<TR>
						<TD><%=Translate.translate("Password")%></TD>
						<TD>
							<asp:TextBox id="TbJobDS3Password" Runat="server" Width="300" CssClass="std" TextMode="Password"></asp:TextBox></TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<asp:Button id="BtnJobDS3" Runat="server" OnCommand="OnConnectClick" Text="Connect" CssClass="buttonSubmit"
								CommandArgument="SQLDS"></asp:Button></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</asp:panel><asp:panel id="_panelWSDS" Runat="server">
		<TR>
			<TD>
				<TABLE>
					<TR>
						<TD width="170"><%=Translate.translate("Webservice URL")%></TD>
						<TD>
							<asp:TextBox id="TbJobDS4WebServicePath" Runat="server" Width="300" CssClass="std"></asp:TextBox></TD>
					</TR>
					<TR>
						<TD><%=Translate.translate("SQL")%></TD>
						<TD>
							<asp:TextBox id="TbJobDS4Sql" Runat="server" Width="300" CssClass="std"></asp:TextBox></TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<asp:Button id="BtnJobDS4" Runat="server" OnCommand="OnConnectClick" Text="Connect" CssClass="buttonSubmit"
								CommandArgument="WSDS"></asp:Button></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</asp:panel>
	<asp:Panel ID="_panelTableSelect" Runat="server">
		<TR>
			<TD>
				<TABLE>
					<TR>
						<TD width="170"><%=Translate.translate("Tabel")%></TD>
						<TD>
							<asp:DropDownList id="DdlTable" Runat="server" Width="300" AutoPostBack="True" CssClass="std"></asp:DropDownList></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</asp:Panel>
<%=_custDelimiter%>
