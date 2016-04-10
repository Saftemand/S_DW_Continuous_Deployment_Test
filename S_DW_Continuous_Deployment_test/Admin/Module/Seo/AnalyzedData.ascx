<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AnalyzedData.ascx.vb" Inherits="Dynamicweb.Admin.AnalyzedData" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<dw:GroupBoxStart ID="gbAnalyzedDataStart" Title="Edit" runat="server" />
<table width="100%">
    <tr>
        <td width="550">
            <table id="formTab" style="width: 100%; table-layout: fixed">
                <tr>
                    <td width="150">
                        <dw:TranslateLabel ID="lbTitle" Text="Titel" runat="server" />
                    </td>
                    <td width="400">
                        <asp:TextBox Width="100%" CssClass="std" ID="txTitle" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:TranslateLabel ID="lbKeywords" Text="Keywords" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox Width="100%" CssClass="std" ID="txKeywords" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:TranslateLabel ID="lbDescription" Text="Beskrivelse" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox Width="100%" CssClass="std" ID="txDescription" runat="server" />
                    </td>
                </tr>
                <tr id="rowParagraphText" runat="server">
                    <td colspan="2">
                        <asp:Label ID="lbEditor" runat="server" />
                    </td>
                </tr>
                <tr height="32" valign="middle">
                    <td>
                        <span id="imgWait" style="display:none">
                            <img src="Dynamicweb_Wait.gif" border="0" width="32" height="32" />   
                        </span>
                    </td>
                    <td width="100%" align="right">
                        <input type="button" id="cmdSave" value="Save" class="buttonSubmit" runat="server" />
                    </td>
                </tr>
            </table>
            <span style="display:none">
                <asp:PlaceHolder ID="HiddenParagraphs" runat="server"></asp:PlaceHolder>
            </span>
        </td>
        <td>&nbsp;</td>
    </tr>
</table>

<dw:GroupBoxEnd ID="gbAnalyzedDataEnd" runat="server" />