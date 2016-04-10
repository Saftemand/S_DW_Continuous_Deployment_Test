<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TextTranslation.aspx.vb" Inherits="Dynamicweb.Admin.TextTranslation" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="HeadSection" runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Translate" runat="server" /></title>
        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
        
        <link type="text/css" rel="stylesheet" href="TextTranslation.css" />
        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
        <script type="text/javascript" src="/Admin/Filemanager/Upload/js/EventsManager.js"></script>
        <script type="text/javascript" src="js/TranslationManager.js"></script>
        <script type="text/javascript" src="js/TextTranslation.js"></script>
    </head>
    <body scroll="no">
        <form id="MainForm" runat="server">
            <div>
                <dw:RibbonBar ID="Toolbar" HelpKeyword="editor.translate" runat="server">
                    <dw:RibbonBarTab ID="tabGeneral" Name="Translate" runat="server">
                        <dw:RibbonBarGroup ID="groupGeneral" Name="General" runat="server">
                            <dw:RibbonBarButton ID="cmdApply" Image="Save" Text="Gem_og_luk" Size="Small" runat="server" />
                            <dw:RibbonBarButton ID="cmdCancel" Image="Cancel" Text="Cancel" Size="Small" runat="server" />
                        </dw:RibbonBarGroup>
                        <dw:RibbonBarGroup ID="groupLanguage" Name="Translate" runat="server">
                            <dw:RibbonBarPanel ID="panelLanguages" ExcludeMarginImage="true" runat="server">
                                <div class="languageRow">
                                    <span class="languageLabel">
                                        <dw:TranslateLabel ID="lbFrom" Text="From" runat="server" />
                                    </span>
                                    <span class="languageListContainer">
                                        <select id="ddFrom" class="languageList"></select>
                                    </span>
                                </div>
                                <div class="languageRow">
                                    <span class="languageLabel">
                                        <dw:TranslateLabel ID="lbTo" Text="To" runat="server" />
                                    </span>
                                    <span class="languageListContainer">
                                        <select id="ddTo" class="languageList"></select>
                                    </span>
                                </div>
                            </dw:RibbonBarPanel>
                            <dw:RibbonBarButton ID="cmdSwap" Image="Refresh" Text="Swap" Size="Small" runat="server" />
                            <dw:RibbonBarButton ID="cmdTranslate" Image="Convert" Text="Translate" Size="Large" runat="server" />
                         </dw:RibbonbarGroup>
                    </dw:RibbonBarTab> 
                </dw:RibbonBar>
                <div>
                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr class="translationHeading">
                            <td width="50%">
                                <dw:TranslateLabel ID="lbOriginal" Text="Original" runat="server" />
                            </td>
                            <td width="50%">
                                <dw:TranslateLabel ID="lbTranslation" Text="Oversættelse" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <textarea id="txTextFrom" class="sourceText sourceTextFrom"></textarea>
                                <span id="txTextFromHidden" style="display: none"></span>
                            </td>
                            <td valign="top">
                                <textarea id="txTextTo" class="sourceText"></textarea>
                                <span id="txTextToHidden" style="display: none"></span>
                            </td>
                        </tr>
                    </table>
                    <div id="divBottom" style="position: fixed; bottom: 0px"></div>
                </div>
            </div>
            
            <div id="divBranding" class="branding">
            </div>
            
            <input type="hidden" id="currentLanguage" class="currentLang" runat="server" />
            <span id="AutoDetectLabel" style="display: none"><dw:TranslateLabel ID="lbAutoDetect" Text="Auto" runat="server" /></span>
            <span id="TranslationFailed" style="display: none"><dw:TranslateLabel id="lbTranslationFailed" Text="Unable to perform the translation (Note: Google Translate cannot handle large texts). The error message is:" runat="server" /></span>
        </form>
    </body>
    <%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
