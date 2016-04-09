<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Statisticsv2_Cpl.aspx.vb" Inherits="Dynamicweb.Admin.Statisticsv2_Cpl" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
'**************************************************************************************************
'	Current version:	1.0.1
'	Created:			04-09-2003
'	Created by:			Nicolai Pedersen, np@dynamicsystems.dk
'	Last modfied:		30-06-2005
'
'	Purpose: Settings for Stat v2.
'
'	Revision history:
'		1.0.1 - 30-06-2005 - Bo Brandt - Moved to Control Panel
'		1.0.0 - 04-09-2003 - Nicolai Pedersen, np@dynamicsystems.dk
'		First version.
'**************************************************************************************************

Dim strIPFilterLegend As String = "<input type=""CheckBox"" onclick=""ToggleCustomNamer();"" name=""Statv2SettingsIPfiltering"" value=""1"" id=""both"" checked>" & Translate.Translate("IPfiltrering")

Dim Statv2SettingsAdmins As Boolean
Dim sql As String
Dim Statv2SettingsOnePv As Boolean
Dim Statv2SettingsID As Integer
Dim Statv2SettingsUserID As Integer
Dim Statv2SettingsExtranetusers As Boolean
Dim Statv2SettingsFillbar As Boolean
Dim Statv2SettingsCrawlers As Boolean
Dim Statv2SettingsIPfiltering As Boolean
Dim Statisticsv2Conn As System.Data.IDbConnection = Database.CreateConnection("Statisticsv2.mdb")
Dim sCmdStatisticsv2 As IDbCommand = Statisticsv2Conn.CreateCommand

sql = "SELECT * FROM Statv2Settings WHERE Statv2SettingsID = 1"

sCmdStatisticsv2.CommandText = sql

Dim drSettingsReader As IDataReader = sCmdStatisticsv2.ExecuteReader()

Dim opStatv2SettingsID As Integer  = drSettingsReader.getordinal("Statv2SettingsID")
Dim opStatv2SettingsUserID As Integer = drSettingsReader.getordinal("Statv2SettingsUserID")
Dim opStatv2SettingsCrawlers As Integer = drSettingsReader.getordinal("Statv2SettingsCrawlers")
Dim opStatv2SettingsAdmins As Integer = drSettingsReader.getordinal("Statv2SettingsAdmins")
Dim opStatv2SettingsOnePv As Integer = drSettingsReader.getordinal("Statv2SettingsOnePv")
Dim opStatv2SettingsExtranetusers As Integer = drSettingsReader.getordinal("Statv2SettingsExtranetusers")
Dim opStatv2SettingsIPfiltering As Integer = drSettingsReader.getordinal("Statv2SettingsIPfiltering")
Dim opStatv2SettingsFillbar As Integer = drSettingsReader.getordinal("Statv2SettingsFillbar")

If drSettingsReader.Read Then
	Statv2SettingsID = drSettingsReader(opStatv2SettingsID)
	Statv2SettingsUserID = drSettingsReader(opStatv2SettingsUserID)
	Statv2SettingsCrawlers = drSettingsReader(opStatv2SettingsCrawlers)
	Statv2SettingsAdmins = drSettingsReader(opStatv2SettingsAdmins)
	Statv2SettingsOnePv = drSettingsReader(opStatv2SettingsOnePv)
	Statv2SettingsExtranetusers = drSettingsReader(opStatv2SettingsExtranetusers)
	Statv2SettingsIPfiltering = drSettingsReader(opStatv2SettingsIPfiltering)
	Statv2SettingsFillbar = drSettingsReader(opStatv2SettingsFillbar)
End If

drSettingsReader.Dispose
sCmdStatisticsv2.Dispose

