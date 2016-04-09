<%@ Page Language="vb" AutoEventWireup="false" Codebehind="NewsV2_cpl.aspx.vb" Inherits="Dynamicweb.Admin.NewsV2.NewsV2_cpl" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title><%=Translate.JsTranslate("NewsV2")%></title>
    
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <dw:ControlResources ID="ctrlResources" IncludePrototype="false" runat="server" />

    <style type="text/css">
        body
        {
	        border-right:1px solid #ffffff;
        }        
    </style>

    <script type="text/javascript" src="/admin/module/newsv2/js/main.js"></script>

    <script type="text/javascript">

        function help() {
		    <%=Dynamicweb.Gui.help("","modules.newsv2.configuration") %>
	    }

        function onSave() {
		    var elemForm = document.getElementById('<%=Form1.ClientID%>');
		    if (elemForm != null) {
		        elemForm.submit();
		    }
	    }

        function onSaveAndClose() {

            var elemCheckBox = document.getElementById('<%=SaveAndClose.ClientID%>');
		    if (elemCheckBox != null) {
		        elemCheckBox.checked = true;
		    }
		    
            var elemForm = document.getElementById('<%=Form1.ClientID%>');
		    if (elemForm != null) {
		        elemForm.submit();
		    }

	    }

    </script>

</head>

<body>

    <div id="PageContent" style="min-width:600px;" >

        <form id="Form1" name="Form1" runat="server" >
        
            <dw:Toolbar ID="ToolbarButtons" ShowStart="false" ShowEnd="false" runat="server" >
                <dw:ToolbarButton ID="cmdSave" runat="server" Image="Save" Text="Save" OnClientClick="onSave();" ShowWait="true" WaitTimeout="1000" />
                <dw:ToolbarButton ID="cmdOk" runat="server" Divide="Before" Image="SaveAndClose" Text="Gem og luk" OnClientClick="onSaveAndClose();" ShowWait="true" />
                <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="Before"  Image="Cancel" Text="Cancel" OnClientClick="location='ControlPanel.aspx';" ShowWait="true" />
                <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
            </dw:Toolbar>

            <h2 class="subtitle">
                <dw:TranslateLabel ID="lbSetup" Text="NewsV2" runat="server" />
            </h2>

            <asp:CheckBox ID="SaveAndClose" runat="server" />

            <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
                <tbody>
                    <tr>
                        <td height="95%" valign="top">

                            <dw:GroupBoxStart ID="GroupBoxStart1" runat="server" doTranslation="true" Title="RSS Display Cache" ToolTip="RSS Display Cache" />
                            <table border="0" cellpadding="2" cellspacing="0">
                                <tr>
                                    <td class="leftCol">
                                        <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Cached for (minutes)" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NewsRssCacheTime" runat="server" MaxLength="3" CssClass="std"
                                            Width="40"></asp:TextBox>&nbsp;
                                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="NewsRssCacheTime"
                                            Type="Integer" MaximumValue="99" Display="Dynamic" ErrorMessage="Only numbers from 1 to 99"
                                            MinimumValue="1"></asp:RangeValidator>
                                    </td>
                                </tr>
                            </table>
                            <dw:GroupBoxEnd runat="server" ID="GroupBoxEnd2" />
				            
					            <%=Gui.GroupBoxStart(Translate.Translate("Autoarkivering"))%>
						            <table border="0" cellpadding="2" cellspacing="0">
							            <tr>
								            <td class="leftCol"><label for="MoveNewsToArchive"><%=Translate.Translate("Autoarkivering")%></label></td>
								            <td><asp:CheckBox runat="server" ID="MoveNewsToArchive" /></td>
							            </tr>
							            <tr>
								            <td class="leftCol"><label for="SetValidUntilToNever"><%=Translate.Translate("Fjern udløbsdato")%></label></td>
								            <td><asp:CheckBox runat="server" ID="SetValidUntilToNever" /></td>
							            </tr>
										<tr>
								            <td class="leftCol"><label for="SetValidDays"><%=Translate.Translate("Standard udløbsdato")%></label></td>
								            <td><asp:TextBox runat="server" ID="SetValidDays" CssClass="std" style="width:25px;" /><%=Translate.Translate("Dage")%> (<small>0 = <%=Translate.Translate("Aldrig")%></small>)</td>
							            </tr>
						            </table>
					            <%=Gui.GroupBoxEnd%>
				            
                               <dw:GroupBoxStart ID="GroupBoxStart2" runat="server" doTranslation="true" Title="Custom fields" ToolTip="Custom fields" />
                            <table border="0" cellpadding="2" cellspacing="0">
                                <tr>
                                    <td>
                                        <input type="button" name="cfGeneral" class="std" onclick="main.openCustomFields();" value="<%=Translate.JsTranslate("Edit custom fields")%>" />
                                    </td>
                                </tr>
                                  <tr>
                                    <td>
                                        <input type="button" name="cfGroups" class="std" onclick="main.openCustomFieldsSpecific();" value="<%=Translate.JsTranslate("Edit custom field groups")%>" />
                                    </td>
                                </tr>
                            </table>
                            <dw:GroupBoxEnd runat="server" ID="GroupBoxEnd3" />
                        </td>
                    </tr>

                </tbody>
            </table>

        </form>
    </div>

<%=Gui.SelectTab%>    

</body>
</html>

<%
    Translate.GetEditOnlineScript()
%>
