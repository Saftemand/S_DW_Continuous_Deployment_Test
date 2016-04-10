<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditNewsletterStep4.ascx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.EditNewsletterStep4" %>
<%@ Register Src="/Admin/Module/Common/ComboRepeater.ascx" TagName="ComboRepeater" TagPrefix="cc" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<script type="text/javascript">
function OnSendTypeChanged(sendTypeID)
{
    var sendNow = document.getElementById(GetSendNowId());
    var sendQueue = document.getElementById(GetSendQueueId());
    var dateSelector = document.getElementById('DateSelectorTable');
    var isNow = document.getElementById(sendTypeID + "_0").checked;    
    SetVisible(sendNow, isNow);
    SetVisible(sendQueue, !isNow);
    SetVisible(dateSelector, !isNow);
}
</script>

<tr id="rowPublish" runat="server">
    <td valign="top">
        <fieldset class="fieldset">
            <legend class='gbTitle'>
                <label class="checkbox"><asp:CheckBox runat="server" AutoPostBack="true" ID="PublishAsNews" />&nbsp;
                <dw:TranslateLabel runat="server" Text="Publish as News" /></label>
            </legend>
            <cc:ComboRepeater id="NewsCategories" Visible="false" runat="server" DataTextField="NewsCategoryName" DataValueField="ID" DropDownLabel="News Category" RequiredMessage="add at least one category, please"/>&nbsp;
       </fieldset>
   </td>
</tr>   
<tr> 
    <td valign="top">
        <dw:GroupBoxStart runat="server" ID="SendStart" doTranslation="true" Title="When to send" ToolTip="When to send"/>
            <asp:RadioButtonList runat="server" ID="SendType">
                <asp:ListItem Value="0" Text="Send now" Selected="True" />
                <asp:ListItem Value="1" Text="Send later" />
            </asp:RadioButtonList>
            <table id="DateSelectorTable">
                <tr>
                    <td id="DateTimeLabel">
                        <dw:TranslateLabel runat="server" Text="Date and time to send the newsletter" />:&nbsp;
                    </td>
                    <td>
                        <dw:DateSelector runat="server" ID="SendDate" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <br />
                        <i>
                            <dw:TranslateLabel ID="lbSchedulerRequired" Text="For this functionality to work an external scheduler must be set up and configured." runat="server" />
                        </i>
                    </td>
                </tr>
            </table>
        <dw:GroupBoxEnd runat="server" ID="SendEnd" />
    </td>
</tr>
