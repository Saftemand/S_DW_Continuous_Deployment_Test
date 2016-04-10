<%@ Page CodeBehind="Default.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin._Default" codePage="65001"%>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>
		<dw:TranslateLabel runat="server" Text="Login" /> (Dynamicweb <%=LicenseName%>)
		</title>
		<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" IncludeScriptaculous="true"></dw:ControlResources>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="robots" content="noarchive" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta name="Cache-control" content="no-cache" />
	<meta http-equiv="Cache-control" content="no-cache" />
	<link href="DefaultNewUI.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
        var SpecifyUsernameText = "<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.Translate("Brugernavn"))%>";
        var SpecifyPasswordText = "<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.Translate("Adgangskode"))%>";
        var MissingText = "<%=Translate.JsTranslate("Please input username and password")%>";
        var waitMessage = "<%=Translate.Translate("Logging in")%>...";
	</script>
	<link href='http://fonts.googleapis.com/css?family=Ubuntu' rel='stylesheet' type='text/css' />
	<script src="Default.js" type="text/javascript"></script>
</head>
<body onload="start();init();">
<span style="color:#333333;font-weight:normal;text-align:left;font-family: arial, verdana, Microsoft JhengHei;font-size: 11px;">
	<dw:Infobar ID="infoOldVersion" runat="server" Message="" Type="Warning">
				Solution was last upgraded: <%=Me.BuildDate%>. Consider upgrade to newer version
	</dw:Infobar>
	<dw:Infobar ID="warnVersionProblem" runat="server" Message="" Type="Error">
				
	</dw:Infobar>
	<dw:Infobar ID="warnSolutionLocked" runat="server" Message="" Type="Error" Visible="false">
				<%= Base.GetGs("/Globalsettings/System/dblgnfornafemsg")%>
	</dw:Infobar>
	<dw:Infobar ID="warnTrialExpired" runat="server" Message="" Type="Error" Visible="false">
	</dw:Infobar>
    <dw:Infobar ID="warmOldUsersModuleIsUsedItisReqiuredToConvertedToNewUserManagementModule" runat="server" Message="Old user management is no longer functional. Please upgrade to new User management after login. Backend access is locked for all accounts except administrators." Type="Information" Visible="false"></dw:Infobar>
