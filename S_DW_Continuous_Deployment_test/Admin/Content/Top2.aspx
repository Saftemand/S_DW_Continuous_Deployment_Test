<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Top2.aspx.vb" Inherits="Dynamicweb.Admin.Top2" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<dw:ControlResources runat="server" IncludePrototype="true"></dw:ControlResources>
	<link href="Top2.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
	    /* Defining a namespace */
	    if(typeof(Dynamicweb) == 'undefined') {
	        var Dynamicweb = new Object();
	    }

	    /* Defining a sub-namespace */
	    if(typeof(Dynamicweb.Globals) == 'undefined') {
	        Dynamicweb.Globals = new Object();
	    }

	    /* Gets or sets value indicating whether new version of eCommerce is enabled */
	    Dynamicweb.Globals.IsNewEcom = <%=Gui.NewEcom().ToString().ToLower(System.Globalization.CultureInfo.InvariantCulture)%>;
	</script>

	<script type="text/javascript">
		function openPublicSite() {
			var path = '/Default.aspx?AreaID=' + parent.left.areaid;
			window.open(path);
		}
		function openFrontendEditing() {
			var path = '/Admin/Content/FrontendEditing.aspx?AreaID=' + parent.left.areaid +'&FrontendEditingState=edit';
			window.open(path);
		}
		function ShowLoginInformation() {
			top.right.location = "/Admin/Content/Management/Default.aspx?load=Pages/SystemSolutionDetails_cpl.aspx";
		}
		function help() {
		        <%=Dynamicweb.Gui.help("","gui") %>
	        }

	    function myPage() {
	        if(typeof(top.right.showPageFrame) != 'undefined') {
	            top.right.showPageFrame();
	        }

	        top.right.location='/Admin/MyPage/default.aspx';
	    }

	    function stat() {
	        if(typeof(top.right.showPageFrame) != 'undefined') {
	            top.right.showPageFrame();
	        }

	        top.right.location='/Admin/Module/StatisticsV3/Main.aspx';
	    }
        function ChangePassword() {
	        if(typeof(top.right.showPageFrame) != 'undefined') {
	            top.right.showPageFrame();
	        }

	        top.right.location='/Admin/Content/Management/Pages/ChangePassword.aspx';
        }
        var interval = null;
        var topOverlay = null;
        var leftOverlay = null;
        function onload(){
            if('<%=ShowUpgradeWarning.ToString.ToLower%>' == 'true'){
                interval = setInterval(function(){ ShowUpgradeWarning() }, 1000);                
            }
        }
	    function GetModalOverlay(){
	        return new Element('div', { 'style': 'position: fixed;top: 0px;left: 0px;right: 0px;bottom: 0px;z-index: 5;background-color: #ffffff;opacity: 0.4;-moz-opacity: 0.4;filter: alpha(opacity = 40);' });                                
	    }
        function ShowUpgradeWarning(){
            if(parent.right && parent.right.pwDialog_wnd && parent.left.document.body){
                clearInterval(interval);

                var dialog = parent.right.pwDialog_wnd;
                dialog.set_contentUrl('/Admin/Content/UpgradeWarningForAccess.aspx');
                dialog.set_title('<%= Backend.Translate.JsTranslate("Microsoft Access - Upgrade is recommended")%>');
                dialog.set_width(400);
                dialog.set_height(150);
                dialog.set_showClose(false);
                dialog.show();
                
                leftOverlay = GetModalOverlay();
                parent.left.document.body.appendChild(leftOverlay);                
                topOverlay = GetModalOverlay();
                document.body.appendChild(topOverlay);
            }
        }	 
	    function CloseUpgradeWarning(){
	        if(parent.right && parent.right.pwDialog_wnd)
	            parent.right.pwDialog_wnd.hide();	        
	        if(topOverlay)
	            topOverlay.hide();
	        if(leftOverlay)
	            leftOverlay.hide();	        
	    }	    
	</script>
