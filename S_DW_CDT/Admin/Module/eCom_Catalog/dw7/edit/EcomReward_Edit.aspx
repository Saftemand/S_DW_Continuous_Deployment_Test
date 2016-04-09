<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" CodeBehind="EcomReward_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomReward_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title></title>

    	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Module/eCom_Catalog/images/ObjectSelector.css" />
                <dw:GenericResource Url="/Admin/Module/OMC/js/NumberSelector.js" />
                <dw:GenericResource Url="/Admin/Module/OMC/css/NumberSelector.css" />
            </Items>
    	</dw:ControlResources>
		<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
        <link rel="Stylesheet" type="text/css" href="../css/EcomReward_Edit.css"/>

		<script type="text/javascript" src="/Admin/FormValidation.js"></script>
		<script type="text/javascript" src="../js/EcomReward_Edit.js"></script>
    </head>
	<body>
		<asp:Literal id="BoxStart" runat="server"></asp:Literal>
		<form id="Form1" method="post" runat="server" style="padding:1px;">
            <input id="Close" type="hidden" name="Close" value="0" />
            <dw:Infobar runat="server" Visible="false" ID="NotLocalizedInfo" Type="Warning"     Message="The reward is not localized to this language. Save the reward to localize it." />
            <dw:Infobar runat="server" Visible="false" ID="NotDefaultInfo"   Type="Information" Message="To edit the reward details you need to edit the reward in the default language" />
		    <fieldset class="props-group">
                <legend class="gbTitle"><%=Translate.Translate("Indstillinger")%></legend>
                <table border="0" cellpadding="2" cellspacing="2" width="100%"> 
					<tr>
						<td class="rewardField"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn" /></td>
						<td>
				            <asp:textbox id="NameStr" CssClass="NewUIinput" runat="server"/>
                            <span id="errNameStr" style="display:none" class="error"><%=Translate.Translate("Name of reward can't be empty. Please specify name of reward")%></span>
				        </td>
					</tr>
					<tr>
						<td class="rewardField"></td>
						<td valign="top">
				            <asp:CheckBox id="activeBox" Checked="true"  runat="server" /> 
                            <label for="activeBox">
                                <dw:TranslateLabel id="tActive" runat="server" Text=" Active" />
                            </label>
				        </td>
					</tr>
					<tr>
						<td class="rewardField"><dw:TranslateLabel id="tRewardType" runat="server" Text="Reward type" /></td>
						<td>
				            <div id="errType" class="error" style="display:none"><%=Translate.Translate("Select reward type")%></div>
                            <label for="rFixed" class="radio-inline">
                                <asp:RadioButton id="rFixed" GroupName="rewardType" runat="server"  onclick='javascript:Dynamicweb.eCommerce.Loyalty.Reward.rFixed_CheckedChanged();'  />
                                <%= Translate.Translate("Fixed", True)%>
                            </label>
                            </td>
                        </tr>
                    <tr>
                        <td></td>
                        <td>
                            <label for="rPercent" class="radio-inline">
                                <asp:RadioButton  id="rPercent" GroupName="rewardType" runat="server"  onclick='javascript:Dynamicweb.eCommerce.Loyalty.Reward.rFixed_CheckedChanged();' />
                                <%= Translate.Translate("Percentage", True)%>
                            </label>
				        </td>
					</tr>
					<tr class="fix hidden">
						<td></td>
						<td>
                            <div class="form horizontal-layout">
                                <span class="label"><%= Translate.Translate("Points", True)%></span>
                                <asp:textbox CssClass="NewUIinput numbers gap-right" ID="pointsNum" runat="server"></asp:textbox>
                                <div id="errpointsNum" class="error"></div>
                            </div>
				        </td>
					</tr>
                    <tr class="percent hidden">
						<td></td>
						<td>
                            <div class="form horizontal-layout">
                                <span class="label"><%= Translate.Translate("Value", True)%></span>
                                <asp:textbox CssClass="NewUIinput numbers gap-right" TextMode="SingleLine" ID="pointsPercent" runat="server"></asp:textbox>%
                                <div id="errpointsPercent" class="error"></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <div class="form horizontal-layout">
                                <span class="label"><%= Translate.Translate("Currency", True)%></span>
                                <asp:DropDownList CssClass="NewUIinput" ID="ddCurrency" runat="server"></asp:DropDownList>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <div class="form horizontal-layout">
                                <span class="label"><%= Translate.Translate("Rounding", True)%></span>
                                <asp:DropDownList CssClass="NewUIinput" ID="ddRounding" runat="server"></asp:DropDownList>
                            </div>
				        </td>
					</tr>
				</table>
            </fieldset>

            <fieldset class="rules-list props-group">
                <legend class="gbTitle"><%= Translate.Translate("Rules")%></legend>
                <div style="padding-bottom: 4px;">
                    <dw:TranslateLabel ID="RulesHint" runat="server" Text="The reward is applied if at least one of these rules are met." />
                </div>
                <dw:EditableList ID="Rules" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false">
                </dw:EditableList>
            </fieldset>
							
		    <asp:Button id="SaveButton" style="display:none" UseSubmitBehavior="true" runat="server"></asp:Button>
		    <asp:Button id="DeleteButton" style="display:none" UseSubmitBehavior="true" runat="server"></asp:Button>

            <dw:Dialog runat="server" ID="UsageDialog" AllowDrag="true" OkAction="dialog.hide('UsageDialog');" ShowCancelButton="false" ShowClose="false" ShowOkButton="true" Title="Usage" TranslateTitle="true">
                <div>
                    <asp:Literal runat="server" ID="UsageContent" />
                </div>
            </dw:Dialog>
		</form>
		<asp:Literal id="BoxEnd" runat="server"></asp:Literal>

		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
</html>