%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
	
    <dw:ControlResources ID="ctrlResources" IncludePrototype="false" runat="server" />

    <style type="text/css">
        body
        {
	        border-right:1px solid #ffffff;
        }        
    </style>

    <script type="text/javascript">

	function FilterOnLoad() {
		if (document.getElementById("Statv2SettingsIPfiltering").checked) {
			document.getElementById("Filtered").style.display = "";
		} else {
			document.getElementById("Filtered").style.display = "none";
		}
	}

	function IPRange_Edit() {
		location = 'Statisticsv2_Cpl_IPRange_Edit.aspx?filtering=' + document.getElementById("Statv2SettingsIPfiltering").checked;
	}

	function toggleFont(checkbox) {
		if (checkbox.checked) {
			document.getElementById("Filtered").style.display = "";
		} else{
			document.getElementById("Filtered").style.display = "none";
		}
	}

	function Range_Delete(intID, strName) {
		if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("IP-interval"))%>\n(' + strName + ')')==true) {
			location = 'Statisticsv2_Cpl_IPRange_Delete.aspx?Statv2ExcludeID=' + intID + '&filtering=' + document.getElementById("Statv2SettingsIPfiltering").checked;
		}
	}
	
	function IsInStatisticsModule() {
		var loc = ""+ parent.parent.right.document.location.href;
		if (loc) {
			var chkStr = ""+ loc.toLowerCase();
			if (chkStr.indexOf("statisticsv3/main.aspx") != -1) {
				return true;
			}
		}
		return false;
	} 
	function CloseStatisticsSettings(){
		if(IsInStatisticsModule()){
			parent.document.location='/Admin/Module/StatisticsV3/Main.aspx';
		}
		else{
			location = '/Admin/Module/ControlPanel.aspx';
		}
	}

    function help() {
		    <%=Dynamicweb.Gui.help("","administration.controlpanel.statisticsv2") %>
	    }

        function onSave() {
		    document.getElementById('Statv2Settings').submit();
	    }

        function onSaveAndClose() {
            document.getElementById('SaveAndClose').value='yes';
		    document.getElementById('Statv2Settings').submit();
	    }

    </script>

</head>

