<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="EcomAdvExportOrderSettings_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomAdvExportOrderSettings_Edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();
        
        page.onSave = function() {                            
            if(IsValidRecipientEmails()){
                document.getElementById('MainForm').submit();            
            }
        }
        
        page.onHelp = function() {
            <%=Gui.help("", "administration.controlpanel.ecom.general") %>
        }

        function IsValidRecipientEmails(){            
            var control = document.getElementById("/Globalsettings/Ecom/Order/ExportSettings/EmailRecipientsList");
            var regex = /([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})/;
            if(control && control.value){                
                var emails = control.value.split(";");
                for(var i = 0; i < emails.length; i++){
                    if(!regex.test(emails[i])){
                        alert('Please check recipients e-mails list');
                        control.focus();
                        return false;
                    }
                }                
            }
            return true;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" >
    
    <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top" width="600px">

		            <%= Gui.GroupBoxStart(Translate.Translate("Settings"))%>
		            <table cellpadding="2" cellspacing="0" border="0">
			            <colgroup>
				            <col width="200px" />
				            <col />
			            </colgroup>
                        <tr>
				            <td><%= Translate.Translate("Enable Order export to XML")%></td>
				            <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ExportSettings/EnableOrdersExport") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Order/ExportSettings/EnableOrdersExport" name="/Globalsettings/Ecom/Order/ExportSettings/EnableOrdersExport" /></td>
			            </tr>
			            <tr>
				            <td><%= Translate.Translate("Output folder")%></td>
                            <td><%= IIf(String.IsNullOrEmpty(Base.GetGs("/Globalsettings/Ecom/Order/ExportSettings/OutputFolder")),
				                        Gui.FolderManager(Dynamicweb.Content.Management.Installation.FilesFolderName, "/Globalsettings/Ecom/Order/ExportSettings/OutputFolder"),
				                        Gui.FolderManager(Base.GetGs("/Globalsettings/Ecom/Order/ExportSettings/OutputFolder"), "/Globalsettings/Ecom/Order/ExportSettings/OutputFolder"))%></td>

			            </tr>
			            <tr>
				            <td><%= Translate.Translate("XSL file")%></td>
				            <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Ecom/Order/ExportSettings/XslFile"), Dynamicweb.Content.Management.Installation.FilesFolderName, "/Globalsettings/Ecom/Order/ExportSettings/XslFile", "xsl", True, "std", True, False)%></td>
			            </tr>
                    </table>
		            <%=Gui.GroupBoxEnd%>
                    <%= Gui.GroupBoxStart(Translate.Translate("E-mail settings"))%>
		            <table cellpadding="2" cellspacing="0" border="0">
			            <colgroup>
				            <col width="200px" />
				            <col />
			            </colgroup>
                        <tr>
                            <td><%= Translate.Translate("Enable E-mails with order")%></td>				            
                            <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ExportSettings/EnableSendExportedOrders") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Order/ExportSettings/EnableSendExportedOrders" name="/Globalsettings/Ecom/Order/ExportSettings/EnableSendExportedOrders" /></td>
                        </tr>
			            <tr>
                            <td><%= Translate.Translate("Recipient e-mails")%><br /><%= Translate.Translate("(separated by semi-colon)")%></td>
				            <td>
				                <input type="text" name="/Globalsettings/Ecom/Order/ExportSettings/EmailRecipientsList" id="/Globalsettings/Ecom/Order/ExportSettings/EmailRecipientsList" value="<%=Base.GetGs("/Globalsettings/Ecom/Order/ExportSettings/EmailRecipientsList")%>" class="std" /> 
				            </td>
                        </tr>
                        <tr>
                            <td><%= Translate.Translate("Sender name")%></td>
				            <td>
				                <input type="text" name="/Globalsettings/Ecom/Order/ExportSettings/EmailSenderName" id="Text1" value="<%=Base.GetGs("/Globalsettings/Ecom/Order/ExportSettings/EmailSenderName")%>" class="std" /> 
				            </td>
                        </tr>
                        <tr>
                            <td><%= Translate.Translate("Sender E-mail")%></td>
				            <td>
				                <input type="text" name="/Globalsettings/Ecom/Order/ExportSettings/SenderEmail" id="Text2" value="<%=Base.GetGs("/Globalsettings/Ecom/Order/ExportSettings/SenderEmail")%>" class="std" /> 
				            </td>
                        </tr>
                        <tr>
                            <td><%= Translate.Translate("Subject")%></td>
				            <td>
				                <input type="text" name="/Globalsettings/Ecom/Order/ExportSettings/EmailSubject" id="Text3" value="<%=Base.GetGs("/Globalsettings/Ecom/Order/ExportSettings/EmailSubject")%>" class="std" /> 
				            </td>
                        </tr>
                        <tr>
                            <td><%= Translate.Translate("Body")%></td>
				            <td>
				                <textarea name="/Globalsettings/Ecom/Order/ExportSettings/EmailBody" id="Text4" class="std" cols="100" rows="5"><%=Base.GetGs("/Globalsettings/Ecom/Order/ExportSettings/EmailBody")%></textarea>
				            </td>
                        </tr>                    
		            </table>
		            <%=Gui.GroupBoxEnd%>		            
                </td>
            </tr>
        </table>
    </div>

    <% Translate.GetEditOnlineScript() %>

</asp:Content>
