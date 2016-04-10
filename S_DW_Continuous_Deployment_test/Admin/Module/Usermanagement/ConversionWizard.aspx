<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConversionWizard.aspx.vb" Inherits="Dynamicweb.Admin.UserManagement.ConversionWizard" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <dw:ControlResources runat="server" IncludeUIStylesheet="true" IncludePrototype="true" IncludeScriptaculous="true" />
	<style type="text/css">
		body
		{
			background: <%=Gui.NewUIbgColor()%>;
		}
	</style>
	
	<script type="text/javascript">
		// Wizard paging script
		var currentPageNum = 0;
		var license = '<%=license %>';
		
		function gotoNextPage() {
			stepPage(true);
		}
		function gotoPreviousPage() {
			stepPage(false);
		}
		function stepPage(forward) {
			var nextPage = currentPageNum + (forward ? 1 : -1);
			if (togglePage(nextPage, true)) {
				togglePage(currentPageNum, false);
				currentPageNum = nextPage;
				
				$('BackButton').disabled = currentPageNum <= 1;
				var isLastPage = $('Page' + (currentPageNum + 1)) || $('Page' + (currentPageNum + 1) + license) ? false : true;
				$('NextButton').disabled = isLastPage;
				$('SubmitButton').style.display = isLastPage ? 'inline' : 'none';
			}
		}
		function togglePage(pageNum, show) {
			if ($('Page' + pageNum)) {
				$('Page' + pageNum).style.display = show ? 'block' : 'none';
				return true;
		    } else if ($('Page' + pageNum + license)) {
				$('Page' + pageNum + license).style.display = show ? 'block' : 'none';
				return true;
			}
			return false;
		}
		
		function setErrorMessage(errorMessage) {
		    $('WizardDiv').style.display = 'none';
		    $('ButtonDiv').style.display = 'none';
		    $('ErrorDiv').innerText = errorMessage;
		}
	</script>

