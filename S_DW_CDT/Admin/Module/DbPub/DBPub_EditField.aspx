<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" Codebehind="DBPub_EditField.aspx.vb"
    Inherits="Dynamicweb.Admin.DBPub.DBPub_EditField" %>

<html>
<head>
    <title>Edit field</title>
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET"></link>
    <style>
		#GetHtmlTableTabs { WIDTH: 400px }
		#GetHtmlTableTop { WIDTH: 400px }
	</style>

    <script src="ControlValidator.js" type="text/javascript"></script>

    <script src="EditField.js" type="text/javascript"></script>

    <script language="javascript">
			function ShowControl(name)
			{
				if(name != "")
				{
					document.getElementById(name).style.display = "";
				}
			} 

		    var __isFormValid = false;
    
			function ValidateForm()
			{	
				if(!__isFormValid)
				{
					__isFormValid = true;
					<%=_validateFunctions%>
				}
				return __isFormValid;
			}
    </script>

</head>
<body>
    <%=Gui.MakeHeaders(Translate.Translate("Field options"), Translate.Translate("Options"), "all")%>
    <table border="0" cellpadding="0" cellspacing="0" class="tabTable" style="width: 400px">
        <form id="Form1" method="post" runat="server">
            <tbody>
                <tr>
                    <td valign="top">
                        <div id="tab1">
                            <input id="CtrlName" type="hidden" value="<%=_ctrlName%>" name="CtrlName">
                            <input id="fieldnum" type="hidden" value="<%=_num%>" name="fieldnum">
                            <table style="margin-left: 6px">
                                <tr width="100%">
                                    <td width="120">
                                    </td>
                                    <td align="right">
                                        <img id="_patternDate" title="Help" style="cursor: pointer" src="/admin/images/icons/help_small.gif"
                                            runat="server">
                                        <img id="_patternText" title="Help" style="cursor: pointer" src="/admin/images/icons/help_small.gif"
                                            runat="server">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <span id="_incorrect" style="display: none; color: red">
                                            <%=Translate.Translate("Der er indtastet en ugyldig værdi")%>
                                        </span><span id="_required" style="display: none; color: red">
                                            <%=Translate.Translate("Feltet skal udfyldes")%>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Felt navn")%>
                                    </td>
                                    <td>
                                        <%=_f.Name%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel runat="server" Text="Field label" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="FieldLabel" runat="server" CssClass="std"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Felt type")%>
                                    </td>
                                    <td>
                                        <%=Translate.Translate(_f.Type.ToString())%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Primær nogle")%>
                                    </td>
                                    <td>
                                        <%=BoolToStr(_f.IsUnique)%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Skrivebeskyttet")%>
                                    </td>
                                    <td>
                                        <%=BoolToStr(_f.IsReadOnly)%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Krævet")%>
                                    </td>
                                    <td>
                                        <%=BoolToStr(Not _f.IsAllowDBNull)%>
                                    </td>
                                </tr>
                                <asp:Panel ID="_defaultEdit" runat="server">
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Hidden" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="_hiddenField" runat="server"></asp:CheckBox></td>
                                    </tr>
                                    <asp:Panel ID="_isText" runat="server">
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Text length" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="_maxLength" runat="server" CssClass="std"></asp:TextBox></td>
                                        </tr>
                                    </asp:Panel>
                                    <tr>
                                        <td>
                                            <%=Translate.Translate("Standard værdi")%>
                                        </td>
                                        <td id="TextControl" style="display: none">
                                            <asp:TextBox ID="_text" runat="server" CssClass="std"></asp:TextBox></td>
                                        <td id="CheckboxControl" style="display: none">
                                            <asp:CheckBox ID="_check" runat="server"></asp:CheckBox></td>
                                        <td id="DateControl" style="display: none">
                                            <dw:DateSelector ID="_dsDate" runat="server"></dw:DateSelector>
                                        </td>
                                        <td id="ObjectControl" style="display: none">
                                            <%=Translate.Translate("Objekt type kan ikke redigeres")%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Render" />
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="_render" runat="server" CssClass="std">
                                            </asp:DropDownList></td>
                                    </tr>
                                </asp:Panel>
                                <tr>
                                    <td valign="top">
                                        <dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Pattern" /></td>
                                    <td>
                                        <asp:TextBox ID="_pattern" runat="server" CssClass="std" Rows="5" TextMode="MultiLine"></asp:TextBox>
                                        <span id="_patternDateHelp" style="display: none">
                                            <div>
                                                <table border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td colspan="2">
                                                            &nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Examples" />
                                                            :</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            d</td>
                                                        <td>
                                                            :08/17/2000</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            D</td>
                                                        <td>
                                                            :Thursday, August 17, 2000</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            f</td>
                                                        <td>
                                                            :Thursday, August 17, 2000 16:32</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            F</td>
                                                        <td>
                                                            :Thursday, August 17, 2000 16:32:32</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            g</td>
                                                        <td>
                                                            :08/17/2000 16:32</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            G</td>
                                                        <td>
                                                            :08/17/2000 16:32:32</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            m</td>
                                                        <td>
                                                            :August 17</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            r</td>
                                                        <td>
                                                            :Thu, 17 Aug 2000 23:32:32 GMT</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            s</td>
                                                        <td>
                                                            :2000-08-17T16:32:32</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            t</td>
                                                        <td>
                                                            :16:32</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            T</td>
                                                        <td>
                                                            :16:32:32</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            u</td>
                                                        <td>
                                                            :2000-08-17 23:32:32Z</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            U</td>
                                                        <td>
                                                            :Thursday, August 17, 2000 23:32:32</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            y</td>
                                                        <td>
                                                            :August, 2000</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            dddd, MMMM dd yyyy</td>
                                                        <td>
                                                            :Thursday, August 17 2000</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            ddd, MMM d 'yy</td>
                                                        <td>
                                                            :Thu, Aug 17 '00</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            dddd, MMMM dd</td>
                                                        <td>
                                                            :Thursday, August 17</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            M/yy</td>
                                                        <td>
                                                            :8/00</td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            dd-MM-yy</td>
                                                        <td>
                                                            :17-08-00</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </span><span id="_patternTextHelp" style="display: none">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            &nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Examples" />
                                                            :</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Default" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input disabled type="text" class="std" value="{0}">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Alternative bit-type presentation" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input disabled type="text" class="std" value="<img src='/admin/images/{0}.gif' />">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Upload manager presentation" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input disabled type="text" class="std" value="<a href='{0}'>{1}</a>">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Associate")%>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="_chkAssociate" runat="server" AutoPostBack="true" />
                                    </td>
                                </tr>
                                <asp:Panel ID="_pnlAssociate" runat="server">
                                    <tr>
                                        <td>
                                            <%=Translate.Translate("View")%>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="_ddViews" runat="server" CssClass="std" AutoPostBack="true">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Translate.Translate("Key field")%>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="_ddKeyFields" runat="server" CssClass="std">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Translate.Translate("Value field")%>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="_ddValueFields" runat="server" CssClass="std">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </asp:Panel>
                                <tr>
                                    <td colspan="2">
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100%;">
                        <asp:Button ID="Submit" CssClass="buttonSubmit" runat="server" Text="Ok" />
                        &nbsp;
                        <asp:Button ID="Cancel" CssClass="buttonSubmit" runat="server" Text="Cancel" />
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="height: 5px;">
                    </td>
                </tr>
            </tbody>
        </form>
    </table>
    <%=ShowControl()%>
    <%Translate.GetEditOnlineScript()%>
</body>
</html>
