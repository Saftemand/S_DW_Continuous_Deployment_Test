<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProfileDynamicsEditor.ascx.vb" Inherits="Dynamicweb.Admin.OMC.Controls.ProfileDynamicsEditor" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>

<div id="divSelectContainer" class="omc-dynamics-edit" runat="server">
    <input type="hidden" name="ActionType" class="omc-dynamics-edit-actiontype" value="" />

    <fieldset class="omc-dynamics-edit-choice-section omc-dynamics-edit-choice-preset">
        <legend>
            <span>
                <input type="radio" id="rbPreset" name="EditType" value="Preset" />
                <label for="rbPreset"><dw:TranslateLabel ID="lbPreset" Text="Use existing preset" runat="server" /></label>
                <span>&nbsp;</span>
            </span>
        </legend>

        <div class="omc-dynamics-edit-choice-content">
            <table class="omc-dynamics-edit-form" border="0" cellspacing="0" cellpadding="0">
                <tr class="omc-dynamics-edit-form-field">
                    <td class="omc-dynamics-edit-form-field-name">
                        <dw:TranslateLabel ID="lbSelectPreset" Text="Preset" runat="server" />
                    </td>
                    <td class="omc-dynamics-edit-form-field-value">
                        <dw:TemplatedDropDownList ID="ddPresets" Width="250" ExpandableAreaWidth="300" ExpandableAreaHeight="100" OnClientDataExchange="Dynamicweb.Controls.OMC.ProfileDynamicsEditor._listDataExchange" runat="server">
                            <BoxTemplate>
                                <span class="omc-dynamics-edit-list-item"><%#Eval("Label")%></span>
                            </BoxTemplate>
                            <ItemTemplate>
                                <span class="omc-dynamics-edit-list-item"><%#Eval("Label")%></span>
                            </ItemTemplate>
                        </dw:TemplatedDropDownList>
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>

    <br />

    <fieldset class="omc-dynamics-edit-choice-section omc-dynamics-edit-choice-create">
        <legend>
            <span>
                <input type="radio" id="rbCreate" name="EditType" value="Create" />
                <label for="rbCreate"><dw:TranslateLabel ID="lbCreate" Text="Specify manually" runat="server" /></label>
                <span>&nbsp;</span>
            </span>
        </legend>

        <div class="omc-dynamics-edit-choice-content">
            <div id="divCreateConstraint" class="omc-dynamics-edit-constraint" runat="server">
                <p>
                    <dw:TranslateLabel ID="lbCreateConstraint" Text="No visitor profiles has been created. Create at least one visitor profile first. Profiles are managed in the administration interface." runat="server" /><span style="height: 10px">&nbsp;</span><a id="lnkCreateProfile" href="javascript:void(0);" 
                        runat="server"><dw:TranslateLabel ID="lbCreateNotification" Text="Open administration interface" runat="server" /></a>
                </p>
            </div>

            <div id="divCreateList" runat="server">
                <table class="omc-dynamics-edit-form" border="0" cellspacing="0" cellpadding="0">
                    <tr class="omc-dynamics-edit-form-field">
                        <td class="omc-dynamics-edit-form-field-name" valign="top">
                            <dw:TranslateLabel ID="lbSelectProfile" Text="Add profile points" runat="server" />
                        </td>
                        <td class="omc-dynamics-edit-form-field-value" valign="top">
                            <div class="omc-dynamics-edit-profiles-container">
                                <ul class="omc-dynamics-edit-profiles-header">
                                    <li class="omc-dynamics-edit-profiles-cell-profile"><span class="omc-dynamics-edit-profiles-cell-value"><dw:TranslateLabel ID="lbProfileName" Text="Profile name" runat="server" /></span></li>
                                    <li class="omc-dynamics-edit-profiles-cell-growth"><span class="omc-dynamics-edit-profiles-cell-value"><dw:TranslateLabel ID="lbProfileGrowth" Text="Points" runat="server" /></span></li>
                                </ul>

                                <div class="omc-dynamics-edit-clear"></div>

                                <div class="omc-dynamics-edit-profiles">
                                    <asp:Repeater ID="repProfiles" EnableViewState="false" runat="server">
                                        <HeaderTemplate>
                                            <ul>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <li id="lstRow" runat="server">
                                                <span id="spName" class="omc-dynamics-edit-profile-name" runat="server"></span>
                                                <div class="omc-dynamics-edit-profile-points">
                                                    <omc:Slider ID="pSlider" Width="100" MinValue="0" MaxValue="50" FillSelection="true" Mode="Default" runat="server" />
                                                </div>
                                                <div class="omc-dynamics-edit-clear"></div>
                                            </li>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>

                            <div style="height: 5px">&nbsp;</div>
                        </td>
                    </tr>
                    <tr class="omc-dynamics-edit-form-field">
                        <td class="omc-dynamics-edit-form-field-name">
                            <dw:TranslateLabel ID="lbSaveAsPreset" Text="Save as new preset" runat="server" />
                        </td>
                        <td>
                            <input type="text" name="NewPreset" value="" class="std omc-dynamics-edit-newpreset" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </fieldset>

    <div style="display: none">
        <asp:Button ID="cmdPostBack" CssClass="omc-dynamics-edit-postback" runat="server" />
    </div>

    <input type="hidden" id="hProfiles" class="omc-dynamics-edit-profiles" value="" runat="server" />
</div>