</head>
<body>
    <form id="form1" runat="server">
    <div style="max-width:600px;" >
		<dw:GroupBox runat="server" Title="User Management conversion wizard" DoTranslation="true">
			<div style="min-height:340px; margin:10px 10px 10px 10px;">
				<div style="min-height:300px; " id="WizardDiv">
					
					<!-- Intro text -->
					<div id="Page1" style="display:none;">
						<dw:TranslateLabel runat="server" Text="This wizard will help you make the transition from the Users module to the User Management module." /><br />
						<dw:TranslateLabel runat="server" Text="The transition will have an effect on the existing page permissions and you will have to be set the permissions once again." /><br />
						<dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="WARNING: You cannot change back to the previous Users module" /><br />
					</div>
					
					<!-- Intro text page 2 -->
					<div id="Page2" style="display:none;">
						<dw:TranslateLabel runat="server" Text="The User Management module works on the basis of the following principles:" /><br />
						<ul>
						    <li><dw:TranslateLabel runat="server" Text="A user should only exist once. This user can then have frontend and backend permisssion, specific module permission and so on" /></li>
						    <li><dw:TranslateLabel runat="server" Text="Users that are allowed to log in to the Dynamicweb administration will have a new setting called 'Allow backend login'. You can select this setting on all users in the database even users previously located in the Extranet group" /></li>
						</ul>
					</div>
					
					<!-- Select backend users -->
					<div id="Page3Frontend" style="display:none;">
						<dw:TranslateLabel runat="server" Text="All users have frontend access but no users have backend access in the new module" /><br />
					</div>
					<div id="Page3Backend" style="display:none;">
						<dw:TranslateLabel runat="server" Text="All users have frontend access but no users have backend access in the new module" /><br />
						<dw:TranslateLabel runat="server" Text="This wizard will automatically set backend access on all users in the group" />&nbsp;'<dw:TranslateLabel runat="server" Text="Brugere" />'<br />
					</div>
					<div id="Page3Full" style="display:none;">
						<dw:TranslateLabel runat="server" Text="All users have frontend access but no users have backend access in the new module" /><br />
						<dw:TranslateLabel runat="server" Text="Select how to initially create backend users:" /><br />
						
						<table cellpadding="3" cellspacing="3">
							<colgroup>
								<col style="vertical-align:top; " />
								<col />
							</colgroup>
							<tr>
								<td>
									<input type="radio" name="selectBackend" id="selectBackendOnGroup" value="OnGroup" checked="checked" onclick="javascript:$('SelectBackendUserSelectorDiv').style.display = 'none';" />
								</td>
								<td>
									<label for="selectBackendOnGroup">
										<span style="font-weight:bold"><dw:TranslateLabel runat="server" Text="Set backend access on the group" />&nbsp;'<dw:TranslateLabel runat="server" Text="Brugere" />'&nbsp(<dw:TranslateLabel runat="server" Text="Recommended" />)</span><br />
										<dw:TranslateLabel runat="server" Text="This means that all users in the group and underlying subgroups gets backend access, even new users that are moved to the group" />
									</label>
								</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="selectBackend" id="selectBackendOnUsers" value="OnUsers" onclick="javascript:$('SelectBackendUserSelectorDiv').style.display = 'none';" />
								</td>
								<td>
									<label for="selectBackendOnUsers">
										<span style="font-weight:bold"><dw:TranslateLabel runat="server" Text="Set backend access on each user in the group" />&nbsp;'<dw:TranslateLabel runat="server" Text="Brugere" />'</span><br />
										<dw:TranslateLabel runat="server" Text="This means that all users in the group and underlying subgroups gets backend access, even if they are moved to another group" />
									</label>
								</td>
							</tr>
							<tr>
								<td style="vertical-align:top;">
									<input type="radio" name="selectBackend" id="selectBackendManually" value="Manually" onclick="javascript:$('SelectBackendUserSelectorDiv').style.display = 'block';"/>
								</td>
								<td>
									<label for="selectBackendManually">
										<span style="font-weight:bold"><dw:TranslateLabel runat="server" Text="Manually select which users and groups should be provided with backend access" /></span>
									</label>
									<div id="SelectBackendUserSelectorDiv" style="display:none; margin: 5px 0px 0px 20px; ">
										<dw:UserSelector runat="server" ID="SelectBackendUserSelector" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="selectBackend" id="selectBackendNone" value="None" onclick="javascript:$('SelectBackendUserSelectorDiv').style.display = 'none';"/>
								</td>
								<td>
									<label for="selectBackendNone">
										<span style="font-weight:bold"><dw:TranslateLabel runat="server" Text="Do not set backend access on any users and edit the user access later under the User Management module settings" /></span><br />
									</label>
								</td>
							</tr>
						</table>
						<dw:TranslateLabel runat="server" Text="Note: You can always change the backend access settings under the User Management module settings" />
						
					</div>
					
					<!-- Problematic users -->
					<div id="Page4" style="display:none;">
						<dw:TranslateLabel runat="server" Text="In User Management user names cannot be empty and must be unique." /><br /><br />
						<div id="UniqueNamesOK">
						    <dw:TranslateLabel runat="server" Text="It seems that all your users are okay. No need to change any usernames." /><br />
						</div>
						<div id="UniqueNamesNotOK">
						    <%=CachedProblematicUsers.Count%>&nbsp;<dw:TranslateLabel runat="server" Text="of your users have names that are empty or not unique." /><br />
						    <dw:TranslateLabel runat="server" Text="These will all be placed in the user group" />&nbsp;<%=NEEDS_ATTENTION_GROUP_NAME%>'<br />
						    <dw:TranslateLabel runat="server" Text="Please change the user name of these users" /><br />
						</div>
						<script type="text/javascript">
						    var uniqueNamesOk = '<%=CachedProblematicUsers.Count = 0%>' == 'True';
						    $('UniqueNamesOK').style.display = uniqueNamesOk ? 'block' : 'none';
						    $('UniqueNamesNotOK').style.display = uniqueNamesOk ? 'none' : 'block';
						    
						</script>
					</div>
					
					<!-- Confirm -->
					<div id="Page5Frontend" style="display:none;">
						<dw:TranslateLabel runat="server" Text="You are now ready to make the transition" /><br />
						<dw:TranslateLabel runat="server" Text="The following will apply when the conversion wizard has been completed:" /><br />
						<ul>
							<li><dw:TranslateLabel runat="server" Text="All page permissions will be reset. Remember to set these again" /></li>
							<li><dw:TranslateLabel runat="server" Text="The old custom fields will be moved to a new format" /></li>
							<li><dw:TranslateLabel runat="server" Text="The previous user modules will no longer be accessible" /></li>
							<li><dw:TranslateLabel runat="server" Text="You will use the new User Management module to manage users" /></li>
						</ul>
						<dw:TranslateLabel runat="server" Text="WARNING: You cannot change back to the previous Users module" />
					</div>
					
					<div id="Page5Backend" style="display:none;">
						<dw:TranslateLabel runat="server" Text="You are now ready to make the transition" /><br />
						<dw:TranslateLabel runat="server" Text="The following will apply when the conversion wizard has been completed:" /><br />
						<ul>
							<li><dw:TranslateLabel runat="server" Text="All page permissions will be reset. Remember to set these again" /></li>
							<li><dw:TranslateLabel runat="server" Text="Users in the group" />&nbsp;'<dw:TranslateLabel runat="server" Text="Brugere" />'&nbsp;<dw:TranslateLabel runat="server" Text="will gain backend access" /></li>
							<li><dw:TranslateLabel runat="server" Text="The old custom fields will be moved to a new format" /></li>
							<li><dw:TranslateLabel runat="server" Text="The previous user modules will no longer be accessible" /></li>
							<li><dw:TranslateLabel runat="server" Text="You will use the new User Management module to manage users" /></li>
						</ul>
						<dw:TranslateLabel runat="server" Text="WARNING: You cannot change back to the previous Users module" />
					</div>
					
					<div id="Page5Full" style="display:none;">
						<dw:TranslateLabel runat="server" Text="You are now ready to make the transition" /><br />
						<dw:TranslateLabel runat="server" Text="The following will apply when the conversion wizard has been completed:" /><br />
						<ul>
							<li><dw:TranslateLabel runat="server" Text="All page permissions will be reset. Remember to set these again" /></li>
							<li><dw:TranslateLabel runat="server" Text="The selected groups and users will gain backend access" /></li>
							<li><dw:TranslateLabel runat="server" Text="The old custom fields will be moved to a new format" /></li>
							<li><dw:TranslateLabel runat="server" Text="The previous user modules will no longer be accessible" /></li>
							<li><dw:TranslateLabel runat="server" Text="You will use the new User Management module to manage users" /></li>
						</ul>
						<dw:TranslateLabel runat="server" Text="WARNING: You cannot change back to the previous Users module" />
					</div>
					
				</div>
				<div style="text-align:right; height:40px;" id="ButtonDiv">
					<input runat="server" type="button" onclick="javascript:gotoPreviousPage();" id="BackButton" />
					<input runat="server" type="button" onclick="javascript:gotoNextPage();" id="NextButton" />
					<input runat="server" type="submit" id="SubmitButton" />
				</div>
				
				<div id="CompleteDiv" >
					<dw:TranslateLabel runat="server" Text="Conversion completed successfully" /><br />
					<a href="javascript:document.location = 'Main.aspx';">
						<span style="font-weight:bold;"><dw:TranslateLabel runat="server" Text="Click here to continue to the User Management module" /></span>
					</a>
				</div>
				
				<div id="ErrorDiv"></div>
			</div>
		</dw:GroupBox>
    </div>
    </form>
    
    <script type="text/javascript">
		if ('<%=didConvert %>' == 'True') {
			$('WizardDiv').style.display = 'none';
			$('ButtonDiv').style.display = 'none';
        } else {
            debugger;
			$('CompleteDiv').style.display = 'none';
			
			if ('<%=errorMessage %>' != '') {
			    setErrorMessage('<%=errorMessage %>');
			} else {
    			gotoNextPage();
			}
		}
    </script>
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>