</span>	
    <div id="cookieswarning" style="background: #fffebf; margin:3px; padding: 5px; font-weight:normal;text-align:left;font-family: arial, verdana, Microsoft JhengHei;font-size: 11px;"><div><img style="float:left" src="/Admin/Images/Ribbon/icons/Small/warning.png"/></div><div><%=Translate.JsTranslate("Cookies must be enabled for using DynamicWeb")%></div></div>
	<div id="container">
	<table width="100%" style="height:100%" border="0">
	<tr>
	<td>
		<form id="login" name="login" action="" method="post" onsubmit="checkInput('Access_User_login.aspx');return true;">
			<div id="box">
                <div class="loginleft" >
			    <table border="0" cellpadding="0" cellspacing="0" id="loginTable">
				    <tr>
					    <td align="left">
						    <h1><%=Translate.Translate("Sign in to")%><br />Dynamicweb</h1>
					    </td>
				    </tr>
				    <tr>
					    <td align="left">
						    <input type="text" title="<%=Translate.Translate("Brugernavn")%>" placeholder="<%=Translate.Translate("Brugernavn")%>" value="<%=eLoginUser%>" class="input" id="Username" name="Username" onkeydown="catchThatEnter2(event);" onfocus="this.select();" /><br />
						    <div class="spacer">
						    </div>
						    <input type="password" title="<%=Translate.Translate("Kodeord")%>" placeholder="<%=Translate.Translate("Kodeord")%>" value="<%=eLoginPassword%>" class="input" id="Password" name="Password" onkeydown="catchThatEnter(event);" onfocus="this.select();" autocomplete="off" />
						    <div class="spacer">
						    </div>

 							<div id="warning" runat="server" style="display:none;">
                                <img src="warning.png" alt="warning" />
                                <span id="warningMsg" runat="server" ></span>
							</div>

							<div style="display:none;">
						    <select title="<%=Translate.Translate("Sprog")%>" id="language" name="language" class="inputLang" onchange="SetFormPath(document.getElementById('language').value);"><%= GetLanguageSelect(False)%></select>
						    <div class="spacer">
                            </div>
							</div>

						    <% If Base.GetGs("/Globalsettings/Settings/CustomerAccess/ShowAreabox") = "True" Then%>
						    <select class="inputLang" name="area" id="area" onchange="SetFormPath(document.getElementById('language').value)"><%= GetAreaSelect()%></select>
						    <div class="spacer"></div>
						    <%End If%>
						    <% 			If Not Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/CustomerAccess/HideRememberFeatures")) Then%>
						    <input <%=chka%> name="usecookiea" id="usecookiea" onclick="cookieclick();" type="checkbox" /><label for="usecookiea"> <%=Translate.Translate("Remember me on this computer")%></label><br />
							
						    <span style="display:none;">
						    <input <%=chkb%> name="usecookieb" id="usecookieb" onclick="nescafecheck();" type="checkbox" />
						    <input <%=chkAutoLogin%> name="AutoLogin" id="AutoLogin" type="checkbox" value="True" />
						    </span>
					
						    <%End If%>
					    </td>
				    </tr>
				    <tr>
						<td align="left"><a class="button orange" href="javascript:checkInput('Access_User_login.aspx');" id="loginBtn"><%=Translate.Translate("Sign in")%></a>&nbsp;&nbsp;<span id="waitingPlaceholder" style="display:none;"><img src="/Admin/Images/Progress/wait.gif" align="absmiddle" id="waiting" /></span></td>
				    </tr>
					 <tr>
						<td align="left" style="line-height:1.5em;">
						<br /><br />
						<!--b><%= Translate.Translate("Hjælp")%>:</!--b> <a href=""><%= Translate.Translate("I forgot my username or password")%></a><br /-->
						<%=GetSmallFlag() %> <a href="javascript:dialog.show('ChangeLanguage');"><%= Translate.Translate("Change language")%></a>
						</td>
				    </tr>
				
			    </table>
            </div>
			<div id="seperator" runat="server">
				<img src="seperator.png" alt="" />
			</div>
            <div class="customlogo" id="customLogo" runat="server" >
				<div id="logo2"><img src="DW_logo_200.png" style="width:200px;" alt="Dynamicweb 8 CMS" /></div>
                <div id="customLogoLicensedDiv" runat="server" >
                <p class="textontheleft" ><%= Translate.Translate("Licensed to")%>: </p>
					<div id="imageContainer">
                    <img class="customlogoimg" ID="imgPartnerLogo" runat="server" src="/x.gif" alt="" />
					</div>
                </div>
                <div id="customLogoPartnerInfoDiv" runat="server">
                    <p class="textontheleft" ><%= Translate.Translate("Partner")%>: </p>
                    <p class="partnerinfo">
                        <%=PartnerInfo%>
                    </p>
                </div>
            </div>
			</div>
			<div style="clear:both;height:12px;"></div>
			<div id="logo">
				<div style="text-align:center;margin-top:3px;font-size:xx-small;color:#CCCCCC;">
				<%=LicenseName%> version <%=Base.DWAssemblyVersionInformation%><%=IIf(Base.IsCustomSolution, " - Custom", "")%>
                <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/System/LicenseConfiguration/StagingTestLicense")), " Staging/Test License", "")%>
                <span id="IsNightly" runat="server" visible="False"> - Nightly build</span>
				</div>
			</div>
		</form>
	</td>
	</tr>
	</table>
	</div>
	
	<dw:Dialog ID="ChangeLanguage" runat="server" Title="Change language" HidePadding="true" AllowDrag="true" IsModal="true" Width="500" UseTabularLayout="true"  >
	<div id="langSelect">
		<%= GetLanguageSelect(True)%>
	</div>
	</dw:Dialog>

</body>
</html>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
	Session.Abandon()
%>