</head>
<body onload="onload();">
<span id="versionInfo" class="h" runat="server" visible="false" onclick="ShowLoginInformation();">Version: <%=Base.DWAssemblyVersionInformation%><%=Me.Nightly()%> (<%=Me.BuildDate%>) - <%=Me.Custom%> - <%=Dynamicweb.Admin.ShowLoginInformation.DomainName%></span>    
<div class="top">
    <img src="/Admin/access/DW_logo_wheel_169_white.png" alt="" class="h" onclick="openPublicSite();" />
    <span id="trialInfo" runat="server" visible="false" style="position:absolute;top:12px;display:block;width:100%;text-align:center;color:red;"><%=Translate.JSTranslate("This installation is a Trial. Days left:")%> <%=Me.TrialDaysLeft() %> </span>
    <span id="UpgradeWarningInfo" runat="server" visible="false" style="width:100%;position:absolute;top:12px;display:block;text-align:center;line-height:12px;">
        <span style="display:inline-block;width:600px;text-align:center;background-color:#87C9FF;border: 1px solid #006699;">
            <img alt="" style="vertical-align: middle;display:block;" src="/Admin/Images/Ribbon/Icons/Small/information.png" />
            <span><%=Translate.JsTranslate("Solution is running on Microsoft Access - Upgrade to Microsoft SQL Server is recommended. ")%></span>
            <span><%=Translate.JsTranslate("Contact your solution partner for details")%></span>
        </span>
    </span>
    <span id="StatisticsPerformanceWarning" runat="server" visible="false" style="width:100%;position:absolute;top:12px;display:block;text-align:center;line-height:12px;">
        <span style="display:inline-block;width:600px;text-align:center;background-color:#87C9FF;border: 1px solid #006699;vertical-align:middle">
            <img alt="" style="vertical-align: middle;display:block;" src="/Admin/Images/Ribbon/Icons/Small/information.png" />
            <span><%=Translate.JsTranslate("Solution session statistics exceeds 4 GB - Performance can be affected, purge is recommended.")%></span>
        </span>
    </span>
    <div class="userInfo">    
    <b>
    <%=IIf(Trim(Base.GetGs("/Globalsettings/Settings/CommonInformation/SolutionTitle")) <> "", Base.GetGs("/Globalsettings/Settings/CommonInformation/SolutionTitle"), Request.ServerVariables.Item("HTTP_HOST"))%>
    (Dynamicweb <span runat="server" id="licensename"></span>)
    </b><br />
    <%=IIf(CStr(Session("DW_Admin_UserName")) <> "" And CStr(Session("DW_Admin_UserName")) <> "Angel", Session("DW_Admin_UserName"), Session("DW_Admin_UserUserName"))%>
    </div>    
</div>
<div class="myToolbar">
<table cellpadding="0" border="0" cellspacing="0" width="100%">
	<tr>
		<td valign="top">
			<dw:Toolbar ID="Toolbar1" runat="server" ShowStart="false" ShowEnd="false">
                <dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" Image="Home" Text="Min side" ShowText="true" OnClientClick="myPage();">
                </dw:ToolbarButton>               
                <dw:ToolbarButton ID="ToolbarButton5" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/column-chart.png" Text="Statistik" ShowText="true" OnClientClick="stat();">
				</dw:ToolbarButton>
				<dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="before" Image="Key" Text="Logaf" ShowText="true" OnClientClick="top.location='/Admin/Access/Access_Logoff.aspx';">
				</dw:ToolbarButton>
				<dw:ToolbarButton ID="ToolbarButtonOEM" runat="server" Divide="before" Image="ControlPanel" Text="Administration" ShowText="true" OnClientClick="top.right.location='/CustomModules/OEMDesign/Administration.aspx';" Visible="false">
				</dw:ToolbarButton>
			</dw:Toolbar>
		</td>
		<td align="right" valign="top">
			<dw:Toolbar ID="Toolbar2" runat="server" ShowStart="false" ShowEnd="false">
				<dw:ToolbarButton ID="ToolbarButton6" runat="server" Divide="none" image="Preview" Text="Frontend editing" ShowText="true" OnClientClick="openFrontendEditing();">
				</dw:ToolbarButton>
				<dw:ToolbarButton ID="ToolbarButton3" runat="server" Divide="none" image="Preview" Text="Åbn website" ShowText="true" OnClientClick="openPublicSite();">
				</dw:ToolbarButton>
				<dw:ToolbarButton ID="ToolbarButton4" runat="server" Divide="before" Image="Help" Text="Hjælp" ShowText="true" OnClientClick="help();">
				</dw:ToolbarButton>

			</dw:Toolbar>
		</td>
	</tr>
</table>
</div>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</body>
</html>
