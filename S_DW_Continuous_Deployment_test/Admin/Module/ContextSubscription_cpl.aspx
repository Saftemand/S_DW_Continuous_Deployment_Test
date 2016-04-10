<%@ Page Language="vb" AutoEventWireup="false" Codebehind="System_cpl.aspx.vb" Inherits="Dynamicweb.Admin.ContextSubscription_cpl"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<head>
    <title><%=Translate.JsTranslate("Indholdsabonnement",9)%></title>

    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <dw:ControlResources ID="ctrlResources" IncludePrototype="false" runat="server" />

    <style type="text/css">
        body
        {
	        border-right:1px solid #ffffff;
        }
    </style>

    <script type="text/javascript">

	    function findCheckboxNames() {
            var form = document.getElementById('frmGlobalSettings');
            var _names = "";
            for (var i = 0; i < form.length; i++) {
                if (form[i].name != undefined) {
                    if (form[i].type == "checkbox") {
                        _names = _names + form[i].name + "@"
                    }
                }
            }
            form.CheckboxNames.value = _names;
        }

        function help() {
		        <%=Dynamicweb.Gui.help("","administration.controlpanel.contextsubscription") %>
	        }

    </script>

</head>

<body>

    <div id="PageContent" style="min-width:600px;" >

	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">

        <input id="hiddenSource" type="hidden" name="_source" value="ManagementCenter" />

        <%If Session("DW_Admin_UserType") < 4 Then%>        
            <dw:Toolbar ID="ToolbarButtons1" ShowStart="false" ShowEnd="false" runat="server" >
                <dw:ToolbarButton ID="cmdSave" runat="server" Image="Save" Text="Save" OnClientClick="findCheckboxNames(); document.getElementById('hiddenSource').value='ManagementCenterSave'; document.getElementById('frmGlobalSettings').submit();" />
                <dw:ToolbarButton ID="cmdOk" runat="server" Divide="Before" Image="SaveAndClose" Text="Gem og luk" OnClientClick="findCheckboxNames(); document.getElementById('frmGlobalSettings').submit();" />
                <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="Before" Image="Cancel" Text="Cancel" OnClientClick="location='ControlPanel.aspx';" />
                <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
            </dw:Toolbar>
        <%Else%>
            <dw:Toolbar ID="ToolbarButtons2" ShowStart="false" ShowEnd="false" runat="server" >
                <dw:ToolbarButton ID="cmdCancel2" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="location='ControlPanel.aspx';" />
                <dw:ToolbarButton ID="cmdHelp2" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
            </dw:Toolbar>
        <%End If%>

        <h2 class="subtitle">
            <dw:TranslateLabel ID="lbSetup" Text="Indholdsabonnement" runat="server" />
        </h2>

        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
		    <tr>
			    <td valign="top">

                    <input type="hidden" name="CheckboxNames" />

				    <%If Session("DW_Admin_UserType") < 4 Then%>
					    <%					    If Base.HasAccess("newsletter", "") Then
				        Response.Write(Gui.GroupBoxStart(Translate.Translate("Forsendelse")))
					    %>
					    <table border="0" cellpadding="2" cellspacing="0">
						    <tr>
						        <td width="170"><%=Translate.Translate("Send mail med")%></td>
						        <td><input type="radio" value="" <%=IIf(Base.GetGs("/Globalsettings/Settings/NewsletterSubscription/SaveSetting") = "", "checked", "")%> id="DWeditorOnPaste1" name="/Globalsettings/Settings/NewsletterSubscription/SaveSetting" /><label for="DWeditorOnPaste1"><%=Translate.Translate("Nyhedsbrev",9)%></label></td>
					        </tr>
					    <%If Base.HasAccess("newsletterextended", "") Then%>
					        <tr>
						        <td></td>
						        <td><input type="radio" value="newsletterextended" <%=IIf(Base.GetGs("/Globalsettings/Settings/NewsletterSubscription/SaveSetting") = "newsletterextended", "checked", "")%> id="DWeditorOnPaste2" name="/Globalsettings/Settings/NewsletterSubscription/SaveSetting" /><label for="DWeditorOnPaste2"><%=Translate.Translate("Udvidet Nyhedsbreve",9)%></label></td>
					        </tr>
					    <%End If%>
					        <tr>
						        <td height="5"></td>
					        </tr>
					    </table>
					    <%Response.Write(Gui.GroupBoxEnd)%>
					    <%End If%>
				    <%Else%>		
					    <table border="0" cellpadding="6" cellspacing="6">
						    <tr>
							    <td>
								    <%=Translate.Translate("Du har ikke adgangsrettigheder til denne del af kontrolpanelet.")%>
							    </td>
						    </tr>
					    </table>
				    <%End If%>

                </td>
            </tr>					
        </table>

	</form>
    </div>
    
</body>
</html>

<%
    Translate.GetEditOnlineScript()
%>
