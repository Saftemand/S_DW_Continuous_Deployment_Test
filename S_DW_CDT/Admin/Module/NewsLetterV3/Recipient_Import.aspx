<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Recipient_Import.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.Recipient_Import" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="UC" TagName="Progress" Src="Control/Progress.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Recipient import page</title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
    <!--[if IE]> <style type="text/css" media="all">@import url('/Admin/Module/Common/StylesheetIE.css');</style> <![endif]-->
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/category.js"></script>
    <script type="text/javascript" src="js/recipients.js"></script>
<script type="text/javascript">
    function OnCheckCategory(button) {
        var tag = $('nCheckedCategories');
        var srcCategories = $('ddlSourceCategory');
        var srcCategoriesExt = $('ddlSourceCategoryExtended');
        var cmdSubmit = $('cmdOK'); 
        var cnt = parseInt(tag.value);
        if(!srcCategories.getAttribute('disabled') || (srcCategoriesExt && !srcCategoriesExt.getAttribute('disabled'))) {
            if(button.checked) cnt++;
            else if(cnt > 0) cnt--;
        }
        tag.value = cnt;
    }

    function saveAndClose() {
        if (ValidateCategories()) {
            $("action").value = "saveAndClose";
		    $("form").submit();
		}
        return false;
    }
    
    function ValidateCategories() {
        var tag = $('nCheckedCategories');
        var cnt = parseInt(tag.value);
        var ret = (cnt > 0);
        if(!ret)
        {
            alert('<%=Translate.JsTranslate("You must choose a category") %>');
            Ribbon.radioButton('CategoriesRibbon', 'CategoriesRibbon', 'impGroup');
            tab(2);
            return false;
        }
        var SortUpElements = document.getElementsByName('SortUp');
        if(typeof(SortUpElements[0])=="undefined" && $("rbExport").checked)
        {
            alert('<%=Translate.JsTranslate("Add at least one field") %>');
            Ribbon.radioButton('FieldsRibbon', 'FieldsRibbon', 'impGroup');
            tab(3);
            return false;
        }

        return true;
    }
       
    function DisableImport()
    {
        HideImportFileParameters();
        HideListParameters();
    }

    function SelectImport()
    {
        $("groupImport").style.display = "";
        $("groupExport").style.display = "none";
        $("trImportExist").style.display = "";
        groupSourceChange();
    }
    
    function SelectExport()
    {
        DisableImport();
        $("groupImport").style.display = "none";
        $("groupExport").style.display = "";
        $("trImportExist").style.display = "none";        
    }
    
    function groupTypeChange()
    {
        var val = $("rbImport").checked;
        if (val == true)
        {
            SelectImport();
        } else {
            SelectExport();
        }
    }

    function exportDstChange() {
        var isVisible = "";
        if (!$("rbExportFile").checked) {
            isVisible = "none";
        }
        $("groupExportFile").style.display = isVisible;
    }
    
    function groupSourceChange()
    {
        var val = $("rbImportFile").checked;
        if ($("rbImportFile").checked == true)
        {
            SelectImportFromFile();
        } else if ($("rbImportNewsletterV1").checked == true || ($("rbImportNewsletterExtended") && $("rbImportNewsletterExtended").checked == true ) ) {
            if ($("rbImportNewsletterV1").checked == true)
            {
                $("ddlSourceCategory").style.display="";
                if ($("ddlSourceCategoryExtended")) $("ddlSourceCategoryExtended").style.display="none";
            }
            else
            {
                $("ddlSourceCategory").style.display="none";
                if ($("ddlSourceCategoryExtended")) $("ddlSourceCategoryExtended").style.display="";
            }
            SelectImportFromList();
        }        
    }
    
    function HideImportFileParameters()
    {
        $("trImportFile").style.display = "none";
        $("trImportEncoding").style.display = "none";
        $("trImportEmailFormat").style.display = "none";
    }
    
    function HideListParameters()
    {
        $("trImportList").style.display = "none";
    }
    
    function SelectImportFromList()
    {
        $("trImportFile").style.display = "none";
        $("trImportEncoding").style.display = "none";
        $("trImportList").style.display = "";
        $("trImportEmailFormat").style.display = "none";
    }
    
    function SelectImportFromFile()
    {
        $("trImportFile").style.display = "";
        $("trImportEncoding").style.display = "";
        $("trImportList").style.display = "none";
        $("trImportEmailFormat").style.display = "";
    }
    function DeleteConfirm(objRow)
    {
        return confirm('<%=Translate.JSTranslate("Delete")%>?');
    }
    function AddField()
    {
    	if($("ddlField").value == "NewsletterRecipientID") {
    		if(confirm('<%=Translate.JsTranslate("Feltet %% bliver ignoreret ved Import, men ikke ved Eksport!", "%%", Translate.JsTranslate("Modtagerens tabel ID"))%>\n<%=Translate.JsTranslate("Continue?")%>') == false)
	    		return false;
	    } else if($("ddlField").value == "NewsletterRecipientCategoryID") {
    		if(confirm('<%=Translate.JsTranslate("Feltet %% bliver ignoreret ved Import, men ikke ved Eksport!", "%%", Translate.JsTranslate("Modtagerens liste tilmeldinger"))%>\n<%=Translate.JsTranslate("Continue?")%>') == false)
	    		return false;
	    } else if($("ddlField").value == "NewsletterRecipientFormat") {
    		if(confirm('<%=Translate.JsTranslate("Feltet %% bliver ignoreret ved Import, men ikke ved Eksport!", "%%", Translate.JsTranslate("Modtagerens E-Mail format"))%>\n<%=Translate.JsTranslate("Continue?")%>') == false)
	    		return false;
	    }
    }

    function tab(aciveID) {
        for (var i = 1; i < 5; i++) {
            if ($("Tab" + i)) {
                $("Tab" + i).style.display = "none";
            }
        }
        if ($("Tab" + aciveID)) {
            $("Tab" + aciveID).style.display = "";
        }
    }

    function help() {
		<%=Gui.Help("newsletterv3", "modules.newsletterv3.general.import")%>
	}


