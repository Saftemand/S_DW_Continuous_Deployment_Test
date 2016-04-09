<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditPublishing.aspx.vb" Inherits="Dynamicweb.Admin.EditPublishing" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="expires" content="Wed, 20 Feb 2000 08:30:00 GMT" />
    <meta http-equiv="Pragma" content="no-cache" />
    
    <link rel="Stylesheet" href="/Admin/Content/StyleSheetNewUI.css" />

    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />

    <script src="EditPublishing.js" type="text/javascript"></script>
    <link rel="Stylesheet" href="EditPublishing.css" />
    
    <script type="text/javascript">
    var _id = <%=_id%>;
    var doPreview = "<%=doPreview %>" == "True" ? true : false;
    var _cmd = "<%=_cmd%>";
    var _txt1 = '<%=Translate.JsTranslate("Udfyld venligst navn!")%>';
    var _txt2 = '<%=Translate.JsTranslate("This will save the publishing. Are you sure you want to see a preview?")%>';
    var txtConfirmMessage = '<%=Translate.JsTranslate("When saving a publishing, you will overwrite the existing templates.\nTo overwrite and backup click 'OK'.\nTo keep the existing templates click 'Cancel'.") %>';
    var helpLang = "<%=helpLang %>";
    var _alertNoSource = '<%=Translate.JsTranslate("Please, select data list")%>';
    
    InitSettings(_id, _cmd, _txt1, _txt2, _alertNoSource);
    </script>

</head>
<body class="edit" style="border-bottom:1px solid #6593CF;" onload="doInit();">
    <form id="Form1" runat="server">
        <input type="hidden" value="<%=_id%>" name="ID" id="ID"  />
        
        <dw:Ribbonbar ID="Ribbon" runat="server">
            <dw:RibbonbarTab ID="RibbonbarTab1" runat="server" Active="true" Name="XML Publishing">
                <dw:RibbonbarGroup ID="RibbonbarGroup1" runat="server" Name="Funktioner">
                    <dw:RibbonbarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="save();" ID="Save" />
                    <dw:RibbonbarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="saveAndClose();" ID="SaveAndClose" />
                    <dw:RibbonbarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="cancel();" ID="Cancel" />
                </dw:RibbonbarGroup>

                <dw:RibbonbarGroup ID="RibbonbarGroup11" runat="server" Name="Preview">
                    <dw:RibbonbarCheckbox OnClientClick="previewPublishing();" ID="preBut1" runat="server" Text="Preview" Image="Preview" Size="Large" RenderAs="Default" />
                </dw:RibbonbarGroup>  
                                
                <dw:RibbonbarGroup ID="RibbonbarGroup2" runat="server" Name="Help">
                    <dw:RibbonbarButton ID="HelpBut" runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="help();" />
                </dw:RibbonbarGroup>
            </dw:RibbonbarTab>
        </dw:Ribbonbar>

    <div id="content" style="overflow: auto; position: relative;">
        <div id="SettingLayer" style="overflow:auto;">

            <dw:GroupBox ID="GroupBox1" runat="server" DoTranslation="true" Title="Indstillinger">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td style="width:170px;">
                            <div class="nobr"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Name" /></div>
                        </td>
                        <td>
                            <asp:TextBox ID="pubName" runat="server" CssClass="NewUIinput" MaxLength="255"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:170px;">
                            <div class="nobr"><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Data list" /></div>
                        </td>
                        <td>
                            <asp:DropDownList id="pubView" runat="server" CssClass="NewUIinput" />
                        </td>
                    </tr>                    
                </table>
            </dw:GroupBox>

            <div id="xml_1" style="">
                <dw:GroupBox ID="GroupBox3" runat="server" DoTranslation="true" Title="XML">
                    <table cellpadding="1" cellspacing="1">
                        <tr>
	                        <td style="width:170px;">
		                        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="XSLT" /></div>
	                        </td>
	                        <td>
		                        <dw:FileManager runat="server" name="pubXSLT" id="pubXSLT" Folder="Templates/DataManagement/XSLT/Publishing" ShowPreview="false" CssClass="NewUIinput" FullPath="true" />
	                        </td>
                        </tr>
                        <tr>
	                        <td style="width:170px;">
		                        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="URL" /></div>
	                        </td>
	                        <td>
		                        <asp:Literal runat="server" ID="xmlLink"></asp:Literal>
	                            <input type="hidden" ID="xmlURL" runat="server" />
	                        </td>
                        </tr>	            
                    </table>
                </dw:GroupBox>    
            </div>
    

        </div> <!-- END SETTING -->
    </div>
        
        <iframe src="about:blank" id="ContentSaveFrame" name="ContentSaveFrame" width="100%" frameborder="0" height="0" style="height:0px;"></iframe>
    
    </form>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
