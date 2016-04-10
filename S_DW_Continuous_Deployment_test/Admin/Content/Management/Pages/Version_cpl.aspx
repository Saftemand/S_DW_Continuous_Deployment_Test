<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Version_cpl.aspx.vb" Inherits="Dynamicweb.Admin.Version_cpl" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
        <title></title>
        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
        <script language="javascript" type="text/javascript">
            function help() {
		        <%=Dynamicweb.Gui.help("","managementcenter.web.version") %>
	        }
	        
            function changeVersion(){
                if(ContextMenu.callingID){
                    var rowId  = "row" + ContextMenu.callingID;
                    var seletcedText = $(rowId).children[0].innerText;
                    $$('#SelectedVersion option').each(function(el){
                        if(el.text.indexOf(seletcedText)!= -1){
                            el.selected = true;
                        }
                    });
                }
				dialog.show('dlgChangeVersion');
	        }
	        
	        function fileLocations(){
				dialog.show("dlgFileLocations");
	        }
	        
	        function vInfo(){
				var vers  = document.getElementById("version" + ContextMenu.callingID).innerHTML;
				window.open("http://developer.dynamicweb-cms.com/Releases.aspx#" + vers, "_blank", "");
	        }
	        
	        function changeVersionConfirm(){
				if(document.getElementById("SelectedVersion").value.length == 0){
					alert("<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.Translate("version"))%>");
					document.getElementById("SelectedVersion").focus();
					return false;
				}
	            document.getElementById("pathNameb").innerHTML = document.getElementById("SelectedVersion").value;
	            dialog.hide('dlgChangeVersion');
                
	            var showWarningFor83AndLower = showDowngradeWarningFor83AndLower(); 
	            document.getElementById("before84DowngradeWarning").style.display = showWarningFor83AndLower ? "" : "none";
	            var showWarningDlgFor851AndLower = showDowngradeWarningDlgFor851AndLower();
	            document.getElementById("before86DowngradeWarning").style.display = showWarningDlgFor851AndLower ? "" : "none";
	            if (showWarningFor83AndLower || showWarningDlgFor851AndLower) {	                
	                dialog.show('dlgDowngradeWarning');
	                return false;
	            }else{	            
	                dialog.show('dlgConfirmUpdate');
	            }
	        }

	        function apply(){
				var o = new overlay('wait');
				o.show();
				//alert(encodeURIComponent(document.getElementById("SelectedVersion").value));
				location = "Version_cpl.aspx?newpath=" + encodeURIComponent(document.getElementById("SelectedVersion").value);
	        }

	        function showDowngradeWarningFor83AndLower() {	                           
	            var isAfter83Version = <%=IsCurrentVersionAfter83.ToString().ToLower()%>;	            
	            if (isAfter83Version && isSelectedVersionBeforeVersion("8.4")) {	                
	                return true;	                                    
	            } else {
	                return false;
	            }	                	            
	        }

            function showDowngradeWarningDlgFor851AndLower() {	  
                var isAfter861Version = <%=IsCurrentVersionAfter861.ToString.ToLower()%>;                               
                if (isAfter861Version && isSelectedVersionBeforeVersion("8.6")) {                    
                    return true;                    	                
                } else {
                    return false;
                }	                	            
            }

            function isSelectedVersionBeforeVersion(version){                
                var ret = false;
                if(document.getElementById("SelectedVersion").selectedIndex > 0){
                    var selectedVersion = document.getElementById("SelectedVersion").options[document.getElementById("SelectedVersion").selectedIndex].text;
                    var regex = /\(([^)]+)\)/;
                    var matches = selectedVersion.match(regex);
                    if(matches.length > 1){
                        selectedVersion = matches[1].split(".");
                        var beforeVersion = version.split(".");
                        if(selectedVersion.length > 1 && beforeVersion.length > 1){
                            if (parseInt(selectedVersion[0]) <= parseInt(beforeVersion[0])){
                                if(parseInt(selectedVersion[0]) < parseInt(beforeVersion[0])){
                                    ret = true;
                                }else{
                                    ret = (parseInt(selectedVersion[1]) < parseInt(beforeVersion[1]))                                    
                                }
                            }                            
                        }
                    }
                }
                return ret;
            }

	        function downgradeWarningOk() {
	            dialog.hide('dlgDowngradeWarning');
	            dialog.show('dlgConfirmUpdate');
	        }

	        function downgradeWarningCancel() {
	            dialog.hide('dlgDowngradeWarning');	            
	        }
	    </script>
	    <style type="text/css">
	    	.Infobar
{
	position:relative;
	margin:3px;
}
	    	</style>