<body onload="FilterOnLoad()">

    <div id="PageContent" style="min-width:600px;" >

	    <form method="post" name="Statv2Settings" id="Statv2Settings" action="Statisticsv2_Cpl_Save.aspx">

            <input id="SaveAndClose" type="hidden" name="SaveAndClose" value="no" />

            <dw:Toolbar ID="ToolbarButtons" ShowStart="false" ShowEnd="false" runat="server" >
                <dw:ToolbarButton ID="cmdSave" runat="server" Image="Save" Text="Save" OnClientClick="onSave();" />
                <dw:ToolbarButton ID="cmdOk" runat="server" Divide="Before" Image="SaveAndClose" Text="Gem og luk" OnClientClick="onSaveAndClose();" />
                <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="Before"  Image="Cancel" Text="Cancel" OnClientClick="CloseStatisticsSettings();" />
                <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
            </dw:Toolbar>

            <h2 class="subtitle">
                <dw:TranslateLabel ID="lbSetup" Text="Statistik" runat="server" />
            </h2>

	        <input type="hidden" name="Statv2SettingsID" value="<%=Statv2SettingsID%>" />
	        <input type="hidden" name="Statv2SettingsUserID" value="<%=Statv2SettingsUserID%>" />
	        <input type="hidden" name="ReturnToControlPanel" value="<%="" & request("ReturnToControlPanel")%>" />
	        <input type="hidden" name="ReturnToModule" value="<%="" & request("ReturnToModule")%>" />

            <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
	            <tr>
		            <td valign="top"><br/>

			            <%=Gui.GroupBoxStart(Translate.Translate("Data"))%>
				            <table cellspacing="0" border="0" >
					            <tr>
						            <td width=170><%=Translate.Translate("Medtag")%></td>
						            <td><%=Gui.CheckBox(Statv2SettingsExtranetusers, "Statv2SettingsExtranetusers")%><%=Translate.Translate("Besøg fra extranet brugere")%></td>
					            </tr>
					            <tr>
						            <td></td>
						            <td><%=Gui.CheckBox(Statv2SettingsAdmins, "Statv2SettingsAdmins")%><%=Translate.Translate("Besøg fra brugere af administrationen")%></td>
					            </tr>
					            <tr>
						            <td></td>
						            <td><%=Gui.CheckBox(Statv2SettingsOnePv, "Statv2SettingsOnePv")%><%=Translate.Translate("Besøg fra brugere med 1 sidevisning")%></td>
					            </tr>
					            <!--tr>
						            <td></td>
						            <td><%=Gui.CheckBox(Statv2SettingsCrawlers, "Statv2SettingsCrawlers")%><%=Translate.Translate("Besøg fra søgerobotter")%></td>
					            </tr-->
					
				            </table>
			            <%=Gui.GroupBoxEnd%>
			            <%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
				            <table>
					            <tr>
						            <td width="170"></td>
						            <td><%=Gui.CheckBox(Statv2SettingsFillbar, "Statv2SettingsFillbar")%><%=Translate.Translate("Stræk grafer")%></td>
					            </tr>
				            </table>
			            <%=Gui.GroupBoxEnd%>
			            <%If Session("DW_Admin_UserID") < 3 Then %>
			            <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
			            <table width="100%">
				            <tr>
					            <td width="170">
						            <%=Translate.Translate("Remote Host Variabel")%>
					            </td>
					            <td><input id="/Globalsettings/Modules/Statistics/RemoteHostVariable" class="std" style="WHITE-SPACE: nowrap" maxlength="255" name="/Globalsettings/Modules/Statistics/RemoteHostVariable" type="text" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Modules/Statistics/RemoteHostVariable"))%>" />
					            </td>
				            </tr>
				            <tr>
					            <td width="170">
					            </td>
					            <td>
						            <%=Gui.CheckBox(Base.GetGs("/Globalsettings/Modules/Statistics/DisablePageStatistics"), "/Globalsettings/Modules/Statistics/DisablePageStatistics")%>
						            <label for="/Globalsettings/Modules/Statistics/DisablePageStatistics"><%=Translate.Translate("Disable sitemap page statistics")%>
						            </label>
					            </td>
				            </tr>
				            <tr>
					            <td width="170">
					            </td>
					            <td>
						            <%=Gui.CheckBox(Base.GetGs("/Globalsettings/Modules/Statistics/DisableStatistics"), "/Globalsettings/Modules/Statistics/DisableStatistics")%>
						            <label for="/Globalsettings/Modules/Statistics/DisableStatistics">
							            <%=Translate.Translate("Disable statistics")%>
						            </label>
					            </td>
				            </tr>
			            </table>
			            <%=Gui.GroupBoxEnd%>
			            <%end if %>
			
			            <%=Gui.GroupBoxStart(CheckBoxNot(Statv2SettingsIPfiltering, "Statv2SettingsIPfiltering", "" & request("filtering")))%>
				            &nbsp;<table width="100%" cellspacing="0" cellpadding="0" border="0" id="Filtered" style="display:none">
				            <%
				            sCmdStatisticsv2 = Statisticsv2Conn.CreateCommand

				            sql = "SELECT * FROM Statv2Exclude ORDER BY Statv2ExcludeDescription"

				            sCmdStatisticsv2.CommandText = sql

				            Dim drExcludeReader As IDataReader = sCmdStatisticsv2.ExecuteReader()
				            Dim opStatv2ExcludeID As Integer = drExcludeReader.getordinal("Statv2ExcludeID")
				            Dim opStatv2ExcludeFromIP As Integer = drExcludeReader.getordinal("Statv2ExcludeFromIP")
				            Dim opStatv2ExcludeToIP As Integer = drExcludeReader.getordinal("Statv2ExcludeToIP")
				            Dim opStatv2ExcludeDescription As Integer = drExcludeReader.getordinal("Statv2ExcludeDescription")
				            %>
					            <tr>
						            <td width="170"><strong><%=Translate.Translate("Beskrivelse")%></strong></td>
						            <td><strong><%=Translate.Translate("IP-interval")%></strong></td>
						            <td width="35"><strong><%=Translate.Translate("Slet")%></strong></td>
					            </tr> 
					            <tr><td colspan="3" bgcolor="#c4c4c4" height="1"><img alt="" height="1" src="/Admin/images/nothing.gif" /></td></tr>
				            <%Dim blnHasRows As Boolean = False

				            Do While drExcludeReader.Read
					            If Not blnHasRows Then 
						            blnHasRows = True
					            End If%>
					            <tr>
						            <td height="17"><a href="Statisticsv2_Cpl_IPRange_Edit.aspx?Statv2ExcludeID=<%=drExcludeReader(opStatv2ExcludeID)%>"><%=Server.HtmlEncode(drExcludeReader(opStatv2ExcludeDescription))%></a></td>
						            <td><%=drExcludeReader(opStatv2ExcludeFromIP)%> - <%=drExcludeReader(opStatv2ExcludeToIP)%></td>
						            <td align="center"><a href="javascript:Range_Delete(<%=drExcludeReader(opStatv2ExcludeID)%>, '<%=Server.HtmlEncode(Base.JsEnable(drExcludeReader(opStatv2ExcludeDescription)))%>');"><img src="../images/Delete.gif" border="0"></a></td>
					            </tr>
					            <tr><td colspan="3" bgcolor="#c4c4c4" height="1"><img alt="" height="1" src="/Admin/images/nothing.gif" /></td></tr>
				            <%Loop 

				            If Not blnHasRows Then%>
					            <tr>
						            <td colspan="3"><br /><strong><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("IP-intervaller"))%></strong></td>
					            </tr>
				            <%End If

				            drExcludeReader.Dispose
				            sCmdStatisticsv2.Dispose
				            Statisticsv2Conn.Dispose
				            %>
					            <tr>
						            <td colspan="3" align="right"><br />
                                    <input type="button" name="IPRangeEdit" class="std" onclick="IPRange_Edit();" value="<%=Translate.JsTranslate("Nyt IP-interval")%>" />
                                    </td>
					            </tr>
				            </table>
			            <%=Gui.GroupBoxEnd%>
		            </td>
	            </tr>
            </table>
	    </form>
    </div>

<%=Gui.SelectTab%>

</body>
</html>

<%
Translate.GetEditOnlineScript()
%>
