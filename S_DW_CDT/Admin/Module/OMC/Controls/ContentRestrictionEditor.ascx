<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ContentRestrictionEditor.ascx.vb" Inherits="Dynamicweb.Admin.OMC.Controls.ContentRestrictionEditor" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<div id="divSelectContainer" class="omc-restrict-edit" runat="server">
    <input type="hidden" name="ActionType" class="omc-restrict-edit-actiontype" value="" />

    <fieldset class="omc-restrict-edit-choice-section omc-restrict-edit-not-active">
        <legend>
            <span>
                <input type="radio" id="rbNotActive" name="EditType" value="Preset" />
                <label for="rbNotActive"><dw:TranslateLabel ID="lbNotActive" Text="Personalization is not active" runat="server" /></label>
                <span>&nbsp;</span>
            </span>
        </legend>
    </fieldset>
    <br />
    <fieldset class="omc-restrict-edit-choice-section omc-restrict-edit-choice-preset">
        <legend>
            <span>
                <input type="radio" id="rbPreset" name="EditType" value="Preset" />
                <label for="rbPreset"><dw:TranslateLabel ID="lbPreset" Text="Use existing preset" runat="server" /></label>
                <span>&nbsp;</span>
            </span>
        </legend>

        <div class="omc-restrict-edit-choice-content">
            <table class="omc-restrict-edit-form" border="0" cellspacing="0" cellpadding="0">
                <tr class="omc-restrict-edit-form-field">
                    <td class="omc-restrict-edit-form-field-name">
                        <dw:TranslateLabel ID="lbSelectPreset" Text="Preset" runat="server" />
                    </td>
                    <td class="omc-restrict-edit-form-field-value">
                        <dw:TemplatedDropDownList ID="ddPresets" Width="250" ExpandableAreaWidth="300" ExpandableAreaHeight="100" OnClientDataExchange="Dynamicweb.Controls.OMC.ContentRestrictionEditor._listDataExchange" runat="server">
                            <BoxTemplate>
                                <span class="omc-restrict-edit-list-item"><%#Eval("Label")%></span>
                            </BoxTemplate>
                            <ItemTemplate>
                                <span class="omc-restrict-edit-list-item"><%#Eval("Label")%></span>
                            </ItemTemplate>
                        </dw:TemplatedDropDownList>
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>
    <br />
    <fieldset class="omc-restrict-edit-choice-section omc-restrict-edit-choice-create">
        <legend>
            <span>
                <input type="radio" id="rbCreate" name="EditType" value="Create" />
                <label for="rbCreate"><dw:TranslateLabel ID="lbCreate" Text="Specify manually" runat="server" /></label>
                <span>&nbsp;</span>
            </span>
        </legend>

        <div class="omc-restrict-edit-choice-content">
            <div id="divCreateConstraint" class="omc-restrict-edit-constraint" runat="server">
                <p>
                    <dw:TranslateLabel ID="lbCreateConstraint" Text="No visitor profiles has been created. Create at least one visitor profile first. Profiles are managed in the administration interface." runat="server" /><span style="height: 10px">&nbsp;</span><a id="lnkCreateProfile" href="javascript:void(0);" 
                        runat="server"><dw:TranslateLabel ID="lbCreateNotification" Text="Open administration interface" runat="server" /></a>
                </p>
            </div>

            <div id="divCreateList" runat="server">
                <table class="omc-restrict-edit-form" border="0" cellspacing="0" cellpadding="0">
                    <tr class="omc-restrict-edit-form-field">
                        <td class="omc-restrict-edit-form-field-name" valign="top">
                            <dw:TranslateLabel ID="lbEvaluate" Text="Personalize based on" runat="server" />
                        </td>
                        <td class="omc-restrict-edit-form-field-value" valign="top">
                            <ul class="omc-restrict-unorderedlist">
                                <li class="omc-restrict-evaluationtype-primary">
                                    <input type="radio" id="EvaluationType1" name="EvaluationType" value="1" />
                                    <label for="EvaluationType1"><dw:TranslateLabel ID="lbPrimaryProfile" Text="Primary profile only" runat="server" /></label>
                                    <div class="omc-restrict-edit-clear"></div>
                                </li>
                                <li class="omc-restrict-evaluationtype-recognized">
                                    <input type="radio" id="EvaluationType0" name="EvaluationType" value="0" />
                                    <label for="EvaluationType0"><dw:TranslateLabel ID="lbRecognizedProfile" Text="Any recognized profile" runat="server" /></label>
                                    <div class="omc-restrict-edit-clear"></div>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr class="omc-restrict-edit-form-field">
                        <td class="omc-restrict-edit-form-field-name" valign="top">
                            <dw:TranslateLabel ID="lbSelectProfile" Text="" runat="server" />
                        </td>
                        <td class="omc-restrict-edit-form-field-value" valign="top">
                            <div id="fApplyModeOptions" class="omc-restrict-edit-apply-mode" runat="server">
                                <ul class="omc-restrict-unorderedlist">
                                    <li class="omc-restrict-applymode-show">
                                        <input type="radio" id="ApplyMode1" name="ApplyMode" value="1" />
                                        <label for="ApplyMode1"><dw:TranslateLabel ID="lbApplyMode1" Text="Show to selected profiles" runat="server" /></label>
                                        <div class="omc-restrict-edit-clear"></div>
                                    </li>
                                    <li class="omc-restrict-applymode-hide">
                                        <input type="radio" id="ApplyMode2" name="ApplyMode" value="2" />
                                        <label for="ApplyMode2"><dw:TranslateLabel ID="TranslateLabel2" Text="Hide to selected profiles" runat="server" /></label>
                                        <div class="omc-restrict-edit-clear"></div>
                                    </li>
                                </ul>
                            </div>
                            <div class="omc-restrict-edit-profiles-container">
                                <ul class="omc-restrict-edit-profiles-header">
                                    <li class="omc-restrict-edit-profiles-cell-profile"><span class="omc-restrict-edit-profiles-cell-value"><dw:TranslateLabel ID="lbProfileName" Text="Profile name" runat="server" /></span></li>
                                    <li class="omc-restrict-edit-profiles-cell-visibility"><span class="omc-restrict-edit-profiles-cell-value"><dw:TranslateLabel ID="lbProfileVisibility" Text="Visibility" runat="server" /></span></li>
                                </ul>
                                
                                <div class="omc-restrict-edit-clear"></div>

                                <div class="omc-restrict-edit-profiles">
                                    <asp:Repeater ID="repProfiles" EnableViewState="false" runat="server">
                                        <HeaderTemplate>
                                            <ul>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <li class='<%#If(IsLastProfile(CType(Container.DataItem, Dynamicweb.Analytics.Profiles.Profile)), "omc-restrict-edit-profile-last", string.Empty)%> <%#If(IsSelectedProfile(CType(Container.DataItem, Dynamicweb.Analytics.Profiles.Profile)), "omc-restrict-edit-profile-selected", string.Empty)%>'>
                                                <asp:Label ID="lbProfile" CssClass="omc-restrict-edit-profile-name" ToolTip='<%#System.Web.HttpUtility.HtmlAttributeEncode(Dynamicweb.Base.ChkString(Eval("Description")))%>' Text='<%#Eval("Label")%>' runat="server" />
                                                <div class="omc-restrict-edit-profile-visibility">
                                                    <%If Type = Dynamicweb.Admin.OMC.Controls.ContentRestrictionEditorRestrictionType.Restrict Then%>
                                                    <input type="checkbox" <%#Dynamicweb.Base.IIf(IsSelectedProfile(CType(Container.DataItem, Dynamicweb.Analytics.Profiles.Profile)), "checked='checked'", String.Empty)%> value='<%#Eval("Reference")%>' />
                                                    <%End If%>
                                                    <asp:DropDownList ID="ddlVisibility" Runat="server" DataTextField="Text" DataValueField="Value" Visible="<%#Type = Dynamicweb.Admin.OMC.Controls.ContentRestrictionEditorRestrictionType.Reorder %>" DataSource='<%# GetVisibilityItems(CStr(Eval("Reference")))%>' />
                                                </div>
                                                <div class="omc-restrict-edit-clear"></div>
                                            </li>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <div class="omc-restrict-edit-visibility-actions-container" style="display: none">
                                <a class="omc-restrict-edit-visibility-hide-all" title="<%= Dynamicweb.Backend.Translate.Translate(If(Type = Dynamicweb.Admin.OMC.Controls.ContentRestrictionEditorRestrictionType.Reorder, "Default for all profiles", "Click to hide all profiles")) %>" href="javascript:void(0);">
                                    <%= Dynamicweb.Backend.Translate.Translate(If(Type = Dynamicweb.Admin.OMC.Controls.ContentRestrictionEditorRestrictionType.Reorder, "Default for all", "Hide for all profiles"))%>
                                 </a>
                                <a class="omc-restrict-edit-visibility-show-all" title="<%= Dynamicweb.Backend.Translate.Translate(If(Type = Dynamicweb.Admin.OMC.Controls.ContentRestrictionEditorRestrictionType.Reorder, "Sort on top for all profiles", "Click to show all profiles")) %>" href="javascript:void(0);">
                                    <%= Dynamicweb.Backend.Translate.Translate(If(Type = Dynamicweb.Admin.OMC.Controls.ContentRestrictionEditorRestrictionType.Reorder, "Sort on top for all", "Show to all profiles"))%>
                                </a>
                            </div>
                            <div style="height: 5px">&nbsp;</div>
                        </td>
                    </tr>
                    <tr class="omc-restrict-edit-form-field">
                        <td class="omc-restrict-edit-form-field-name">
                            <dw:TranslateLabel ID="lbSaveAsPreset" Text="Save as new preset" runat="server" />
                        </td>
                        <td>
                            <input type="text" name="NewPreset" value="" class="std omc-restrict-edit-newpreset" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </fieldset>

    <div style="display: none">
        <asp:Button ID="cmdPostBack" CssClass="omc-restrict-edit-postback" runat="server" />
    </div>

    <input type="hidden" id="hProfiles" class="omc-restrict-edit-profiles" value="" runat="server" />
</div>