<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NewsletterV3_cpl.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.NewsletterV3_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%=Translate.JsTranslate("NewsLetterV3")%></title>

     <dw:ControlResources ID="ctrlResources" IncludePrototype="false" runat="server" />

    <style type="text/css">
        body
        {
	        border-right:1px solid #ffffff;
        }        
    </style>

    <script type="text/javascript" src="/admin/module/newsletterv3/js/main.js"></script>

    <script type="text/javascript">

        function help() {
		    <%=Dynamicweb.Gui.help("","modules.newsletterv3.configuration") %>
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
<body">

    <div id="PageContent" style="min-width:600px;" >

        <form id="Form1" name="Form1" runat="server" >
        
            <dw:Toolbar ID="ToolbarButtons" ShowStart="false" ShowEnd="false" runat="server" >
                <dw:ToolbarButton ID="cmdSave" runat="server" Image="Save" Text="Save" OnClientClick="onSave();" />
                <dw:ToolbarButton ID="cmdOk" runat="server" Divide="Before" Image="SaveAndClose" Text="Gem og luk" OnClientClick="onSaveAndClose();" />
                <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="Before"  Image="Cancel" Text="Cancel" OnClientClick="location='ControlPanel.aspx';" />
                <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
            </dw:Toolbar>

            <h2 class="subtitle">
                <dw:TranslateLabel ID="lbSetup" Text="NewsLetterV3" runat="server" />
            </h2>

            <asp:CheckBox ID="SaveAndClose" runat="server" />

            <table border="0" cellpadding="2" cellspacing="0" class="tabTable">

            <tbody>	
		        <tr>
			        <td height="95%" valign="top">			
			
			            <dw:GroupBoxStart runat="server" ID="EmailDistributionStart" doTranslation="true"
                            Title="E-mail distribution" ToolTip="E-mail distribution" />
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tbody>
                                <tr>
                                    <td>
                                        <div id="Div_DropFolder" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Drop folder path" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="DropFolderBox" runat="server" CssClass="std"></asp:TextBox>
                                                        <asp:CustomValidator ID="DropFolderCustomValidator" OnServerValidate="ServerValidateDropFolder" ControlToValidate="DropFolderBox"
                                                            Display="Dynamic" runat="server" ErrorMessage="Directory does not exist." ForeColor="Red">
                                                        </asp:CustomValidator>

                                                        <asp:RequiredFieldValidator ID="DropFolderRequiredFieldValidator" Display="Dynamic" Runat="server" 
                                                            ErrorMessage="Path is empty" ControlToValidate="DropFolderBox" > 
                                                        </asp:RequiredFieldValidator>

                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <dw:GroupBoxEnd runat="server" ID="EmailDistributionEnd" />
                        <dw:GroupBoxStart runat="server" ID="ListsStart" doTranslation="true" Title="Lists"
                            ToolTip="Lists" />
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tbody>
                                <tr>
                                    <td>
                                        <p><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Number of rows per page" /></p>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="RecordsPerPageBox" runat="server" size="3" MaxLength="3" CssClass="std"
                                            Width="40" />
                                        <asp:RangeValidator runat="server" ID="RecordsPerPageValidator" ControlToValidate="RecordsPerPageBox"
                                            Type="Integer" MaximumValue="99" Display="Dynamic" ErrorMessage="Only numbers from 1 to 99"
                                            MinimumValue="1" />
                                        <asp:RequiredFieldValidator runat="server" ID="RecordsPerPageRequiredFieldValidator" ControlToValidate="RecordsPerPageBox"
                                            ErrorMessage = "required" Display="Dynamic"></asp:RequiredFieldValidator>
                                           
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <dw:GroupBoxEnd runat="server" ID="ListsEnd" />
                        <dw:GroupBoxStart runat="server" ID="AttachedFileTypesStart" doTranslation="true"
                            Title="Attached file types" ToolTip="Attached file types" />
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td width="250" valign="top">
                                    <asp:RadioButton ID="RadioButtonAllowed" runat="server" GroupName="AttachedFileTypes"
                                        Text="Allowed file types" />
                                </td>
                                <td>
                                    <asp:TextBox ID="AllowedTypes" runat="server" TextMode="MultiLine" Rows="5" Columns="30"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:RadioButton ID="RadioButtonAllowedExcept" runat="server" GroupName="AttachedFileTypes"
                                        Text="Allowed all file types except this" /></td>
                                <td>
                                    <asp:TextBox ID="AllowedTypesExcept" runat="server" TextMode="MultiLine" Rows="5"
                                        Columns="30"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <dw:GroupBoxEnd runat="server" ID="AttachedFileTypesEnd" />
                        <dw:GroupBoxStart ID="GroupBoxStart2" runat="server" doTranslation="true" Title="Custom fields" ToolTip="Custom fields" />
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td>
                                    <input type="button" name="cfGeneral" class="std" onclick="main.openCustomFields();" value="<%=Translate.JsTranslate("Edit custom fields")%>" />
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
