<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TranslationKey_Edit.aspx.vb" Inherits="Dynamicweb.Admin.TranslationKey_Edit" %>

<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lblTitle" Text="Translation key edit" runat="server" /></title>

        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" CombineOutput="false" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Management/Dictionary/Dictionary.js" />
            </Items>
        </dw:ControlResources>
        <link rel="stylesheet" type="text/css" href="Dictionary.css" />

        <script type="text/javascript">
            document.observe('dom:loaded', function () {
                Dictionary.TranslationKey_Edit.initialize();
            });

            window.onbeforeunload = function (e) {
                new window.opener.Ajax.Request(window.location.pathname, {
                    method: 'post',
                    parameters: { IsAjax: true, WindowClosed: true, IsItem: <%=IsItem.ToString.ToLower()%>, IsGlobal: <%=IsGlobal.ToString.ToLower()%>, DesignName: "<%=Base.ChkString(Base.Request("DesignName"))%>", KeyName: "<%=Base.ChkString(Server.UrlDecode(HttpContext.Current.Request("KeyName")))%>"}
                });
            };
        </script>
    </head>
    
    <style type="text/css">
        .popup-progress
        {
	        padding-top: 150px !important;
	        height: 230px !important;
        }
    </style>

    <body>
        <form id="MainForm" runat="server">
            <input type="hidden" ID="hIsNew" runat="server" value="" />
            <input type="hidden" ID="hKeyName" runat="server" value="" />

            <div class="dic_header">
                <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
	                <dw:ToolbarButton ID="cmdSave" runat="server" Divide="None" Image="Save" OnClientClick="Dictionary.TranslationKey_Edit.save()" Text="Save" />
                    <dw:ToolbarButton ID="cmdSaveAndClose" runat="server" Divide="None" Image="Save" OnClientClick="Dictionary.TranslationKey_Edit.save(true)" Text="Save and close" />
	                <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="Dictionary.TranslationKey_Edit.cancel();" />
                    <dw:ToolbarButton ID="cmdDelete" runat="server" Divide="None" Image="Delete" Text="Delete" OnClientClick="Dictionary.TranslationKey_Edit.delete();" />
	            </dw:Toolbar>

                <h2 class="subtitle">
	                <dw:TranslateLabel ID="lblEditTranslations" Text="Translation key edit in " runat="server" /><asp:label ID="lblScope" Text="" runat="server"></asp:label>
	            </h2>   
            </div>

            <div class="dic_content">
                <div id="ErrKeyNameDelete" style="display:none;">
                    <dw:Infobar ID="ErrKeyNameDeleteStr" runat ="server" Message="Can not delete nonexistent key"/>
                </div>
                <div id="ErrKeyNameExists" style="display:none;" runat="server">
                    <dw:Infobar ID="ErrKeyNameExistsStr" Type="Error" runat ="server" Message="The key with this name already exists"/>
                </div>
                <fieldset class="field_set">
                    <legend class="gbTitle"><dw:TranslateLabel ID="lblEditKeyName" Text="Key" runat="server" /></legend>
				    <table border="0" cellpadding="2" cellspacing="2" width='100%' style='width:100%'>
					    <tr>
						    <td>
							    <table border="0" cellpadding="2" cellspacing="2" width="100%">
								    <tr>
									    <td width="168px"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn" /></td>
									    <td>
				                            <div id="ErrKeyNameStr" style="color: Red; display: none;"><%=Dynamicweb.Backend.Translate.JsTranslate("A name is needed")%></div>
				                            <asp:textbox id="KeyNameStr" Width="228px" CssClass="std" runat="server" />
				                        </td>
								    </tr>
							    </table>
						    </td>
					    </tr>
				    </table>
			    </fieldset>

                <fieldset class="field_set">
                <legend class="gbTitle"><dw:TranslateLabel ID="lblTranslations" Text="Translations" runat="server" /></legend>
                <dw:EditableGrid CssClass="grid_body" HeaderStyle-CssClass="grid_header" ID="RegionsGrid" AllowMultiSelect="true" AllowAddingRows="false" AllowDeletingRows="false" ShowPaging="true" ShowTitle="false" runat="server" pagesize="10">
                    <Columns>
                        <asp:TemplateField HeaderStyle-Width="174px" ItemStyle-VerticalAlign="Top">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="CultureName"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="CultureCode"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField >
                            <ItemTemplate>
                                <asp:TextBox Style="margin-bottom:4px" Rows="4" Width="224px" TextMode="MultiLine" runat="server" ID="Value" Text="" CssClass="std"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </dw:EditableGrid>
                </fieldset>

                <div id="confirmDelete" style="display: none;"><%=Dynamicweb.Backend.Translate.JsTranslate("Delete translation key?")%></div>
                <input type="hidden" id="SubAction" name="SubAction" runat="server" value="" />
                <asp:Button id="SaveButton" style="display:none" UseSubmitBehavior="true" runat="server"></asp:Button>
		        <asp:Button id="DeleteButton" style="display:none" UseSubmitBehavior="true" runat="server"></asp:Button>
            </div>
        </form>
    </body>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