</head>
<body>
    <form id="form1" runat="server">
     <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
        <dw:ToolbarButton ID="cmdAdd" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_edit.png" Text="Change version" OnClientClick="changeVersion();" />
        <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="location='/Admin/Content/Management/Start.aspx';" />
        <dw:ToolbarButton ID="cmdReleaseInformation" runat="server" Divide="Before" Image="Information" Text="Releases" OnClientClick="window.open('http://developer.dynamicweb-cms.com/Releases.aspx', '_blank', '');" />
        <dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" Image="Folder" Text="File locations" OnClientClick="fileLocations();" />
        <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="help();" />
    </dw:Toolbar>
    <h2 class="subtitle">
        <dw:TranslateLabel ID="lbSetup" Text="Version" runat="server" />
    </h2>
    <dw:List ID="lstVersions" ShowPaging="false" NoItemsMessage="" ShowTitle="false" ShowCollapseButton="false" runat="server">
        <Columns>
            <dw:ListColumn ID="colName" Name="Name" Width="120" runat="server" />
            <dw:ListColumn ID="colVersion" Name="Version" Width="60" runat="server" />
            <dw:ListColumn ID="colDate" Name="Dato" Width="120" runat="server" />
            <dw:ListColumn ID="colType" Name="Type" Width="100" runat="server" />
            <dw:ListColumn ID="colPath" Name="Sti" Width="450" runat="server" />
        </Columns>
    </dw:List>

	<dw:ContextMenu ID="Contextmenu1" runat="server">
		<dw:ContextMenuButton ID="ContextmenuButton1" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_edit.png" Text="Change version" OnClientClick="changeVersion();">
		</dw:ContextMenuButton>
		<dw:ContextMenuButton ID="ContextmenuButton2" runat="server" Divide="None" Image="Information" Text="Information" OnClientClick="vInfo();">
		</dw:ContextMenuButton>
	</dw:ContextMenu>

	<dw:Dialog ID="dlgChangeVersion" runat="server" Title="Change version" OkAction="changeVersionConfirm();" ShowOkButton="true" ShowCancelButton="true">
    <table cellpadding="2" cellspacing="2">
		<tr>
			<td><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Current version" /></td>
			<td><%=CurrentVersion%>
			</td>
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Change to version" /></td>
			<td>
				<select id="SelectedVersion" runat="server" class="std">
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<br /><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Sti" />
			</td>
		</tr>
		<tr>
			<td colspan="2" id="homedir" runat="server"></td>
		</tr>
    </table>
    </dw:Dialog>
    
	<dw:Dialog ID="dlgConfirmUpdate" runat="server" Title="Bekræft" OkAction="apply();" ShowOkButton="true" ShowCancelButton="true" Width="550">
		<img src="/Admin/Images/Ribbon/Icons/warning.png" alt="" style="vertical-align:middle;" />
		<%=Translate.JsTranslate("Opdater %%", "%%", Translate.JsTranslate("Home directory"))%>?
		<br />
		<b id="pathNameb" style="display:block;text-align:center;white-space:nowrap;"></b>
		<br /><br />
		<b><%=Translate.JsTranslate("ADVARSEL!")%><br /></b>
		<%=Translate.JsTranslate("The website will restart and you will be logged off.")%>
		<br /><br />
	</dw:Dialog>

    <dw:Dialog ID="dlgDowngradeWarning" runat="server" Title="Downgrade warning" OkAction="downgradeWarningOk();" CancelAction="downgradeWarningCancel();" ShowOkButton="true" ShowCancelButton="true" Width="600">
        <table id="before84DowngradeWarning" style="display:none;">
	        <tr><td><%=Translate.JsTranslate("It is not possible to downgrade a custom solution to pre 8.4 versions.")%></td></tr>
            <tr><td><%=Translate.JsTranslate("If this is a custom solution please click Cancel and contact servicedesk for help with downgrading.")%></td></tr>
            <tr><td><%=Translate.JsTranslate("If this is a standard solution click OK to continue.")%></td></tr>		
        </table>
        <table id="before86DowngradeWarning" style="display:none;">
	        <tr><td><%=Translate.JsTranslate("All shared item types will be lost when downgrading below Dynamicweb 8.6")%></td></tr>            
        </table>
    </dw:Dialog>

		<dw:Infobar ID="infoCustom" runat="server" Type="Information" Visible="false">
			Custom
			<b runat="server" id="CustomHomeDir"></b>
		</dw:Infobar>
        <dw:Infobar ID="serviseDownWarning" runat="server" Type="Error" Visible="false">
			<dw:TranslateLabel Text="The Version webservice is down please try again later. Contact service desk if the problem persists" runat="server" />
		</dw:Infobar>
		<dw:Dialog ID="dlgFileLocations" runat="server" Title="File locations" Width="600">
			<table class="gbTab" border="0" cellpadding="2" cellspacing="2">
				<tr>
					<td colspan="2">
					<dw:Infobar ID="assemblyWarning" runat="server" Type="Error" Visible="false">ERROR. This solution has a version conflict.</dw:Infobar>
					</td>
				</tr>
				<tr>
                    <td>
                        <dw:TranslateLabel ID="TranslateLabel60" Text="Home directory" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="litHomeDir" runat="server" /><br />
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <dw:TranslateLabel ID="TranslateLabel4" Text="Admin location" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="litAdminLocation" runat="server" /><br />
                        <span style="white-space:nowrap"><asp:Literal ID="litAdminBinLocation" runat="server" Visible="false" /></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:TranslateLabel ID="TranslateLabel5" Text="Bin location" runat="server" />
                    </td>
                    <td>
                        <span style="white-space:nowrap"><asp:Literal ID="litBinLocation" runat="server" /></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:TranslateLabel ID="TranslateLabel6" Text="File location" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="litFilesLocation" runat="server" />
                    </td>
                </tr>
                <tr runat="server" id="databaseLocation">
                    <td>
                        <dw:TranslateLabel ID="TranslateLabel7" Text="Database location" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="litDatabaseLocation" runat="server" />
                    </td>
                </tr>
            </table>
		</dw:Dialog>
	
	<dw:Overlay ID="wait" runat="server" Message="" ShowWaitAnimation="True">
		<dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Opdatering" />...
	</dw:Overlay>
    </form>
    
    <style type="text/css">
    #<%=SelectedRowId%>
    {
    	background-color:#FFF8DC;
    }
    </style>
    <%'=Dynamicweb.Content.Management.IIS.HaveMetaBaseWriteAccess()%>
</body>
</html>

<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>