</script>
</head>
<body>
    <div id="containerNewsletter">
        <form id="form" method="post" class="formNewsletter" runat="server">
        <input type="hidden" name="action" id="action" value="" />
        <dw:RibbonBar ID="RecipientBar" runat="server">
            <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Content" runat="server" Visible="true">
                <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                    <dw:RibbonBarButton ID="btnCancel" Text="Close" Image="Delete" Size="Large" runat="server"
                        PerformValidation="false" EnableServerClick="true" OnClick="Cancel_Click"  />
                    <dw:RibbonBarButton ID="btnOk" Text="Ok" Title="Ok" Image="Check" Size="Large" runat="server" ShowWait="true" WaitTimeout="1000" 
                        OnClientClick="saveAndClose();" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup5" Name="Information" runat="server">
                    <dw:RibbonBarRadioButton ID="DetailsRibbon" Text="Properties" OnClientClick="tab(1);"
                        Checked="true" Group="impGroup" Image="DocumentProperties" Size="Small" runat="server" />
                    <dw:RibbonBarRadioButton ID="CategoriesRibbon" Text="Categories" OnClientClick="tab(2);"
                        Group="impGroup" Image="Folder" Size="Small" runat="server" />
                    <dw:RibbonBarRadioButton ID="FieldsRibbon" Text="Fields" OnClientClick="tab(3);"
                        Group="impGroup" Image="TextCode_Add" Size="Small" runat="server" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup2" Name="Help" runat="server">
                    <dw:RibbonBarButton ID="Help" Text="Help" Title="Help" Image="Help" Size="Large"
                        runat="server" OnClientClick="help();" />
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
            <div id="containerNews1">
                <div id="Tab1" runat="server" >
                        <dw:GroupBoxStart runat="server" Title="Import\Export properties" />
                            <table border="0" cellpadding="2" cellspacing="0" class="innerTable">                                                        
                                <tr><td>&nbsp;</td><td></td></tr>
                                <tr>
                                    <td class="leftCol">
                                        <dw:TranslateLabel runat="server" Text="Type" />
                                    </td>
                                    <td>
                                        <asp:RadioButton ID="rbImport" runat="server" Checked="True" GroupName="Type" Text="Import" onclick="javascript:groupTypeChange();" />&nbsp;
                                        <asp:RadioButton ID="rbExport" runat="server" Checked="False" GroupName="Type" Text="Export" onclick="javascript:groupTypeChange();"  />
                                    </td>
                                </tr>
                                <tr id="trImportExist">
                                    <td class="leftCol">
                                    </td>
                                    <td>
                                        <div>
                                            <asp:CheckBox ID="cbImportExist" runat="server" Chaked="false"/><dw:TranslateLabel runat="server" Text="Add category to users that are already in the system" />
                                        </div>
                                        <div>
                                            <asp:CheckBox ID="cbMakeActive" runat="server" Checked="false"/><dw:TranslateLabel runat="server" Text="Activate all imported users" />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="leftCol">
                                        <dw:TranslateLabel runat="server" Text="Source" />
                                    </td>
                                    <td>
                                        <div id="groupImport">
                                            <asp:RadioButton ID="rbImportNewsletterV1" runat="server" Checked="True" GroupName="ImportSourceGroup" Text="Newsletter V1" onclick="javascript:groupSourceChange();" />&nbsp;
                                            <asp:RadioButton ID="rbImportNewsletterExtended" runat="server" Checked="False" GroupName="ImportSourceGroup" Text="Newsletter Extended" onclick="javascript:groupSourceChange();"/>&nbsp;
                                            <asp:RadioButton ID="rbImportFile" runat="server" Checked="False" GroupName="ImportSourceGroup" Text="File" onclick="javascript:groupSourceChange();"/>
                                        </div>
                                        <div id="groupExport">
                                            <asp:RadioButton ID="rbExportFile" runat="server" Checked="True" GroupName="ExportSourceGroup" Text="File destination" onclick="javascript:exportDstChange();" />
                                            <asp:RadioButton ID="rbExportDownload" runat="server" Checked="False" GroupName="ExportSourceGroup" Text="Download" onclick="javascript:exportDstChange();" />
                                            <div id="groupExportFile">
                                                <dw:TranslateLabel runat="server" Text="Folder" />
                                                <dw:FolderManager runat="server" ID="fmExportFolder" />
                                                <a runat="server" ID="lblExportStatus" href="#" visible="false" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="trImportList">
                                    <td class="leftCol">
                                        <dw:TranslateLabel runat="server" Text="List" />
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSourceCategory" CssClass="std" runat="server" DataTextField="CategoryName" DataValueField="CategoryID"/>
                                        <asp:DropDownList ID="ddlSourceCategoryExtended" CssClass="std" runat="server"  DataTextField="CategoryName" DataValueField="CategoryID"/>
                                    </td>
                                </tr>
                                <tr id="trImportFile">
                                    <td class="leftCol">
                                        <dw:TranslateLabel runat="server" Text="File" />
                                    </td>
                                    <td>
                                        <dw:FileManager runat="server" ID="importFile" Name="importFile" />
                                    </td>
                                </tr>
                                <tr id="trImportEncoding">
                                    <td class="leftCol">
                                        <dw:TranslateLabel runat="server" Text="Encoding" />
                                    </td>
                                    <td>
                                        <dw:CharsetSelector runat="server" ID="importFileEncoding" />
                                    </td>
                                </tr>
                                <tr id="trImportEmailFormat">
                                    <td class="leftCol">
                                        <dw:TranslateLabel runat="server" Text="E-mail format" />
                                    </td>
                                    <td>
                                        <asp:RadioButton ID="FormatHTML" runat="server" Checked="True" GroupName="EmailFormat" Text="HTML"/>&nbsp;
                                        <asp:RadioButton ID="FormatText" runat="server" Checked="False" GroupName="EmailFormat" Text="Text"/>&nbsp;
                                        <asp:RadioButton ID="fromatBoth" runat="server" Checked="False" GroupName="EmailFormat" Text="Both"/>
                                    </td>
                                </tr>   
                            </table>
                        <dw:GroupBoxEnd runat="server" />
                </div>
                <div id="Tab2" runat="server" style="display: none;">
                        <dw:GroupBoxStart runat="server" ID="boxCategories" Title="Categories" />
                        <table border="0" cellpadding="2" cellspacing="0" class="innerTable">
                                <tr>
                                <td>
                                    <asp:GridView ID="gridCategories" AutoGenerateColumns="false" runat="server" BorderColor="White" CellSpacing="0" CellPadding="2" Width="100%" GridLines="None">
                                        <Columns>
                                            <asp:TemplateField ItemStyle-Width="150px">
                                                <ItemTemplate>
                                                    <asp:CheckBox onclick="javascript:OnCheckCategory(this);" ID="chkCategoryID" CssClass="clean" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Name")%>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="10px">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="valueCategoryID" Value='<%#DataBinder.Eval(Container.DataItem, "ID")%>' runat="server" />
                                                </ItemTemplate>
                                             </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <dw:TranslateLabel ID="NoRecordsFoundLabel" runat="server" Text="No categories" />
                                        </EmptyDataTemplate>
                                     </asp:GridView>

                                </td>
                            </tr>
                        </table>
                        <dw:GroupBoxEnd runat="server"/>
                </div>
                <div id="Tab3" runat="server" style="display:none;">
                        <dw:GroupBoxStart runat="server" Title="Database fields" />
                            <table border="0" cellpadding="2" cellspacing="0">
                                <tr>
                                    <td width="170px">&nbsp;
                                        <dw:TranslateLabel runat="server" Text="Field" />
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlField" CssClass="std" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="170px">&nbsp;</td>
								    <td align="right">								        
								        <asp:Button ID="btnAddField" runat="server" OnClientClick="return AddField();" />
                                    </td>
                                </tr>
                            </table>
                        <dw:GroupBoxEnd runat="server" />
                        <dw:GroupBoxStart runat="server" Title="Port fields" />
                            <table border="0" cellpadding="2" cellspacing="0" class="innerTable">
                                <tr >
                                    <td >
                                        <asp:Repeater ID="_Fields" runat="server">
                                            <HeaderTemplate>
                                                <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="width: 70%;">
                                                            <strong><dw:TranslateLabel runat="server" Text="Field" /></strong>
                                                        </td>
                                                        <td style="width: 20%;" align="center" colspan=2>
                                                            <strong><dw:TranslateLabel runat="server" Text="Sort" /></strong>
                                                        </td>
                                                        <td style="width: 10%;">
                                                            <strong><dw:TranslateLabel runat="server" Text="Delete" /></strong>
                                                        </td>
                                                    </tr>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <img src="../../images/Icons/Language_Small.gif" align="absMiddle" border="0" width="15" height="17">
                                                            <%# DataBinder.Eval(Container.DataItem, "Value") %>
                                                        </td>
                                                        <td align="right">
                                                            <div id="SortUp" name="SortUp"><asp:ImageButton CommandName="SortUp" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Key") %>' ImageUrl="/Admin/Images/PilOp.gif" style="border: 0px;"/></div>
											            </td>
													    <td align="left">
    													    <div id="SortDown" name="SortDown"><asp:ImageButton CommandName="SortDown" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Key") %>' ImageUrl="/Admin/Images/PilNed.gif" style="border: 0px;"/></div>
                                                        </td>
                                                        <td align="center">
                                                            <asp:ImageButton CommandName="Delete" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Key") %>' ImageUrl="/Admin/Images/Delete.gif" style="border: 0px;" OnClientClick="return DeleteConfirm();" value='<%#Eval("Key")%>' />
                                                        </td>
                                                    </tr>
                                            </ItemTemplate> 
                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </td>
                               </tr>
                               <tr  runat="server" ID="nofields2" >
                                   <td>
                                       <dw:TranslateLabel runat="server" Text="No fields defined."/>
                                   </td>
                               </tr>                                
                         </table>        
                         <dw:GroupBoxEnd runat="server" />
                         <dw:GroupBoxStart runat="server" Title="Port format" />
                             <table border="0" cellpadding="2" cellspacing="0" class="innerTable">
                                <tr>
                                    <td>
                                        <dw:TranslateLabel runat="server" ID="lblPortFormat" />
                                    </td>
                                </tr>
                                <tr  runat="server" id="nofields" >
                                    <td>
                                        <dw:TranslateLabel runat="server" Text="No fields defined."/>
                                    </td>
                                </tr>                                
                            </table>
                        <dw:GroupBoxEnd runat="server" />
                </div>
            </div>
            <input type="hidden" id="nCheckedCategories" runat="server" value="0" />
            <%  Translate.GetEditOnlineScript() %>
        </form>
    </div>
</body>
</html>
<script type="text/javascript">
    DisableImport();
    groupSourceChange();
    groupTypeChange();
    var SortUpElements = document.getElementsByName('SortUp');
    var SortDownElements = document.getElementsByName('SortDown');
    if (SortUpElements.length > 0) SortUpElements[0].style.display = "none";
    if (SortDownElements.length > 0) SortDownElements[SortDownElements.length-1].style.display = "none";
</script>
