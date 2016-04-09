<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CustomFields_edit.aspx.vb" Inherits="Dynamicweb.Admin.ModulesCommon.CustomFields_edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>CustomFields_edit</title>
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
     <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
    <link rel="Stylesheet" type="text/css" href="/Admin/Module/Common/dw7UI.css" />
    <!--[if IE]> <style type="text/css" media="all">@import url('/Admin/Module/Common/StylesheetIE.css');</style> <![endif]-->
    <script language="javascript" type="text/javascript">
        function DeleteConfirm(objRow) {
            return confirm('<%=Translate.JSTranslate("Delete")%>?');
        }

        var systemName_changed = false;

        function SystemNameChanged() {
            systemName_changed = true;
        }
        function NameChanged() {
            var name = document.getElementById('_txName');
            var sysName = document.getElementById('_txSystemName');
            if (!systemName_changed && !sysName.disabled)
                sysName.value = name.value.replace(/[ !&"'():,\[\]#$%^*\@\~\`\-\+\=\{\}\\\/\<\>\?\.\;\|]/g, '_');

        }

        function ToggleDropdown(ftype) {
            var chkDd = document.getElementById("dropdownarea");
            if (ftype.value == "7" || ftype.value == "8" || ftype.value == "9" || ftype.value == "11" || ftype.value == "12")
                chkDd.style.display = "none";
            else
                chkDd.style.display = "";
        }
    </script>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>    
</head>

<body>
<div class="list">
    <div class="title">
      <%=GetBreadcrumb() %>
    </div>
    <form method="post" runat="server" id="Form1" class="formNews">
        <div id="containerNews">
            <dw:TabHeader ID="tabheader1" runat="server" ReturnWhat="all">
            </dw:TabHeader>
            <div id="Tab1">
                <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
                    <tr valign="top">
                        <td colspan="2">
                            <dw:GroupBoxStart runat="server" ID="gb1" Title="Generelt" />
                            <table border="0" cellpadding="2" cellspacing="0">
                                <tr>
                                    <td class="leftCol">
                                        <dw:TranslateLabel ID="tLabel1" runat="server" Text="Navn" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="_txName" CssClass="std" MaxLength="128" runat="server" onkeyup="NameChanged();"></asp:TextBox></td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="_NameValidator" Display="Dynamic" runat="server"
                                            ErrorMessage=" required" ControlToValidate="_txName"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="leftCol">
                                        <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Systemnavn" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="_txSystemName" CssClass="std" MaxLength="100" runat="server" onkeyup="SystemNameChanged();"></asp:TextBox></td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="_SystemNameValidator" Display="Dynamic" runat="server"
                                            ErrorMessage=" required" ControlToValidate="_txSystemName"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="_SystemNameValidatorExpr" Display="Dynamic" runat="server"
                                            ErrorMessage=" System name cannot include spaces and special characters ('!:,&)" ControlToValidate="_txSystemName" ValidationExpression="([a-zA-Z0-9_\-\.])+"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="leftCol">
                                        <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Felttype" />
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="_lstType" Enabled="False" runat="server" CssClass="std">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="leftCol">
                                        <label for="Required"><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Required" /></label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="Required" runat="server"></asp:CheckBox></td>
                                </tr>
                                <tr id="dropdownarea" runat="server" style="display:none;">
                                    <td class="leftCol">
                                        <label for="_chkDropDown"><dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Dropdown" /></label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="_chkDropDown" Checked="False" runat="server"></asp:CheckBox></td>
                                </tr>
                            </table>
                            <dw:GroupBoxEnd ID="endGb1" runat="server" />
                            <asp:Panel ID="pnlDropdown" runat="server">
                                <dw:GroupBoxStart runat="server" ID="GroupBoxStart1" Title="Dropdown" />
                                <table cellspacing="0" cellpadding="2" border="0" width="500">
                                    <tr>
                                        <td colspan="2">
                                            <asp:Panel runat="server" ID="_pnlDDRepeater">
                                                <asp:Repeater ID="_repeatVals" runat="server">
                                                    <HeaderTemplate>
                                                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                                            <tr>
                                                                <td style="width: 30%;">
                                                                    <strong>
                                                                        <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Text" />
                                                                    </strong>
                                                                </td>
                                                                <td style="width: 30%;">
                                                                    <strong>
                                                                        <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Value" />                                                                    </strong>
                                                                </td>
                                                                <td style="width: 10%;" align="center" colspan=2>
                                                                    <strong>
                                                                        <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Sort" /></strong>
                                                                </td>
                                                                <td style="width: 10%;">
                                                                    <strong>
                                                                        <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Active" /></strong>
                                                                </td>
                                                                <td style="width: 10%;">
                                                                    <strong>
                                                                        <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Default" /></strong>
                                                                </td>
                                                                <td style="width: 10%;">
                                                                    <strong>
                                                                        <dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Delete" />
                                                                    </strong>
                                                                </td>
                                                            </tr>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <a id="ValueDDL" href="CustomFields_Values_Edit.aspx?ID=<%# Eval("ID") %>&FieldID=<%=_fieldId%>&groupId=<%=_groupId %>&context=<%=_context %>&groupContext=<%=Request("groupContext") %>&backUrl=<%=_backUrl %>">
                                                                <%#Eval("Value")%>
                                                                </a>
                                                            </td>
                                                            <td>
                                                            <a id="ValueDDL" href="CustomFields_Values_Edit.aspx?ID=<%# Eval("ID") %>&FieldID=<%=_fieldId%>&groupId=<%=_groupId %>&context=<%=_context %>&groupContext=<%=Request("groupContext") %>&backUrl=<%=_backUrl %>">
                                                                    <%#Eval("Key")%>
                                                                </a>
                                                            </td>
                                                            <td align="right">
                                                                <div id="SortUp" name="SortUp">
                                                                <asp:ImageButton ID="ImageButton1" CommandName="SortUp" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' ImageUrl="/Admin/Images/PilOp.gif" style="border: 0px;"/>
                                                                </div>
															</td>
															<td align="left">
															    <div id="SortDown" name="SortDown">
                                                                <asp:ImageButton ID="ImageButton2" CommandName="SortDown" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' ImageUrl="/Admin/Images/PilNed.gif" style="border: 0px;"/>
                                                                </div>
                                                            </td>
                                                            <td align="center">
                                                                <div style="display:<%#IIF(Eval("Active")="True","","none")%>">
                                                                <asp:ImageButton ID="ImageButton3" CommandName="Active" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' ImageUrl="/Admin/Images/Check.gif" style="border: 0px;"/>
                                                                </div>
                                                                <div style="display:<%#IIF(Eval("Active")="True","none","")%>">
                                                                <asp:ImageButton ID="ImageButton4" CommandName="Active" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' ImageUrl="/Admin/Images/Minus.gif" style="border: 0px;"/>
                                                                </div>
                                                            </td>
                                                            <td align="center">
                                                                <div style="display:<%#IIF(Eval("DropdownDefault")="True","","none")%>">
                                                                <asp:ImageButton ID="ImageButton5" CommandName="Default" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' ImageUrl="/Admin/Images/Check.gif" style="border: 0px;"/>
                                                                </div>
                                                                <div style="display:<%#IIF(Eval("DropdownDefault")="True","none","")%>">
                                                                <asp:ImageButton ID="ImageButton6" CommandName="Default" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' ImageUrl="/Admin/Images/Minus.gif" style="border: 0px;"/>
                                                                </div>                                                                
                                                            </td>
                                                            <td align="center">
                                                                <asp:ImageButton ID="ImageButton7" CommandName="Delete" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' ImageUrl="/Admin/Images/Delete.gif" style="border: 0px;" OnClientClick="return DeleteConfirm();" value='<%#Eval("Value")%>' />
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate> 
                                                    <FooterTemplate>
                                                        </table>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </asp:Panel>
                                            <asp:Label ID="_lblNoFields" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr valign="bottom">
                                        <td colspan="2">
                                            <table cellspacing="0" cellpadding="0" border="0">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnNewDropDown" CausesValidation="False" Text="New" CssClass="buttonSubmit"
                                                            runat="server"></asp:Button>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <dw:GroupBoxEnd ID="GroupBoxEnd1" runat="server" />
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr valign="bottom">
                        <td valign="bottom" align="left" style="width: 70%;">
                            <asp:CustomValidator ID="_cusValidator" runat="server" ControlToValidate="_txSystemName"
                                ErrorMessage="The specified system name is already exits. Please type another."
                                OnServerValidate="ServerValidate" Display="dynamic"></asp:CustomValidator>
                                <asp:CustomValidator ID="_cusValidateContextSpecificSystemNames" runat="server" ControlToValidate="_txSystemName"
                                ErrorMessage="The specified system name is already used by the module. Please type another."
                                OnServerValidate="ValidateContextSpecificSystemNames" Display="dynamic"></asp:CustomValidator>
                                
                                </td>

                        <td class="buttonsRow">
                            <table cellpadding="2" cellspacing="0" border="0">
                                <tr>
                                    <td align="right">
                                        <asp:Button ID="_btnSubmit" CausesValidation="True" Text="OK" CssClass="buttonSubmit"
                                            runat="server"></asp:Button></td>
                                    <td align="right">
                                         <asp:Button ID="BtnCancel" CausesValidation="false" Text="Cancel" CssClass="buttonSubmit"
                                            runat="server"></asp:Button>
                                    </td>
                                    <td style="width: 20px;">
                                        <button onclick="<%=HelpHref()%>"
                                            class="buttonSubmit">
                                            <dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Hjælp" />
                                        </button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>        
    </form>
</body>
<script type="text/javascript">

    var SortUpElements = document.getElementsByName('SortUp');
    var SortDownElements = document.getElementsByName('SortDown');

    if (SortUpElements.length > 0) SortUpElements[0].style.display = "none";
    if (SortDownElements.length > 0) SortDownElements[SortDownElements.length - 1].style.display = "none";
</script>
</html>
<%
Translate.GetEditOnlineScript()
%>