<%@ Page Language="vb" AutoEventWireup="false" Codebehind="NewsLetterV3_edit.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.NewsLetterV3_edit" ValidateRequest="false" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.NewsLetterV3" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="mc" Namespace="Dynamicweb.Admin.ModulesCommon" Assembly="Dynamicweb.Admin" %>

<script src="/Admin/Module/Common/Common.js?" type="text/javascript"></script>
<script src="/Admin/Module/NewsLetterV3/NewsLetterV3_edit.aspx.js?" type="text/javascript"></script>

<input type="hidden" name="NewsLetterV3_settings" value="ShowMode,MailEncoding,UseLinkToProfilePage,LinkToProfilePage,TargetCategoriesList,RedirectPage,EnableNotification,NotifySubject,NotifyEmail,NotifyTemplate,ConfirmChanges,ConfirmErrorPage,ConfirmTypeNew,ConfirmTypeChanged,ConfirmSubject,ConfirmEmail,ConfirmTemplate,ConfirmPage,SubscribeQuickTemplate,SubscribeTemplate,AllowSelectFormat,AllowDeleteProfile,MailFormat,LoginTemplate,UsePassword,UseForgotPassword,ForgotPasswordSubject,ForgotPasswordEmail,ForgotPasswordTemplate,UnsubscribeRedirect,UnsubscribeTemplate,UnsubscribeCategoriesList,ArchiveTemplate,ArchiveNewsLetterTemplate,CustomNewUser,CustomUserChanges,CustomPasswordSuccess,CustomPasswordInvalid,CustomPasswordError,CustomConfirmNewUser,CustomConfirmChanges,CustomConfirmNewUserLink,CustomConfirmChangesLink,CustomVMIncorrect,CustomVMRequired,CustomVMUnique,CustomDeleteProfile,CustomSortSubject,CustomSortCreateDate,CustomSortSendDate,PagingUseFwdText,CustomPagingFwdText,PagingUseFwdImg,CustomPagingFwdImg,PagingUseBackText,CustomPagingBackText,PagingUseBackImg,CustomPagingBackImg,UploadDir,CustomFieldsList,CustomEmailWarning" />
<dw:ModuleHeader ID="headerModule" runat="server" ModuleSystemName="NewsLetterV3" />
<link href="/Admin/Module/Common/Stylesheet_ParSet.css" rel="stylesheet" type="text/css">
<link href="/Admin/Module/Common/Stylesheet_ParSet_NewsletterV3.css" rel="stylesheet" type="text/css">
<table border="0" cellpadding="0" width="598" cellspacing="0">
    <tr>
        <td>
            <table border="0" width="100%" cellpadding="2" cellspacing="0">
                <tr>
                    <td colspan="2">
                        
                        <!-------------- Layout -------------->
                        
                        <dw:GroupBoxStart doTranslation="true" runat="server" ID="gbLayoutStart" Title="Layout" />
                            <table cellpadding="2" cellspacing="0" border="0">
                                <tr>
                                    <td class="leftColHigh">
                                        <dw:TranslateLabel ID="lbShow" runat="server" Text="Mode" />
                                    </td>
                                    <td>
                                        <table cellspacing="0" cellpadding="0" border="0">
                                            <tr>
                                                <td>
                                                    <span style="vertical-align: middle;">
                                                        <%=CustomRadioButton(_properties.Value("ShowMode"), "ShowMode", "1", String.Format("onclick='onChangeShowMode({0});'", Dynamicweb.NewsLetterV3.Common.IsExtranetInstalled.ToString.ToLower()))%>
                                                    </span>
                                                    <label for="ShowMode1" style="vertical-align: middle;">
                                                        <dw:TranslateLabel ID="lbMode1" runat="server" Text="Subscribe" />
                                                    </label>
                                                </td>    
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span style="vertical-align: middle;">
                                                        <%=CustomRadioButton(_properties.Value("ShowMode"), "ShowMode", "3", String.Format("onclick='onChangeShowMode({0});'", Dynamicweb.NewsLetterV3.Common.IsExtranetInstalled.ToString.ToLower()))%>
                                                    </span>
                                                    
                                                    <label for="ShowMode3" style="vertical-align: middle;">
                                                        <dw:TranslateLabel ID="lbMode3" runat="server" Text="Unsubscribe" />
                                                    </label>    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                   <span id="modeSubChanges" runat="server">
                                                        <span style="vertical-align: middle;">
                                                            <%=CustomRadioButton(_properties.Value("ShowMode"), "ShowMode", "4", String.Format("onclick='onChangeShowMode({0});'", Dynamicweb.NewsLetterV3.Common.IsExtranetInstalled.ToString.ToLower()))%>
                                                        </span>
                                                        <label for="ShowMode4" style="vertical-align: middle;">
                                                            <dw:TranslateLabel ID="lbMode4" runat="server" Text="Subscription changes" />
                                                        </label>
                                                        <span id="modeSubChangesRequired" runat="server" visible="false" />
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span style="vertical-align: middle;">
                                                        <%=CustomRadioButton(_properties.Value("ShowMode"), "ShowMode", "2", String.Format("onclick='onChangeShowMode({0});'", Dynamicweb.NewsLetterV3.Common.IsExtranetInstalled.ToString.ToLower()))%>
                                                    </span>
                                                    
                                                    <label for="ShowMode2" style="vertical-align: middle;">
                                                        <dw:TranslateLabel ID="lbMode2" runat="server" Text="Archive" />
                                                    </label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="leftColHigh">
                                        <dw:TranslateLabel ID="lbEncoding" runat="server" Text="Encoding" />
                                    </td>
                                    <td>
                                        <%=Gui.EncodingList(_properties.Value("MailEncoding"), "MailEncoding", True)%>
                                    </td>
                                </tr>
                                
                                <tr id="TRUseLinkToProfilePage" runat="server">
                                    <td id="TDUseLinkToProfilePage" runat="server" class="leftColHigh">
                                        <label for="UseLinkToProfilePage">
                                            <dw:TranslateLabel ID="lbLinkToProfilePage" runat="server" Text="Rediger_profil" />
                                        </label>
                                    </td>
                                    <td>
                                        <%=Gui.CheckBox(_properties.Value("UseLinkToProfilePage"), "UseLinkToProfilePage", "onclick='javascript:onChangeUseLinkToProfile(this);'")%>
                                        <span id="TRUseLinkToProfilePageRequired" runat="server" visible="false" />
                                    </td>
                                </tr>                                
                                
                                <tr id="rowUseLinkToProfile">
                                    <td class="leftColHigh">
                                        <dw:TranslateLabel ID="lbLinkToProfilePageField" runat="server" Text="Page" />
                                    </td>
                                    <td>
                                        <dw:LinkManager DisableFileArchive="True" ID="LinkToProfilePage" runat="server" />    
                                    </td>
                                </tr>
                            </table>
                        <dw:GroupBoxEnd ID="gbLayoutEnd" runat="server" />
                        
                        <!-------------- End: Layout -------------->
                        
                        <!-------------- Subscription (Quick/Changes) -------------->
                        
                        <div id="divSubscription" style="display:">
                        <dw:GroupBoxStart ID="gbSubscriptionStart" runat="server" doTranslation="True" Title="Settings" />
                            <table cellpadding="2" cellspacing="0" border="0">
                                <tr>
                                    <td class="leftColHigh">
                                        <dw:TranslateLabel ID="lbTargetCategories" runat="server" Text="Categories" />
                                    </td>
                                    <td>
                                        <mc:ListSelector runat="server" Name="TargetCategoriesList" Columns="2" ID="TargetCategoriesListCtrl" DataTextField="Name" DataValueField="ID"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel ID="lbRedirectPage" runat="server" Text="Page for redirecting" />
                                    </td>
                                    <td>
                                        <dw:LinkManager DisableFileArchive="True" runat="server" ID="RedirectPage" />    
                                    </td>
                                </tr>
                                <tr id="rowSubscribeQuickTemplate" style="display:">
                                    <td>
                                        <dw:TranslateLabel ID="lbEditQuickTemplate" Text="Template" runat="server" />
                                    </td>
                                    <td>
                                        <dw:FileManager Folder="/Edit" ID="SubscribeQuickTemplate" runat="server" />
                                    </td>
                                </tr>
                                <tr id="rowSubscribeTemplate" style="display: none;">
                                    <td>
                                        <dw:TranslateLabel ID="lbEditTemplate" Text="Template" runat="server" />
                                    </td>
                                    <td>
                                        <dw:FileManager Folder="/Edit" ID="SubscribeTemplate" runat="server" />
                                    </td>
                                </tr>
                                <tr id="rowAllowDeleteProfile" style="display: none;" runat="server">
                                    <td>
                                        <dw:TranslateLabel ID="lbAllowDeleteProfile" runat="server" Text="Unsubscribe all categories" />
                                    </td>
                                    <td>
                                        <%=Gui.CheckBox(_properties("AllowDeleteProfile"), "AllowDeleteProfile", "")%>&nbsp;
                                        <label for="AllowDeleteProfile">
                                            <dw:TranslateLabel ID="lbAllowDelete" runat="server" Text="Allow subscriber to unsubscribe from all categories" />
                                        </label>
                                        <span id="rowAllowDeleteProfileRequired" runat="server" visible="false" />
                                    </td>
                                </tr>
                                <tr id="rowAllowSelectFormat" style="display: none;">
                                    <td>
                                        <dw:TranslateLabel ID="lbAllowSelectFormat" runat="server" Text="E-mail format" />
                                    </td>
                                    <td>
                                        <%=Gui.CheckBox(_properties("AllowSelectFormat"), "AllowSelectFormat", "")%>&nbsp;
                                        <label for="AllowSelectFormat">
                                            <dw:TranslateLabel ID="lbAllowFormat" runat="server" Text="Allow subscriber to select format" />
                                        </label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel ID="lbDefaultFormat" runat="server" Text="Default e-mail format" />
                                    </td>
                                    <td>
                                        <%=Gui.RadioButton(_properties.Value("MailFormat"), "MailFormat", "1")%>&nbsp;
                                        <label for="MailFormat1">
                                            <dw:TranslateLabel ID="lbFormatHTML" runat="server" Text="HTML" />
                                        </label>&nbsp;&nbsp;
                                        
                                        <%=Gui.RadioButton(_properties.Value("MailFormat"), "MailFormat", "2")%>&nbsp;
                                        <label for="MailFormat2">
                                            <dw:TranslateLabel ID="lbFormatText" runat="server" Text="Text" />
                                        </label>&nbsp;&nbsp;
                                    </td>
                                </tr>
                                <tr id="rowNotificationTitle" style="display: none;">
                                    <td>
                                        <label for="EnableNotification">
                                            <dw:TranslateLabel ID="lbEnableNotification" runat="server" Text="Notification" />
                                        </label>
                                    </td>
                                    <td>
                                        <%=Gui.CheckBox(_properties.Value("EnableNotification"), "EnableNotification", "onclick='javascript:onChangeUseNotification(this);'")%>
                                    </td>                                    
                                </tr>
                                <tr id="rowNotification" style="display: none;">
                                    <td colspan="2">
                                        <table border="0" cellpadding="2" cellspacing="0">
                                            <tr>
                                                <td class="leftColHigh">
                                                    <dw:TranslateLabel ID="lbNotifySubject" runat="server" Text="E-mail subject" />
                                                </td>
                                                <td>
                                                    <input id="NotifySubject" name="NotifySubject" class="std" runat="server" type="text">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="leftColHigh" style="white-space: nowrap;">
                                                    <dw:TranslateLabel ID="lbNotifyEmail" runat="server" Text="Admin e-mail" />
                                                </td>
                                                <td>
                                                    <input onchange="validateEmail(this);" id="NotifyEmail" name="NotifyEmail" runat="server" class="std" type="text">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="leftColHigh" style="white-space: nowrap;">
                                                    <dw:TranslateLabel ID="lbNotifyTemplate" runat="server" Text="Template e-mail" />
                                                </td>
                                                <td valign="top">
                                                    <dw:FileManager Folder="/Mail" runat="server" ID="NotifyTemplate" Name="NotifyTemplate" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="rowConfirmationTitle" style="display: none;">
                                    <td>
                                        <label for="ConfirmChanges">
                                            <dw:TranslateLabel ID="lbConfirmation" runat="server" Text="Confirmation" />
                                        </label>
                                    </td>
                                    <td>
                                        <%=Gui.CheckBox(_properties.Value("ConfirmChanges"), "ConfirmChanges", "onclick='javascript:onChangeUseConfirmation(this);'")%>
                                    </td>
                                </tr>
                                <tr id="rowConfirmation" style="display: none;">
                                    <td colspan="2">
                                        <table border="0" cellpadding="2" cellspacing="0">
                                            <tr>
                                                <td class="leftColHigh">
                                                    <dw:TranslateLabel ID="lbConfirmType" runat="server" Text="Type" />
                                                </td>
                                                <td>
                                                    <%=Gui.CheckBox(_properties.Value("ConfirmTypeNew"), "ConfirmTypeNew", "")%>
                                                    <label for="ConfirmTypeNew">
                                                        <dw:TranslateLabel ID="lbConfirmTypeNew" Text="New subscriber" runat="server" />
                                                    </label>&nbsp;
                                                    
                                                    <span id="confirmTypeSubChanged" runat="server">
                                                        <%=Gui.CheckBox(_properties.Value("ConfirmTypeChanged"), "ConfirmTypeChanged", "") %>
                                                        <label for="ConfirmTypeChanged">
                                                            <dw:TranslateLabel id="lbConfirmTypeChanged" Text="Subscription changed" runat="server" />
                                                        </label>
                                                        <span id="confirmTypeSubChangedRequired" runat="server" visible="false" />
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dw:TranslateLabel ID="lbConfirmSubject" Text="E-mail subject" runat="server" />
                                                </td>
                                                <td>
                                                    <input class="std" type="text" id="ConfirmSubject" name="ConfirmSubject" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dw:TranslateLabel ID="lbConfirmEmail" Text="Sender e-mail address" runat="server" />
                                                </td>
                                                <td>
                                                    <input type="text" class="std" id="ConfirmEmail" name="ConfirmEmail" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dw:TranslateLabel ID="lbConfirmTemplate" Text="E-mail template" runat="server" />
                                                </td>
                                                <td>
                                                    <dw:FileManager Folder="/Mail" ID="ConfirmTemplate" Name="ConfirmTemplate" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dw:TranslateLabel ID="lbConfirmPage" Text="Confirmation page" runat="server" />
                                                </td>
                                                <td>
                                                    <dw:LinkManager ID="ConfirmPage" DisableFileArchive="True" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dw:TranslateLabel ID="lbConfirmErrorPage" runat="server" Text="Error page" />
                                                </td>
                                                <td>
                                                    <dw:LinkManager DisableFileArchive="True" ID="ConfirmErrorPage" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        <dw:GroupBoxEnd ID="gbSubscriptionEnd" runat="server" />          
                        </div>
                        
                        <!-------------- End: Subscription (Quick/Changes) -------------->
                        
                        <!-------------- Login -------------->
                        
                        <div id="divLogin" style="display: none;" runat="server">
                            <fieldset style="margin:5px">
                                <legend class="gbTitle">
                                    <dw:TranslateLabel ID="lbLoginTitle" Text="Login" runat="server" />
                                    <span id="divLoginRequired" runat="server" visible="false" />
                                </legend>
                            
                                <table cellpadding="2" cellspacing="0" border="0">
                                    <tr>
                                        <td class="leftColHigh">
                                            <dw:TranslateLabel ID="lbLoginTemplate" runat="server" Text="Login template" />
                                        </td>
                                        <td>
                                            <dw:FileManager Folder="/Login" runat="server" ID="LoginTemplate" Name="LoginTemplate" />
                                        </td>
                                    </tr>
                                    <tr>
                                         <td>
                                            <label for="UsePassword">
                                                <dw:TranslateLabel ID="lbUsePassword" runat="server" Text="Use password" />
                                            </label>
                                        </td>
                                        <td>
                                            <%=Gui.CheckBox(_properties.Value("UsePassword"), "UsePassword", "onclick='Javascript:onChangeUsePassword(this);'")%>
                                        </td>
                                    </tr>    
                                    <tr id="rowUsePassword" style="display: none;">
                                        <td class="leftColHigh">
                                            <label for="UseForgotPassword">
                                                <dw:TranslateLabel ID="blUseForgotPassword" runat="server" Text="Forgot password" />
                                            </label>
                                        </td>
                                        <td>
                                            <%=Gui.CheckBox(_properties.Value("UseForgotPassword"), "UseForgotPassword", "onclick='Javascript:onChangeUseForgotPassword(this);'")%>
                                        </td>
                                    </tr>
                                    <tr id="rowUseForgotPassword" style="display: none;">
                                        <td colspan="2">
                                            <table cellspacing="0" cellpadding="2" border="0">
                                                <tr>
                                                     <td class="leftColHigh">
                                                        <dw:TranslateLabel ID="lbForgotSubject" runat="server" Text="E-mail subject" />
                                                    </td>
                                                    <td>
                                                        <input name="ForgotPasswordSubject" id="ForgotPasswordSubject" runat="server" class="std" type="text" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                     <td>
                                                        <dw:TranslateLabel ID="lbForgotEmail" runat="server" Text="Sender e-mail address" />
                                                    </td>
                                                    <td>
                                                        <input onchange="validateEmail(this);" name="ForgotPasswordEmail" id="ForgotPasswordEmail" runat="server" class="std" type="text" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                     <td>
                                                        <dw:TranslateLabel ID="lbForgotTemplate" runat="server" Text="Template - e-mail" />
                                                    </td>
                                                    <td valign="top">
                                                        <dw:FileManager Folder="/Login" runat="server" ID="ForgotPasswordTemplate" Name="ForgotPasswordTemplate" />
                                                    </td>
                                                </tr>    
                                            </table>
                                        </td>
                                    </tr>
                                </table>    
                            </fieldset>
                        </div>
                        
                        <!-------------- End: Login -------------->
                        
                        <!-------------- Unsubscribe -------------->
                        
                        <div id="divUnSubscription" style="display: none;">
                            <dw:GroupBoxStart ID="gbUnsubscribeStart" runat="server" Title="Settings" />
                                <table cellspacing="0" cellpadding="2" border="0">
                                    <tr>
                                    <td class="leftColHigh">
                                        <dw:TranslateLabel ID="lbUnSubscribeCategories" runat="server" Text="Categories" />
                                    </td>
                                    <td>
                                        <mc:ListSelector runat="server" Name="UnsubscribeCategoriesList" Columns="2" ID="UnsubscribeCategoriesListCtrl" DataTextField="Name" DataValueField="ID"/>
                                    </td>
                                </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbUnsubscribeRedirect" runat="server" Text="Page for redirecting" />
                                        </td>
                                        <td>
                                            <dw:LinkManager DisableFileArchive="True" runat="server" ID="UnsubscribeRedirect" />    
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbUnsubscribeTemplate" runat="server" Text="Template" />
                                        </td>
                                        <td>
                                            <dw:FileManager Folder="/Edit" ID="UnsubscribeTemplate" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            <dw:GroupBoxEnd ID="gbUnsubscribeEnd" runat="server" />
                        </div>
                        
                        <!-------------- End: Unsubscribe -------------->
                        
                        <!-------------- Archive -------------->
                        
                        <div id="divArchive" style="display: none;">
                            <dw:GroupBoxStart ID="gbArchiveStart" runat="server" Title="Settings" />
                                <table cellspacing="0" cellpadding="2" border="0">
                                    <tr>
                                    <td class="leftColHigh">
                                        <dw:TranslateLabel ID="lbArchiveTemplate" runat="server" Text="Archive template" />
                                    </td>
                                    <td>
                                        <dw:FileManager Folder="/Archive" runat="server" ID="ArchiveTemplate" Name="ArchiveTemplate" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel ID="lbArchiveNLTemplate" runat="server" Text="Newsletter template" />
                                    </td>
                                    <td valign="top">
                                        <dw:FileManager Folder="/Archive" runat="server" ID="ArchiveNewsLetterTemplate" Name="ArchiveNewsLetterTemplate" />
                                    </td>
                                </tr>
                                </table>
                            <dw:GroupBoxEnd ID="gbArchiveEnd" runat="server" />
                        </div>
                        
                        <!-------------- End: Archive -------------->
                        
                        <!-------------- Custom texts -------------->
                        
                        <div id="divCustomTexts">
                            <dw:GroupBoxStart ID="GroupBoxStartCustomTexts" runat="server" Title="Brugerdefinerede_tekster" />                            
                                <table style="display:none;" id="tabCustomTextsNotification" cellspacing="0" cellpadding="2" border="0">
                                    <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <!----------- Notification ----------->                                                                                                          
                                    <tr>
                                        <td class="leftColHigh"><strong>
                                            <dw:TranslateLabel ID="lbAdminNotfy" Text="Notification" runat="server" />
                                        </strong></td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomNewUser" Text="New user" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomNewUser" name="CustomNewUser" runat="server" />
                                        </td>
                                    </tr>                                   
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomUserChanges" Text="Changes" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomUserChanges" name="CustomUserChanges" runat="server" />
                                        </td>
                                    </tr>
                                  </table>
                                  
                                  <!----------- End: Notification ----------->
                                  
                                  <!----------- Confirmation ----------->
                                  
                                  <table style="display:none;" id="tabCustomTextsConfirmation" cellspacing="0" cellpadding="2" border="0">
                                    <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="leftColHigh"><strong>
                                            <dw:TranslateLabel ID="lbConfirm" Text="Confirmation" runat="server" />
                                        </strong></td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbConfirmSMNewUser" Text="New user" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" id="CustomConfirmNewUser" name="CustomConfirmNewUser" runat="server" class="std" />
                                        </td>
                                    </tr>
                                    <tr id="rowCustomConfirmChanges" runat="server">
                                        <td>
                                            <dw:TranslateLabel ID="lbConfirmUserChange" Text="Changes" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" runat="server" id="CustomConfirmChanges" name="CustomConfirmChanges" />
                                            <span id="rowCustomConfirmChangesRequired" runat="server" visible="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbConfirmNewUserLabel" Text="New user link" runat="server"  />
                                        </td>
                                        <td>
                                            <input id="CustomConfirmNewUserLink" name="CustomConfirmNewUserLink" type="text" class="std" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="rowCustomConfirmChangesLink" runat="server">
                                        <td>
                                            <dw:TranslateLabel runat="server" ID="lbConfirmChangesLink" Text="Changes link" />
                                        </td>
                                        <td>
                                            <input id="CustomConfirmChangesLink" name="CustomConfirmChangesLink" type="text" class="std" runat="server" />
                                            <span id="rowCustomConfirmChangesLinkRequired" runat="server" visible="false" />
                                        </td>
                                    </tr>                                        
                                  </table>
                                  
                                  <!----------- End: Confirmation ----------->
                                  
                                  <!----------- Forgot password ----------->
                                  
                                  <table runat="server" style="display:none;" id="tabCustomTextsForgotPassword" cellspacing="0" cellpadding="2" border="0">
                                    <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="leftColHigh"><strong>
                                                <dw:TranslateLabel ID="lbForgotPasswordTexts" Text="Forgot password" runat="server" />
                                        </strong></td>
                                        <td><span id="tabCustomTextsForgotPasswordRequired" runat="server" visible="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomPasswordSuccess" Text="Success" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomPasswordSuccess" name="CustomPasswordSuccess" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>    
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomPasswordInvalid" Text="Invalid e-mail" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomPasswordInvalid" name="CustomPasswordInvalid" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomPasswordError" Text="Error" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomPasswordError" name="CustomPasswordError" runat="server" />
                                        </td>
                                    </tr>
                                  </table>
                                  
                                  <!----------- End: Forgot password ----------->
                                  
                                  <!----------- Validation messages ----------->
                                  
                                  <table style="display:none;" id="tabCustomTextsValidationMessages" cellspacing="0" cellpadding="2" border="0">
                                    <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="leftColHigh"><strong>
                                                <dw:TranslateLabel ID="lbValidationTexts" Text="Validering" runat="server" />
                                        </strong></td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomIncorrect" Text="_incorrect" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomVMIncorrect" name="CustomVMIncorrect" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomRequired" Text="Required" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomVMRequired" name="CustomVMRequired" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomUnique" Text="Unique" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomVMUnique" name="CustomVMUnique" runat="server" />
                                        </td>
                                    </tr>
									<tr id="rowEmailWarning" style="display:none;">
										<td>
											<dw:TranslateLabel id="lbEmailWarningUnique" Text="e_-mail" runat="server" />&nbsp;
											<dw:TranslateLabel id="lbEmailWarningEmail" Text="warning" runat="server" />
										</td>
										<td>
											<input type="text" class="std" id="CustomEmailWarning" name="CustomEmailWarning" runat="server" />
										</td>
									</tr>
                                  </table>
                                  
                                  <!----------- End: Validation messages ----------->
                                  
                                  <!----------- Sort ----------->
                                  
                                  <table style="display:none;" id="tabCustomTextsSort" cellspacing="0" cellpadding="2" border="0">                                    
                                    <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="leftColHigh"><strong>
                                                <dw:TranslateLabel ID="lbCustomSort" Text="Sort" runat="server" />
                                        </strong></td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomSortSubject" Text="Subject" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomSortSubject" name="CustomSortSubject" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomSortCreateDate" Text="Create date" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomSortCreateDate" name="CustomSortCreateDate" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomSortSendDate" Text="Send date" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomSortSendDate" name="CustomSortSendDate" runat="server" />
                                        </td>
                                    </tr>
                                  </table>
                                  
                                  <!----------- End: Sort ----------->
                                  
                                  <!----------- Paging ----------->
                                  
                                  <table style="display:none;" id="tabCustomTextsPaging" cellspacing="0" cellpadding="2" border="0">                                    
                                    <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="leftColHigh"><strong>
                                                <dw:TranslateLabel ID="lbCustomPaging" Text="Sideinddeling" runat="server" />
                                        </strong></td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td valign="top">
                                            <dw:TranslateLabel ID="lbPagingBack" Text="Previous" runat="server" />
                                        </td>
                                        <td>
                                            <table cellspacing="0" cellpadding="2" border="0">
                                                <tr>
                                                    <td>
                                                        <%=Gui.CheckBox(_properties.Value("PagingUseBackText"), "PagingUseBackText", "onclick='javascript:onChangeUsePagingBackText(this);'")%>&nbsp;
                                                        <label for="PagingUseBackText">
                                                            <dw:TranslateLabel ID="lbPagingBackText" runat="server" Text="Text" />
                                                        </label>
                                                    </td>
                                                    <td id="rowPagingBackText" style="display:none;">
                                                        <input class="std" type="text" id="CustomPagingBackText" name="CustomPagingBackText" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Gui.CheckBox(_properties.Value("PagingUseBackImg"), "PagingUseBackImg", "onclick='javascript:onChangeUsePagingBackImg(this);'")%>&nbsp;
                                                        <label for="PagingUseBackImg">
                                                            <dw:TranslateLabel ID="lbPagingBackImg" runat="server" Text="Image" />
                                                        </label>
                                                    </td>
                                                    <td id="rowPagingBackImg" style="display:none;">
                                                        <dw:FileManager ID="CustomPagingBackImg" Name="CustomPagingBackImg" runat="server" Extensions="jpg,jpeg,bmp,gif,png" />    
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr><td colspan="2">&nbsp;</td></tr>
                                    <tr>
                                        <td valign="top">
                                            <dw:TranslateLabel ID="lbPagingFwd" Text="Next" runat="server" />
                                        </td>
                                        <td>
                                            <table cellspacing="0" cellpadding="2" border="0">
                                                <tr>
                                                    <td>
                                                        <%=Gui.CheckBox(_properties.Value("PagingUseFwdText"), "PagingUseFwdText", "onclick='javascript:onChangeUsePagingFwdText(this);'")%>&nbsp;
                                                        <label for="PagingUseFwdText">
                                                            <dw:TranslateLabel ID="lbPagingFwdText" runat="server" Text="Text" />
                                                        </label>
                                                    </td>
                                                    <td id="rowPagingFwdText" style="display:none;">
                                                        <input class="std" type="text" id="CustomPagingFwdText" name="CustomPagingFwdText" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=Gui.CheckBox(_properties.Value("PagingUseFwdImg"), "PagingUseFwdImg", "onclick='javascript:onChangeUsePagingFwdImg(this);'")%>&nbsp;
                                                        <label for="PagingUseFwdImg">
                                                            <dw:TranslateLabel ID="lbPagingFwdImg" runat="server" Text="Image" />
                                                        </label>
                                                    </td>
                                                    <td id="rowPagingFwdImg" style="display:none;">
                                                        <dw:FileManager ID="CustomPagingFwdImg" Name="CustomPagingFwdImg" runat="server" Extensions="jpg,jpeg,bmp,gif,png" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>    
                                    </tr>
                                  </table>
                                  
                                  <!----------- End: Paging ----------->
                                  
                                  <!----------- Other ----------->
                                  
                                  <table runat="server" style="display:none;" id="tabCustomTextsLogoffText" cellspacing="0" cellpadding="2" border="0">                                                                       
                                     <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="leftColHigh"><strong>
                                                <dw:TranslateLabel ID="lbCustomOther" Text="Other" runat="server" />&nbsp;
                                        </strong></td>
                                        <td><span id="tabCustomTextsLogoffTextRequired" runat="server" visible="false" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbCustomDeleteProfile" Text="Unsubscribe all" runat="server" />
                                        </td>
                                        <td>
                                            <input type="text" class="std" id="CustomDeleteProfile" name="CustomDeleteProfile" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                
                                <!----------- End: Other ----------->
                                
                            <dw:GroupBoxEnd ID="GroupBoxEndCustomText" runat="server" />
                        </div>
                        
                        <!-------------- End: Custom texts -------------->
                        
                        <!-------------- Custom fields -------------->
                        
                        <div id="divCustomFields" style="display:none">
                        <dw:GroupBoxStart ID="gbCustomFieldsStart" Title="Custom fields" runat="server" />
                        <table cellspacing="0" cellpadding="2" border="0">
                            <tr>
                                <td class="leftColHigh">
                                    <dw:TranslateLabel ID="lbUploadDir" runat="server" Text="Upload_til" />
                                </td>
                                <td valign="top">
                                    <dw:FolderManager ID="UploadDir" Name="UploadDir" runat="server" />
                                </td>
                            </tr>
                            <tr runat="server" id="CustomFieldsRow">
                                <td style="vertical-align: top;">
                                    <dw:TranslateLabel ID="lbCustomFields" runat="server" Text="Custom fields" />
                                </td>
                                <td>
                                    <mc:ListSelector runat="server" Name="CustomFieldsList" Columns="2" ID="CustomFieldsListCtrl" DataTextField="Name" DataValueField="ID"/>
                                </td>
                            </tr>
                        </table>
                        <dw:GroupBoxEnd ID="gbCustomFieldsEnd" runat="server" />
                        </div>
                        
                        <!-------------- End: Custom fields -------------->
                        
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<script type="text/javascript">
    <%=String.Format("onPageLoad({0});", Dynamicweb.NewsLetterV3.Common.IsExtranetInstalled.ToString.ToLower())%>
</script>

<%
Translate.GetEditOnlineScript()
%>
