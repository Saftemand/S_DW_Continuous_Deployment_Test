<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			25-01-2006
'
'	Purpose: News control panel
'
'	Revision history:
'		1.0 - 25-01-2006 - Thomas Fekete Christensen
'		First version.
'**************************************************************************************************
%>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>

    <title><%=Translate.JsTranslate("News",9)%></title>

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
		    <%=Dynamicweb.Gui.help("","administration.controlpanel.news") %>
	    }

    	function OK_OnClick() {
		    document.getElementById('frmGlobalSettings').submit();
	    }

    </script>
</head>

<body>

    <div id="PageContent" style="min-width:600px;" >

	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">

        <input id="hiddenSource" type="hidden" name="_source" value="ManagementCenter" />

        <dw:Toolbar ID="ToolbarButtons" ShowStart="false" ShowEnd="false" runat="server" >
            <dw:ToolbarButton ID="cmdSave" runat="server" Image="Save" Text="Save" OnClientClick="findCheckboxNames(); document.getElementById('hiddenSource').value='ManagementCenterSave'; document.getElementById('frmGlobalSettings').submit();" />
            <dw:ToolbarButton ID="cmdOk" runat="server" Divide="Before" Image="SaveAndClose" Text="Gem og luk" OnClientClick="findCheckboxNames(); document.getElementById('frmGlobalSettings').submit();" />
            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="Before" Image="Cancel" Text="Cancel" OnClientClick="location='ControlPanel.aspx';" />
            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
        </dw:Toolbar>

        <h2 class="subtitle">
            <dw:TranslateLabel ID="lbSetup" Text="Audit" runat="server" />
        </h2>

        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
		    <tr>
			    <td valign="top">

                    <input type="hidden" name="CheckboxNames" />

				    <%=Gui.GroupBoxStart(Translate.Translate("Autoarkivering"))%>
					    <table border="0" cellpadding="2" cellspacing="0">
						    <tr>
							    <td width="170"><label for="/Globalsettings/Modules/News/MoveNewsToArchive"><%=Translate.Translate("Autoarkivering")%></label></td>
							    <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Modules/News/MoveNewsToArchive") = "True", "checked", "")%> id="/Globalsettings/Modules/News/MoveNewsToArchive" name="/Globalsettings/Modules/News/MoveNewsToArchive" /></td>
						    </tr>
						    <tr>
							    <td width="170"><label for="/Globalsettings/Modules/News/SetValidUntilToNever"><%=Translate.Translate("Fjern udløbsdato")%></label></td>
							    <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Modules/News/SetValidUntilToNever") = "True", "checked", "")%> id="/Globalsettings/Modules/News/SetValidUntilToNever" name="/Globalsettings/Modules/News/SetValidUntilToNever" /></td>
						    </tr>
					    </table>
				    <%=Gui.GroupBoxEnd%>

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