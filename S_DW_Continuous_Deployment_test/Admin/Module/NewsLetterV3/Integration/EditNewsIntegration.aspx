<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EditNewsIntegration.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.EditNewsIntegration" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register Src="IntegrationControl.ascx" TagName="BaseIntegration" TagPrefix="ic" %>
<%@ Register Src="/Admin/Module/Common/ComboRepeater.ascx" TagName="ComboRepeater" TagPrefix="cc" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link rel="stylesheet" href="../css/main.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
    <!--[if IE]> <style type="text/css" media="all">@import url('/Admin/Module/Common/StylesheetIE.css');</style> <![endif]-->
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server"></dw:ControlResources>
    <script type="text/javascript" src="../js/main.js"></script>
    <script type="text/javascript" src="../js/rules.js"></script>
    <script type="text/javascript" src="/Admin/Module/Common/Common.js"></script>
    <script type="text/javascript">
    function Change_AutomaticDistributionType(ID)
    {
	    if (ID =="1") 
	    {
	        SetVisibleById("Table_Time", false);
	        SetVisibleById("Table_AtOnce", false);
	        $("btnSave").setAttribute("class", "");
            $("btnSaveAndClose").setAttribute("class", "");
	        SetVisibleById("btnNext", false);
	    } 
	    else if (ID == "2") 
	    {
	        SetVisibleById("Table_Time", true);
	        SetVisibleById("Table_AtOnce", false);
	        $("btnSave").setAttribute("class", "");
            $("btnSaveAndClose").setAttribute("class", "");
	        SetVisibleById("btnNext", false);
	    } 
	    else if (ID == "3") 
	    {
	        SetVisibleById("Table_Time", false);
	        SetVisibleById("Table_AtOnce", true);
	        $("btnSave").setAttribute("class", "disabled");
            $("btnSaveAndClose").setAttribute("class", "disabled");
	        SetVisibleById("btnNext", true);
	    } 
    }
    
    function ValidateLinks(source, arguments)
    {
        arguments.IsValid = document.getElementById("LmModulePage").value != "";
    }

    function help() {
		<%=Gui.Help("newsletterv3", "modules.newsletterv3.general.integration.edit")%>
	}
    </script>
</head>
<body>
    <div id="containerNewsletter">
        <form id="form1" runat="server" class="formNewsletter" >
        <dw:RibbonBar ID="CategoryBar" runat="server">
            <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Content" runat="server" Visible="true">
                <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                    <dw:RibbonBarButton ID="btnSave" Text="Save" Title="Save" Image="Save"
                        Size="Small" runat="server" EnableServerClick="true" OnClick="Save_Click" ShowWait="true"  WaitTimeout="1000"/>
                    <dw:RibbonBarButton ID="btnSaveAndClose" Text="Save and close" 
                        Image="SaveAndClose" Size="Small" runat="server" EnableServerClick="true" OnClick="SaveAndClose_Click"  ShowWait="true"  WaitTimeout="1000"/>
                    <dw:RibbonBarButton ID="btnCancel" Text="Close" Image="Cancel" Size="Small" runat="server"
                        EnableServerClick="true" PerformValidation="false" OnClick="Cancel_Click"  />
                    <dw:RibbonBarButton ID="btnNext" Text="Next" Title="Next" Image="NavigateRight" Size="Large"
                        runat="server"  EnableServerClick="true" OnClick="Next_Click" ShowWait="true" WaitTimeout="500"/>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup2" Name="Help" runat="server">
                    <dw:RibbonBarButton ID="Help" Text="Help" Title="Help" Image="Help" Size="Large"
                        runat="server" OnClientClick="help();" PerformValidation="false" />
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
        </dw:RibbonBar>
        <div class="list">
            <table width="100%" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="title">
                        <%=GetBreadcrumb() %>
                    </td>
                </tr>
            </table>
        </div>
            <div>
                <table class="tabTable" border="0" cellpadding="0" cellspacing="2">
                    <tr>
                        <td valign="top">
                            <div id="Tab1">
                                <ic:BaseIntegration ID="Integration" runat="server" DefaultTemplate="NewsList.html" />
                                <dw:GroupBoxStart ID="gbStart1" runat="server" Title="News categories" />
                                <cc:ComboRepeater ID="NewsCategories" runat="server" DataTextField="NewsCategoryName"
                                    DataValueField="ID" DropDownLabel="news category" RequiredMessage="add at least one category, please" />
                                <dw:GroupBoxEnd ID="gbEnd1" runat="server" />
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>
