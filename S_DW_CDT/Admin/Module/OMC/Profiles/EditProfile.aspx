<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="EditProfile.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Profiles.EditProfile" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>

<asp:Content ID="cHead" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="cMain" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="subtitle" id="titleTex" runat="server"></h2>
    <div class="content-main">
        <table border="0">
            <tr>
                <td>
                    <dw:GroupBox ID="gbGeneral" Title="General" runat="server">
                        <table border="0" class="tabTable">
                            <tr>
                                <td>
                                    <table border="0">
                                         <tr>
                                            <td style="width: 170px">
                                                <dw:TranslateLabel ID="lbName" Text="Name" runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txName" CssClass="std field-name" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <dw:TranslateLabel ID="lbDescription" Text="Description" runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txDescription" TextMode="MultiLine" CssClass="std field-description" style="height: 64px" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                </td>
            </tr>
            <tr>
                <td>
                    <dw:GroupBox ID="gbAutomaticRecognition" Title="Recognition rules" runat="server">
                        <table border="0" class="tabTable">
                            <tr>
                                <td>
                                    <div class="content-info">
                                        <dw:TranslateLabel ID="lbInfo" Text="Choose recognition rules by dragging items from the list on the left to the area on the right." runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <omc:RecognitionExpressionEditor ID="editRules" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                </td>
            </tr>
        </table> 
    </div>

    <input type="submit" id="cmdSubmit" name="cmdSubmit" value="Submit" style="display: none" />
    <input type="hidden" id="OriginalProfileID" name="OriginalProfileID" value="<%=Request("ID")%>" />

</asp:Content>
