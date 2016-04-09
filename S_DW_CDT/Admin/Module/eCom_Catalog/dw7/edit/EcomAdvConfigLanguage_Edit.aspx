<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="EcomAdvConfigLanguage_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomAdvConfigLanguage_Edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
    .fieldsTable 
    {
        border: 0;
        width: 100%;
        border-collapse: collapse;
    }        
        
    .fieldsTable td 
    {
        padding: 3px;      
        vertical-align: top;          
        border-bottom: #efefef solid 1px; 
        border-right: #efefef solid 1px;
        text-align: center;
    }
    
    .fieldsTable td:first-child
    {
        text-align: left;
    }    
    </style>

    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();
        
        page.onSave = function() {

            document.getElementById('MainForm').submit();
        }
        
        page.onHelp = function() {
            <%=Gui.help("", "administration.controlpanel.ecom.language") %>
        }

    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server" >

    <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top" width="600px">
				<input type="hidden" name="/Globalsettings/Ecom/ProductLanguageControl/ChoicesMade" id="/Globalsettings/Ecom/ProductLanguageControl/ChoicesMade" value="True" />
				
				    <%=Gui.GroupBoxStart(Translate.Translate("Language and variant field differentiation"))%>
                        <table class="fieldsTable">
                                <col />
                                <col width="90px" />
                                <col width="90px" />
						    <tr>
							    <td><strong><%= Translate.Translate("Lock content of fields")%></strong>&nbsp;</td>
							    <td><strong><%= Translate.Translate("Lock across all languages")%></strong>&nbsp;</td>
							    <td><strong><%= Translate.Translate("Lock across all variants")%></strong>&nbsp;</td>
                                <%If Base.HasVersion("8.4.1.0") Then%>
                                    <td><strong><%= Translate.Translate("Required fields")%></strong>&nbsp;</td>
                                <%End If%>							    
						    </tr>
						    <%= GetProductField()%>					
        					<%= GetCustomProductField()%>
					    </table>
				    <%=Gui.GroupBoxEnd%>
                    <%= GetProductCategories()%>
                </td>
            </tr>
        </table>
    </div>

    <% Translate.GetEditOnlineScript() %>

</asp:Content>
