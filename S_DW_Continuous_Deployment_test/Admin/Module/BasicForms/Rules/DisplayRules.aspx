<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DisplayRules.aspx.vb" Inherits="Dynamicweb.Admin.DisplayRules" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Modules.Forms.Rules" %>
<%@ Import Namespace="Dynamicweb.Modules.Forms" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server">
    </dw:ControlResources> 
            <script type="text/javascript">
                function help() {
                <%=Dynamicweb.Gui.help("","modules.basicforms") %>
            }
                function newCondition() {
                    var ruleId = document.getElementById("ClientRuleId").value;
                    location = 'DisplayRules.aspx?action=insert&ID=' + ruleid;
                }

                function editCondition() {
                    var conditionId = ContextMenu.callingID;
                    var obj = document.getElementById("conditionfield" + conditionId).dataset;
                    location = 'DisplayRules.aspx?action=edit&ConditionId=' + conditionId + '&ID=' + obj.rule;
                }

                function deleteCondition() {
                    var conditionId = ContextMenu.callingID
                    location = 'DisplayRules.aspx?action=delete&ConitionId=' + conditionId;
                }

                function sortDown(conditionId) {
                    var obj = document.getElementById('conditionfieldId' + conditionId).dataset
                    location = 'DisplayRules.aspx?action=sort&direction=down&ConditionId=' + conditionId + '&ID=' + obj.rule;
                }

                function sortUp(conditionId) {
                    var obj = document.getElementById("conditionfieldId" + conditionId).dataset
                    location = 'DisplayRules.aspx?action=sort&direction=up&ConditionId=' + conditionId + '&ID=' + obj.rule;
                }

        </script>
    <link href="../Css/DisplayForm.css" rel="stylesheet" /> 	

</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="RuleID" name="RuleID" runat="server"/>
        <input type="hidden" id="ClientRuleId" name="ClientRuleId" value="<%=Request.QueryString("ID")%>"/>


		<dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
			<dw:ToolbarButton ID="ruleAdd" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/form_blue_add.png" Text="Ny Visnings regl" OnClientClick="newCondition();" />
			<dw:ToolbarButton ID="operatorAdd" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/form_blue_add.png" Text="Tilføj en operator" OnClientClick="newOperator();" />
			<dw:ToolbarButton ID="cmdHelp" runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="help();" />
		</dw:Toolbar>

		<h2 class="subtitle">
			<dw:TranslateLabel ID="lbSetupConditions" Text="Betingelser" runat="server" />
			<span runat="server" id="conditioncount"></span>
		</h2>

               
       <div class="container" style="margin: 10px; padding-bottom:10px; border-bottom: 1px dashed #e1e1e1;">         
        <asp:Label runat="server" text="if" />

        <select id="rule_list" name="rule_fldName" class="std" style="width: 200px;">
            <option value="Name">Name</option>
            <option value="Email" >Email</option>
            <option value="Telefon" >Telefon</option>            
        </select> 

        <select id="rule_FldCondition" name="rule_fldCondition" class="std" " style="width: 200px;">
            <option value="Is">Is</option>
            <option value="IsNot">Is not</option>
            <option value="Contains">contains</option>
            <option value="ContainsNot">does not contain</option>
            <option value="regEx">regular expression</option>
        </select>
            
            <input type="text" style="width: 304px;" />
           <div style="margin: 20px 0 0 10px">
            <select id="rule_Visible" name="rule_Visible" class="std" style="width: 100px;">
                 <option value="Shown" >Shown</option>
                <option value="Hidden" >Hidden</option>
            </select>

                <select id="rule_SelectedInput" name="rule_SelectedInput" class="std" style="width: 200px;" >
                 <option value="Telefon" >Telefon</option>
            </select>
           </div>
        
           </div>
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
