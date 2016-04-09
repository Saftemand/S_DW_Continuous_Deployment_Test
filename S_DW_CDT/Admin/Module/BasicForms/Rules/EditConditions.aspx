<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditConditions.aspx.vb" Inherits="Dynamicweb.Admin.EditConditions" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Modules.Forms.Rules" %>
<%@ Import Namespace="Dynamicweb.Modules.Forms" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<dw:ControlResources ID="ctrlResources" IncludePrototype="false" runat="server" />
	<script type="text/javascript">
	    function help() {
		    <%=Dynamicweb.Gui.help("","modules.basicforms") %>
	    }
	    function savecondition() {
	        document.getElementById("modifycondition").submit();
	    }
	    function resetform() {
	        var id = document.getElementById("RuleID").value
	        document.getElementById("modifycondition").reset();
	        location = 'EditRules.aspx?ID=' + id;
	    }
	    function overlayShow() {
	        showOverlay('wait');
	    }
	    function ChangeType() {
	        var e = document.getElementById("FieldType");
	        var fieldtype = e.options[e.selectedIndex].value;


	    }
	</script>
</head>
<body>
    <form id="modifycondition" runat="server" method="post" action="EditConditions.aspx">
            <input type="hidden" id="RuleID" name="RuleID" runat="server"/>
			<input type="hidden" id="ConditionID" name="ConditionID" runat="server"/>
            <input type="hidden" id="Sort" name="Sort" runat="server" />  
			<input type="hidden" id="action" name="action" value="save" />
		    <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
			    <dw:ToolbarButton ID="cmdSave" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Save.png" Text="Gem" OnClientClick="savecondition();" />
			    <dw:ToolbarButton ID="cmdClose" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Delete.png" Text="Luk" OnClientClick="resetform();" />
			    <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="help();" />
		    </dw:Toolbar>
		    <h2 class="subtitle">
			    <dw:TranslateLabel ID="lbSetupConditions" Text="Rediger betingelse" runat="server" />
		    </h2>
			<dw:GroupBox ID="GB_settings" runat="server" DoTranslation="True" Title="Indstillinger">
				<table>
					<tr>
						<td width="170" valign="top">
							<label for="FieldId">
								<dw:TranslateLabel runat="server" Text="Feltnavn" />
							</label>
						</td>
						<td>
                            <select id="FieldId" name="FieldId" runat="server" class="std">

                            </select>
						</td>
					</tr>
					<tr>
						<td width="170" valign="top">
							<label for="FieldType">
								<dw:TranslateLabel runat="server" Text="Felttype" />
							</label>
						</td>
						<td>
                            <select id="FieldType" name="FieldType" runat="server" class="std">
                            </select>
						</td>
					</tr>

					<tr>
						<td width="170" valign="top">
							<label for="Param1">
								<dw:TranslateLabel runat="server" Text="Value" />
							</label>
						</td>
						<td>
<!--
                            <select id="Param1Option" name="Param1Option" runat="server" class="std">
                            </select>        
-->                                                
							<input type="text" id="Param1" name="Param1" maxlength="255" class="std" runat="server" />
						</td>
					</tr>

					<tr>
						<td width="170" valign="top">
							<label for="Operator">
								<dw:TranslateLabel runat="server" Text="Operator" />
							</label>
						</td>
						<td>
                            <select id="Operator" name="Operator" runat="server" class="std">
                            </select>
						</td>
					</tr>
				</table>
            </dw:GroupBox>
    </form>

	<dw:Overlay ID="wait" runat="server"></dw:Overlay>
	<%  
		Dynamicweb.Backend.Translate.GetEditOnlineScript()
	%>
</body>
</html>
