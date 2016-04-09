<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomOrder_Compare.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomOrder_Compare" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

	<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true">
	</dw:ControlResources>

	<script type="text/javascript">
	    var versionID = <%=Dynamicweb.Base.Request("VersionID")%>;
		
		function changeCompare(version){
		    var loc = '<%=Dynamicweb.Base.GetHttpUrl(True, True).toLower().Replace("&versionid=" & Dynamicweb.Base.Request("VersionID"), "") %>' + '&VersionID=' + version;
		    location = loc;
		}
	</script>

	<style type="text/css">
		.ci
		{
			color: black !important;
			background-color: #80FF80 !important;
		}
		.cd
		{
			color: black !important;
			background-color: #FF8080 !important;
		}
		td
		{
			vertical-align: top;
		}
		.h1
		{
			font-size: 13px;
			font-weight: bold;
		}
		.h2
		{
			font-size: 12px;
			font-weight: bold;
		}
		.h3
		{
			font-size: 11px;
			font-weight: bold;
		}
		.g
		{
			background-color:#DDECFF;
			white-space:nowrap;
		}
		.t
		{
			right:17px;
			border-collapse:collapse;
		}
		.t td
		{
			border:solid 1px #8DAED9;
			padding:5px;
		}
		tr.g td
		{
			border-top:solid 0px white;
			background: url('/Admin/Images/Ribbon/UI/List/PipeL.gif' ) top left repeat-x;
		}
		.inlineToolbar ul
		{
			border-bottom-style:none;
		}
	</style>
</head>
<body>
    <form id="form1" runat="server">
    <h1 class="title" style="display:inherit;">
	    <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Compare versions" />
    </h1>
    <div style="position: fixed; top: 0px; right: 0px;">
	    <dw:Toolbar ID="Toolbar1" runat="server" ShowEnd="false" ShowStart="false">
		    <dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Error.png" Text="Luk" OnClientClick="parent.window.closeCompareOrder();">
		    </dw:ToolbarButton>
	    </dw:Toolbar>
    </div>
    <div style="position: fixed; top: 27px; right: 0px;bottom:0px;left:0px;overflow:auto;">
	<asp:Repeater ID="OrderCoparingsRepeater" runat="server" EnableViewState="false">
		<HeaderTemplate>
            <table class="t">
            <tr class="g">
	            <td width="170">
	            </td>
	            <td width="30%" style="padding:0px;"><strong>
                    <div style="float:left;padding:5px;">
		            <dw:TranslateLabel ID="pubLabel" runat="server" Text="Current" />
                    </div>
	            </strong></td>
	            <td width="30%" style="padding:0px;"><strong>
		            <div style="float:left;padding:5px;">
		            <dw:TranslateLabel ID="compareversionLabel" runat="server" Text="Previous versions" />
		            </div>
	            </strong></td>
	            <td width="30%" style="padding:0px;"><strong>
		            <div style="float:left;padding:5px;">
		            <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Compare" />
		            </div>
	            </strong></td>
            </tr>
		</HeaderTemplate>
		<ItemTemplate>
			<tr>
	            <td class="g">
                    <strong><%#Eval("FieldName")%></strong>
	            </td>
	            <td> <%#Eval("OriginalValue")%></td>
	            <td> <%#Eval("OldValue")%></td>
	            <td> <%#Eval("Compare")%></td>
			</tr>
		</ItemTemplate>
		<FooterTemplate>
			</table>
		</FooterTemplate>
	</asp:Repeater>
    </div>
    </form>
</body>
</html>
