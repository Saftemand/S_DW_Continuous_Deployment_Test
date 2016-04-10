<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditNewsletterStep3.ascx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.EditNewsletterStep3" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.NewsLetterV3" %>
<script type="text/javascript">
    function PreviewInBrowser(text,html) 
    {
        var strWindowHeight="600";
        if(text=="" || html=="")
            strWindowHeight="350"
        window.open("", "Preview", "resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width=640,height="+ strWindowHeight +",top=10,left=10");
        var frm = document.forms["previewForm"];
        var txtTextPreview = frm.elements["txtTextPreview"];
        var txtHTMLPreview = frm.elements["txtHTMLPreview"];
        txtTextPreview.value=text;
        txtHTMLPreview.value=html;
        frm.submit();      
    }
</script>
<tr> 
  <td valign="top">
        <dw:GroupBoxStart runat="server" ID="PropertiesStart" doTranslation="true" Title="Newsletter Properties"
            ToolTip="Newsletter Properties" />
        <table cellpadding="2" cellspacing="0">
            <tr>
                <td id="SubjectLabel">
                    <dw:TranslateLabel runat="server" Text="Subject" />:
                </td>
                <td>
                    <asp:Label ID="Subject" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="leftColHigh" id="ToLabel">
                    <dw:TranslateLabel runat="server" Text="To" />:
                </td>
                <td>
                    <asp:Repeater runat="server" ID="DistributionList">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td id='Category_<%#Eval("ID")%>' class="leftCol">
                                    <%#Eval("Name")%>
                                </td>
                                <td id='Recipients_<%#Eval("ID")%>'>
                                    <%#Eval("RecipientsCount")%>
                                    <dw:TranslateLabel runat="server" Text="recipients" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                <tr>
                                <td class="leftCol" id="TotalRecipientsLabel">
                                    <strong>
                                        <dw:TranslateLabel runat="server" Text="Total" />
                                    </strong>
                                </td>
                                <td id="TotalRecipients">
                                    <strong>
                                        <%=TotalRecipients %>                                        
                                        <dw:TranslateLabel runat="server" Text="recipients" />
                                    </strong></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </td>
            </tr>
            <asp:Panel ID="EmailNewsLetterPanel" runat="server">
            <tr>
                <td id="FromLabel">
                    <dw:TranslateLabel runat="server" Text="From" />:
                </td>
                <td>
                    <asp:Label ID="From" runat="server" />
                </td>
            </tr>
            </asp:Panel>
            <tr>
                <td id="EncodingLabel">
                    <dw:TranslateLabel runat="server" Text="Encoding" />:
                </td>
                <td>
                    <asp:Label ID="Encoding" runat="server" />
                </td>
            </tr>
            <tr>
                <td id="FormatLabel">
                    <dw:TranslateLabel runat="server" Text="Format" />:
                </td>
                <td>
                    <asp:Label ID="Format" runat="server" />
                </td>
            </tr>
        </table>
      <dw:GroupBoxEnd runat="server" ID="PropertiesEnd" />
  </td>
</tr>
<tr runat="server" id="AttachmentsRow"> 
  <td valign="top">
      <dw:GroupBoxStart runat="server" ID="AttachmentsStart" doTranslation="true" Title="Attachments" ToolTip="Attachments"/>
      <asp:Repeater ID="Attachments" runat="server">
        <HeaderTemplate>
            <table width="100%" cellpadding="0" cellspacing="2">
                <tr>
                    <td id="FileLabel" class="border_bot"><strong><dw:TranslateLabel runat="server" Text="File" /></strong></td>
                    <td id="SizeLabel" align="right" class="border_bot"><strong><dw:TranslateLabel runat="server" Text="Size" /></strong></td>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td id='Attach_<%#Eval("PathEncoded")%>'>
                    <img src="Img/Attachment.gif" width="16" height="16" style="border: 0; vertical-align: middle;" alt="" />
                    <%#Eval("Name")%>
                </td>
                <td align="right">
                    <%#Eval("Size")%>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
                <tr>
                <td align="right" class="border_top"><strong><dw:TranslateLabel runat="server" Text="Total" /></strong></td>
                <td align="right" class="border_top"><strong><%=TotalSize%></strong></td>
                </tr>
            </table>      
        </FooterTemplate>
      </asp:Repeater>
      <dw:GroupBoxEnd runat="server" ID="AttachmentsEnd" />
  </td>
</tr>
<tr runat="server" id="ButtonsRow"> 
  <td valign="top">
    <dw:GroupBoxStart runat="server" ID="ButtonsStart" doTranslation="true" Title="Preview & Test" ToolTip="Preview & Test"/>
        <table border="0" cellpadding="2" cellspacing="0" style="margin: 0 auto;">
            <tr>
                <td align="right">
                    <asp:Button runat="server" ID="PreviewBrowser" Text="Preview in browser" CssClass="buttonSubmit" />
                </td>
                <td align="right">
                    <asp:Button runat="server" ID="PreviewOutlook" Text="Preview in Outlook" CssClass="buttonSubmit" />
                </td>
                <td align="right">
                    <asp:Button runat="server" ID="Test" Text="Test" CssClass="buttonSubmit" />
                </td>
            </tr>
        </table>
    <dw:GroupBoxEnd runat="server" ID="ButtonsEnd" />
  </td>
</tr>
