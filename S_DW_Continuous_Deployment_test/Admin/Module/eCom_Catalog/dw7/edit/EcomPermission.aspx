<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomPermission.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomPermission" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=Translate.JsTranslate("User Permissions")%></title>
    
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />

	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />

	<script type="text/javascript" src="../images/permission/permission.js"></script>
	<script type="text/javascript">
        var allRightsGranted = <asp:placeholder id="injectedVarAllRights" runat="server"></asp:placeholder>;        
        <asp:placeholder id="injectedJavascript" runat="server"></asp:placeholder>

		var SelGroupTxt = "<%=Translate.JsTranslate("Select group...")%>";
		var guitextConfirmClose = "<%=Translate.JsTranslate("Are you sure you want to close the window?\nYour changes will be lost")%>";
		var guitextNoXMLHttpSupport = "<%=Translate.JsTranslate("Your browser must support XMLHttp in order to save permissions.")%>";
		var guitextUnknownError = "<%=Translate.JsTranslate("An unknown error occured. Permissions were not saved.")%>";
		var guitextEveryone = "<%=Translate.JsTranslate("Everyone")%>";
	</script>
	
	<script type="text/javascript" src="../images/permission/dTree.js"></script>
	<script type="text/javascript" src="../images/permission/prototype.js"></script>
	
	<style type="text/css">
		body.margin             {margin-top: 0px; margin-left: 0px;margin-right: 0px; margin-bottom: 0px;}
                
        .dtree 					{font-family: Verdana, Geneva, Arial, Helvetica, sans-serif; font-size: 11px; color: #666; white-space: nowrap;}
        .dtree img 				{border: 0px; vertical-align: middle;}
        .dtree a 				{color: #333; text-decoration: none;}
        .dtree a.node			{white-space: nowrap; padding: 1px 2px 1px 2px;}
        .dtree a.nodeSel 		{white-space: nowrap; padding: 1px 2px 1px 2px;}
        .dtree a.node:hover		{color: #333; text-decoration: underline;}
        .dtree a.nodeSel:hover	{color: #333; text-decoration: underline;}
        .dtree .clip 			{overflow: hidden;}
		
		input,select,textarea   {font-size: 11px; font-family: verdana,arial;}
	</style>
	
	
	<script language="javascript" type="text/javascript">
	function getHelp(){
		<%=Dynamicweb.Gui.Help("", "ecom.permissions", "en") %>
	}

	function changeView() {
		if (document.getElementById("permissionUserSelector").style.display == 'none') {
			document.getElementById("permissionUserSelector").style.display = '';
			var resizeWidth = 685;
			if (navigator.appName.indexOf('Microsoft') == -1) {
			    var resizeWidth = 695;
			}   
		    window.resizeTo(resizeWidth,628);
		    
		    var d = new Date();
		    ajaxLoader("EcomPermission.aspx?CMD=GetGroupStructure&DivId=permissionGroupList&Time=" + d.getMilliseconds(), "permissionGroupList")
		}
	}
	
	function getUsers(groupId) {
	    if (document.getElementById("permissionUserSelector").style.display != 'none') {
            if (groupId == "") {
                document.getElementById("permissionUserList").innerHTML = "<span class='disableText' style='margin:5px;padding:5px;'>" + SelGroupTxt + "</span>"
	        } else {
    	        var d = new Date();
                ajaxLoader("EcomPermission.aspx?CMD=GetUserStructure&groupId=" + groupId + "&DivId=permissionUserList&Time=" + d.getMilliseconds(), "permissionUserList")
	        }
        }            
	}
	
    function ajaxLoader(url,divId) {
    
        new Ajax.Updater(divId, url, {
            asynchronous: true, 
            evalScripts: true,
            method: 'get',
            
            onLoading: function(request) {
                $(divId).update("<img src='../images/ajaxloading.gif' style='text-align:center;margin:5px;padding:5px;' /> <span class='disableText'><%=Translate.JsTranslate("Requesting content...")%></span>");
            },

            onFailure: function(request) {
                $(divId).update("<br/><span class='disableText' style='text-align:center;margin:5px;padding:5px;'>Failure : "+ request.responseText +"</span>");
            },

            onComplete: function(request) {
                /*
                if (divId == "permissionUserList") {
                    permissionUserTree.openAll();
                }
                */
                //$(divId).update(request.responseText)
            },

            onSuccess: function(request) {
                /*
                if (divId == "permissionUserList") {
                    permissionUserTree.openAll();
                }
                */
                //$(divId).update(request.responseText)
                //alert(request.responseText)
            },
            
            onException: function(request) {
                $(divId).update("<br/><span class='disableText' style='margin:5px;padding:5px;'>Exception : " + request.responseText + "</span>");
            }
            
        } );

    }
	</script>
</head>

<body onload="javascript: doLoad();">
	<legend class="gbTitle"><%=Translate.Translate("Rettigheder for ")%><span runat="server" id="permissionsForObject">?</span></legend>
    <form id="form1" runat="server">
        <dw:TabHeader id="TabHeader1" runat="server" TotalWidth="350"></dw:TabHeader>

        <div id="permissionViewer" style="width:350px; float:left; font-weight:normal">
            <table class="tabTable100Large" id="DW_Ecom_tableTab">
				<tr>
					<td valign="top">
						<div id="Tab1">		                
							<div style="height:5px"></div>
							<fieldset style='width: 95%;margin:5px;'>
								<legend class="gbTitle"><%=Translate.Translate("Grupper/Brugere")%></legend>
								<div id="permissionDescription" style="float:left;margin-top:10px;margin-left:10px;width:250px;">
									<%=Translate.Translate("Change the permissions for a specific group or user.")%>
								</div>
								<div id="permissionIcon" style="float:right;margin-right:10px;">
									<img alt="" src="../images/content/ecom_user_permission.png" border="0" /> 
								</div>
								<div style="height:55px"></div>
								<div id="permissionUsersAndGroups" style="margin:0px; padding:0px; width:100%; height:150px; overflow:auto; border:1px solid #aca899;">
									<script type="text/javascript" defer="defer">
										// Create one div for each user/group that has been assigned rights for the current object
										CreateListOfCurrentRights();
									</script>
								</div>
								<div style="height:5px"></div>
								<div id="permissionButtonsA" style="float:right;">
									<input type="button" name="AddItem" onclick="changeView();" value="<%=Translate.JsTranslate("Add")%>" style="width: 80px;" />
									<input type="button" name="RemoveItem" id="buttonRemove" disabled="disabled" onclick="removeSelected();" value="<%=Translate.JsTranslate("Remove")%>" style="width: 80px;" />
								</div>          
							</fieldset>
                
							<div style="height:5px"></div>       
                
							<fieldset style='width: 95%;margin:5px;'>
								<div style="height:5px"></div>
								<div id="permissionSetting" style="margin:0px; padding:0px; width:100%; height:122px; overflow:auto; border:1px solid #aca899;">
									<table id="permissionTable" runat="server" cellpadding="0" cellspacing="0" width="90%" style="margin-left:5px;">
									</table>
								</div>
								<div style="height:5px"></div>
								<table border="0" cellpadding="2" cellspacing="0" width="100%">
									<tr>
										<td>
											<%
												Dim suppliedCMD As String = Base.Request("CMD")
												Select Case suppliedCMD
													Case "GROUPS", "SHOPLIST", "SHOP", "GROUP"
														%><input type="checkbox" value="YES" name="ApplyToChildren" id="chkApplyToChildren" /><label for="chkApplyToChildren"><%=Translate.JsTranslate("Apply to children")%></label><%
													Case Else
														%>&nbsp;<%
												End Select
											%>
										</td>
									</tr>
									<tr>
										<td align="right">
											<input type="button" name="SaveSettings" id="buttonOK" value="<%=Translate.JsTranslate("OK")%>" onclick="javascript: commandOK();" style="width: 80px;" />
											<input type="button" name="CancelSettings" id="buttonCancel" value="<%=Translate.JsTranslate("Cancel")%>" onclick="javascript: commandCancel();" style="width: 80px;" />
											<input type="button" name="GetHelp" id="buttonHelp" value="<%=Translate.JsTranslate("Help") %>" onclick="javascript: getHelp();" style="width: 80px;" />
										</td>
									</tr>
								</table>
							</fieldset>    
							<div style="height:5px"></div>
						</div>
					</td>
				</tr>
			</table>
		</div>
    
		<!-- USER / GROUP SELECTOR -->
		<div id="permissionUserSelector" style="width:283px; height:458px; float:right; display:none; cursor:pointer; border:1px solid #919B9C; background-color:White;">
			<table id="Table1" style="width:100%; height:100%;">
				<tr>
					<td valign="top">
						<div style="height:5px"></div>		
						<fieldset style='width: 94%;margin:5px;'>
							<legend class="gbTitle"><%=Translate.Translate("Select group(s) and user(s)")%></legend>
			                <div style="height:5px"></div>
			                <%=Translate.Translate("Double-click to add user or group") %>
							<div id="permissionGroupList" style="margin:0px; padding:0px; width:100%; height:170px; overflow:auto; border:1px solid #aca899;"></div>
							<div style="height:10px"></div>
							<div id="permissionUserList" style="margin:0px; padding:0px; width:100%; height:215px; overflow:auto; border:1px solid #aca899;"></div>
							<div style="height:5px"></div>	
						</fieldset>
					</td>
				</tr>
			</table>
		</div>
	</form>
	<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>