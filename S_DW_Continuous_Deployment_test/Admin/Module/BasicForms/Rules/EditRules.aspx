<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditRules.aspx.vb" Inherits="Dynamicweb.Admin.EditRules" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Modules.Forms.Rules" %>
<%@ Import Namespace="Dynamicweb.Modules.Forms" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
    <dw:ControlResources ID="ctrlResources" CombineOutput="false" IncludePrototype="true" IncludeScriptaculous="true" runat="server">
    </dw:ControlResources> 
	<script type="text/javascript">
	    function help() {
		    <%=Dynamicweb.Gui.help("","modules.basicforms") %>
	    }
	    function newcondition()
	    {
	        var ruleid = document.getElementById("ClientRuleId").value;
	        location = 'EditRules.aspx?action=insert&ID=' + ruleid;
	    }
	    function editcondition() {
	        var conditionid = ContextMenu.callingID;
	        var obj = document.getElementById("conditionfield" + conditionid).dataset;
	        location = 'EditConditions.aspx?action=edit&ConditionId=' + conditionid + '&ID=' + obj.rule;
	    }
	    function deletecondition() {
	        var conditionid = ContextMenu.callingID;
	        location = 'EditRules.aspx?action=delete&ConditionId=' + conditionid;
	    }
	    function sortdown(conditionid) {
	        var obj = document.getElementById("conditionfield" + conditionid).dataset;
	        location = 'EditRules.aspx?action=sort&direction=down&ConditionId=' + conditionid + '&ID=' + obj.rule;
	    }
	    function sortup(conditionid) {
	        var obj = document.getElementById("conditionfield" + conditionid).dataset;
	        location = 'EditRules.aspx?action=sort&direction=up&ConditionId=' + conditionid + '&ID=' + obj.rule;
	    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="RuleID" name="RuleID" runat="server"/>
        <input type="hidden" id="ClientRuleId" name="ClientRuleId" value="<%=Request.QueryString("ID")%>"/>

		<dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
			<dw:ToolbarButton ID="cmdAdd" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/form_blue_add.png" Text="Ny betingelse" OnClientClick="newcondition();" />
			<dw:ToolbarButton ID="cmdHelp" runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="help();" />
		</dw:Toolbar>
		<h2 class="subtitle">
			<dw:TranslateLabel ID="lbSetupConditions" Text="Betingelser" runat="server" />
			<span runat="server" id="conditioncount"></span>
		</h2>
		<dw:List ID="list" ShowPaging="true" PageSize="50" NoItemsMessage="" ShowTitle="false" ShowCollapseButton="false" StretchContent="false" runat="server">
			<Columns>
				<dw:ListColumn ID="colField" Name="Field" Width="150" runat="server" EnableSorting="false"/>
				<dw:ListColumn ID="colType" Name="Type" Width="60" runat="server" ItemAlign="Left" HeaderAlign="Center" EnableSorting="false" />
				<dw:ListColumn ID="colValue1" Name="Value" Width="150" runat="server" ItemAlign="Left" HeaderAlign="Center" EnableSorting="false" />
				<dw:ListColumn ID="colOperator" Name="Operator" Width="60" runat="server" ItemAlign="Center" EnableSorting="false" />
                <dw:ListColumn ID="coSort" Name="Sorting" Width="60" runat="server" ItemAlign="Center" HeaderAlign="Center" EnableSorting="false" />
			</Columns>
		</dw:List>
    </form>

	<dw:ContextMenu ID="EditCondition" runat="server">
		<dw:ContextMenuButton ID="ContextMenuButton3" runat="server" Text="Rediger" ImagePath="/Admin/Images/Ribbon/Icons/Small/Edit.png" OnClientClick="editcondition();" Divide="After">
		</dw:ContextMenuButton>
		<dw:ContextMenuButton ID="ContextMenuButton2" runat="server" Text="Slet" ImagePath="/Admin/Images/Ribbon/Icons/Small/Delete.png" OnClientClick="deletecondition();">
		</dw:ContextMenuButton>
	</dw:ContextMenu>

	<dw:Overlay ID="wait" runat="server"></dw:Overlay>
	<%  
		Dynamicweb.Backend.Translate.GetEditOnlineScript()
	%>
</body>
</html>
