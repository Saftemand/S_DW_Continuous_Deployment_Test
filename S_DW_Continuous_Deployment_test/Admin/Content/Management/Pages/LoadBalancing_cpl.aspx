<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="LoadBalancing_cpl.aspx.vb" Inherits="Dynamicweb.Admin.LoadBalancing_cpl" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
    	var page = SettingsPage.getInstance();

    	page.onSave = function () {
    		page.submit();
    	}

    	page.onHelp = function () {
            <%=Gui.Help("", "managementcenter.web.nlb")%>
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dw:GroupBox ID="gbWebClustering" Title="Web clustering" runat="server">
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170px"></td>
				<td id="clusterinfo" runat="server"></td>
			</tr>
			<tr>
				<td>
					<%=Translate.Translate("Primary machinename")%></td>
				<td id="clusterprimarymachine" runat="server"></td>
			</tr>
			<tr>
				<td>
					<%=Translate.Translate("Local machinename")%></td>
				<td id="clusterlocalmachine" runat="server"></td>
			</tr>
			<tr>
				<td>
					<%=Translate.Translate("Local hostname")%></td>
				<td id="clusterlocalhostname" runat="server"></td>
			</tr>
		</table>

    </dw:GroupBox>
    <dw:GroupBox ID="gbInstances" Title="Instances" runat="server">
	<dw:List ID="ListInstances" runat="server" Title="" ShowTitle="false" PageSize="100" ShowPaging="false">
	    <Columns>
		    <dw:ListColumn ID="ListColumn1" runat="server" Name="Machine name" Width="150">
		    </dw:ListColumn>
		    <dw:ListColumn ID="ListColumn2" runat="server" Name="Instance name" Width="150">
		    </dw:ListColumn>
			 <dw:ListColumn ID="ListColumn7" runat="server" Name="Host name" Width="150">
		    </dw:ListColumn>
		    <dw:ListColumn ID="ListColumn3" runat="server" Name="IP address" Width="80">
		    </dw:ListColumn>
            <dw:ListColumn ID="ListColumn4" runat="server" Name="Startup time" Width="120">
		    </dw:ListColumn>
            <dw:ListColumn ID="ListColumn5" runat="server" Name="Cache update" Width="120">
		    </dw:ListColumn>
            <dw:ListColumn ID="ListColumn6" runat="server" Name="Active" Width="25" ItemAlign="Center">
		    </dw:ListColumn>
		</Columns>
	</dw:List>
    </dw:GroupBox>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</asp:Content>
