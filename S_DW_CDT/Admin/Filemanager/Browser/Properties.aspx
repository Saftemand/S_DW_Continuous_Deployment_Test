<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Properties.aspx.vb" Inherits="Dynamicweb.Admin.PropertiesForm" %>

<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
        <dw:TranslateLabel ID="lbTitle" Text="Properties" runat="server" />
    </title>
    <script type="text/javascript" src="ZeroClipboard.js"></script>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />
    <style type="text/css">
        table.gbTab
        {
            width: 100%;
        }
        
        table.gbTab tr
        {
            vertical-align: top;
        }
        
        table.gbTab tr td.col
        {
            width: 170px;
        }
        
        div.smallText
        {
            font-size: 8pt;
        }
        
        div.panel
        {
            padding-bottom: 10px;
        }
        h2
        {
            margin-left: 10px;
        }
    </style>
    <script type="text/javascript">
        function Close() {
            window.close();
        }
        function ShowGeneralTab() {
            $('GeneralTab').style.display = '';
            $('ReferencesTab').style.display = 'none';
        }
        function ShowReferencesTab() {
            $('GeneralTab').style.display = 'none';
            $('ReferencesTab').style.display = '';
        }
        function cc(objRow) { //Change color of row when mouse is over... (ChangeColor)
            objRow.style.backgroundColor = '#E1DED8';
        }

        function ccb(objRow) { //Remove color of row when mouse is out... (ChangeColorBack)
            objRow.style.backgroundColor = '';
        }

        function metadata() {
            var width = 650;
            var height = 492;

            var qs = Object.toQueryString({
                'file': '<%= HttpUtility.UrlEncode(Path) %>'
            });

            metadata_window = window.open("/Admin/Filemanager/Metadata/EditMetadata.aspx?" + qs, "", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,minimize=no,width=" + width + ",height=" + height + ",left=100 ,top=100");
            metadata_window.focus();
        }

        var clip = new ZeroClipboard();
        clip.setText('<%=LiteralPath.Text %>');

        function copyToClipboard(maintext) {
            maintext = 'dfgdfg';
            if (window.clipboardData)
                window.clipboardData.setData("Text", maintext);
            else if (window.netscape) {
                 var clipboarddiv=document.getElementById('divclipboardswf');  
                 if(clipboarddiv==null)  
                 {  
                    clipboarddiv=document.createElement('div');  
                    clipboarddiv.setAttribute("name", "divclipboardswf");  
                    clipboarddiv.setAttribute("id", "divclipboardswf");  
                    document.body.appendChild(clipboarddiv);  
                 }  
                    clipboarddiv.innerHTML='<embed src="clipboard.swf" FlashVars="clipboard='+
             encodeURIComponent(maintext) + '" width="0" height="0" type="application/x-shockwave-flash"></embed>';  
                 }  
                 alert('The text is copied to your clipboard...');  
            return true;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divToolbar">
        <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="cmdClose" runat="server" Divide="None" ImagePath="../../images/Ribbon/Icons/Small/Cancel.png"
                Text="Close" OnClientClick="Close();">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ShowGeneralTab" runat="server" Divide="None" ImagePath="../../images/Ribbon/Icons/Small/preferences.png"
                Text="General" OnClientClick="ShowGeneralTab();">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ShowReferencesTab" runat="server" Divide="None" ImagePath="../../Images/Icons/Module_LinkSearch_small.png"
                Text="References" OnClientClick="ShowReferencesTab();">
            </dw:ToolbarButton>
             <dw:ToolbarButton ID="MetadataButton" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Module_Metadata_small.gif"
                Text="Metatags" OnClientClick="metadata();">
            </dw:ToolbarButton>
        </dw:Toolbar>
    </div>
    <div id="GeneralTab" runat="server">
        <div style="display: inline-block; vertical-align: middle;">
            <span style="float: left;">
                <h2>
                    <asp:Literal ID="LiteralPath" runat="server"></asp:Literal>
                </h2>
            </span>            
        </div>
        <dw:GroupBox ID="GroupBoxFileProperties" runat="server" Title="Fil" DoTranslation="true">
            <table class="gbTab" border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel1" Text="Filnavn" runat="server" />
                    </td>
                    <td>
                        <img src="" alt="Extension" id="ImgExtension" runat="server" />&nbsp;
                        <asp:Literal ID="LiteralFileName" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel2" Text="Filtype" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralFileType" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel3" Text="Placering" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralLocation" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel4" Text="Størrelse" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralSize" runat="server" />
                        bytes
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel5" Text="Oprettet" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralCreated" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel6" Text="Ændret" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralModified" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel7" Text="Tilgået" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralAccessed" runat="server" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
        <dw:GroupBox ID="GroupBoxImageProperties" runat="server" Title="Billedeoplysninger"
            DoTranslation="true">
            <table class="gbTab" border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel8" Text="Højde" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralHeight" runat="server" />
                        <dw:TranslateLabel ID="TranslateLabel9" Text="px" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel10" Text="Bredde" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralWeight" runat="server" />
                        <dw:TranslateLabel ID="TranslateLabel11" Text="px" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel12" Text="Farver" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralDepth" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel13" Text="Opløsning" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralHorizontalResolution" runat="server" />x
                        <asp:Literal ID="LiteralVerticalResolution" runat="server" />
                        dpi
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel14" Text="Farve type" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralColorSpace" runat="server" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
        <dw:GroupBox ID="GroupBoxSWFProperties" runat="server" Title="Billede" DoTranslation="true">
            <table class="gbTab" border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel15" Text="Højde" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralSWFHeight" runat="server" />
                        <dw:TranslateLabel ID="TranslateLabel16" Text="px" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel17" Text="Bredde" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralSWFWidth" runat="server" />
                        <dw:TranslateLabel ID="TranslateLabel18" Text="px" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="col">
                        <dw:TranslateLabel ID="TranslateLabel19" Text="Farver" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="LiteralSWFDepth" runat="server" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
        <dw:GroupBox ID="GroupBoxImagePreview" runat="server" Title="Preview" DoTranslation="true">
            <img alt="ImagePreview" src="" id="ImagePreview" runat="server" />
        </dw:GroupBox>
    </div>
    <div id="ReferencesTab" runat="server">
        <dw:GroupBox ID="GroupBox1" runat="server" Title="Referencesøgning" DoTranslation="true">
            <asp:Button ID="SearchReferences" runat="server" /><br /><br />
            <dw:TranslateLabel ID="NoResourceFound" runat="server" Text="Der_er_ingen_resultater_at_vise." Visible="false" />
        </dw:GroupBox>
        <!-- Page resources-->
        <dw:GroupBox ID="GroupBoxPage" runat="server" Visible=false>
            <asp:Repeater ID="RepeaterPage" runat="server">
                <HeaderTemplate>
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr onmouseout="ccb(this)" onmouseover="cc(this)" style="">
                        <td width="20" align="right">
                        <%# DataBinder.Eval(Container.DataItem, "Image")%>                            
                            &nbsp;
                        </td>
                        <td>
                            <span title="ID : <%# DataBinder.Eval(Container.DataItem, "ID")%>&#10;<%# DataBinder.Eval(Container.DataItem, "Title")%>">
                                <%# DataBinder.Eval(Container.DataItem, "Validateimage")%>
                                <a target="_blank" href="<%# DataBinder.Eval(Container.DataItem, "Link")%>">
                                    <%# DataBinder.Eval(Container.DataItem, "Linkname")%></a></span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr size="1" style="color: #e1ded8">
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:Repeater>
        </dw:GroupBox>
        <!-- Paragraph resources-->
        <dw:GroupBox ID="GroupBoxParagraph" runat="server" Visible=false>
            <asp:Repeater ID="RepeaterParagraph" runat="server">
                <HeaderTemplate>
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr onmouseout="ccb(this)" onmouseover="cc(this)" style="">
                        <td width="20" align="right">
                            <%# DataBinder.Eval(Container.DataItem, "Image")%>
                            &nbsp;
                        </td>
                        <td>
                            <span title="ID : <%# DataBinder.Eval(Container.DataItem, "ID")%>&#10;<%# DataBinder.Eval(Container.DataItem, "Title")%>">
                                <%# DataBinder.Eval(Container.DataItem, "Validateimage")%>
                                <a target="_blank" href="<%# DataBinder.Eval(Container.DataItem, "Link")%>">
                                    <%# DataBinder.Eval(Container.DataItem, "Linkname")%></a></span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr size="1" style="color: #e1ded8">
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:Repeater>
        </dw:GroupBox>
        <!-- News resources-->
        <dw:GroupBox ID="GroupBoxNews" runat="server" Visible=false>
            <asp:Repeater ID="RepeaterNews" runat="server">
                <HeaderTemplate>
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr onmouseout="ccb(this)" onmouseover="cc(this)" style="">
                        <td width="20" align="right">
                            <%# DataBinder.Eval(Container.DataItem, "Image")%>
                            &nbsp;
                        </td>
                        <td>
                            <span title="ID : <%# DataBinder.Eval(Container.DataItem, "ID")%>&#10;<%# DataBinder.Eval(Container.DataItem, "Title")%>">
                                <%# DataBinder.Eval(Container.DataItem, "Validateimage")%>
                                <a target="_blank" href="<%# DataBinder.Eval(Container.DataItem, "Link")%>">
                                    <%# DataBinder.Eval(Container.DataItem, "Linkname")%></a></span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr size="1" style="color: #e1ded8">
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:Repeater>
        </dw:GroupBox>
        <!-- CalenderEvent resources-->
        <dw:GroupBox ID="GroupBoxCalenderEvent" runat="server" Visible=false>
            <asp:Repeater ID="RepeaterCalendarEvents" runat="server">
                <HeaderTemplate>
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr onmouseout="ccb(this)" onmouseover="cc(this)" style="">
                        <td width="20" align="right">
                            <%# DataBinder.Eval(Container.DataItem, "Image")%>
                            &nbsp;
                        </td>
                        <td>
                            <span title="ID : <%# DataBinder.Eval(Container.DataItem, "ID")%>&#10;<%# DataBinder.Eval(Container.DataItem, "Title")%>">
                                <%# DataBinder.Eval(Container.DataItem, "Validateimage")%>
                                <a target="_blank" href="<%# DataBinder.Eval(Container.DataItem, "Link")%>">
                                    <%# DataBinder.Eval(Container.DataItem, "Linkname")%></a></span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr size="1" style="color: #e1ded8">
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:Repeater>
        </dw:GroupBox>
        <!-- ShopProduct resources-->
        <dw:GroupBox ID="GroupBoxShopProduct" runat="server" Visible=false>
            <asp:Repeater ID="RepeaterShopProducts" runat="server">
                <HeaderTemplate>
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr onmouseout="ccb(this)" onmouseover="cc(this)" style="">
                        <td width="20" align="right">
                            <%# DataBinder.Eval(Container.DataItem, "Image")%>
                            &nbsp;
                        </td>
                        <td>
                            <span title="ID : <%# DataBinder.Eval(Container.DataItem, "ID")%>&#10;<%# DataBinder.Eval(Container.DataItem, "Title")%>">
                                <%# DataBinder.Eval(Container.DataItem, "Validateimage")%>
                                <a target="_blank" href="<%# DataBinder.Eval(Container.DataItem, "Link")%>">
                                    <%# DataBinder.Eval(Container.DataItem, "Linkname")%></a></span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr size="1" style="color: #e1ded8">
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:Repeater>
        </dw:GroupBox>        
    </div>
    </form>
    <%Translate.GetEditOnlineScript()%>
</body>
</html>
