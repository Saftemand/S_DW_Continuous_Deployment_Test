<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CustomFields_Values_Edit.aspx.vb"
    Inherits="Dynamicweb.Admin.ModulesCommon.CustomFields_Values_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>CustomFields_Values_Edit</title>
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />

    <script language="javascript" type="text/javascript">
			var val_changed = false;
			var typeid = <%=_fieldType%>;
			
			function ValueChanged()
			{
					val_changed = true;
			}
			function CaptionChanged()
			{
			    var cap = document.getElementById('_txCaption');
				var val = document.getElementById('_txValue');
				
				if(!val_changed)
				{
					if(typeid==13) 
					{
						if (cap.value.match(/[^0-9]/) == null )
							val.value = cap.value;
					} 
					else if (typeid==10) 
					{
						if (cap.value.match(/^[0-9]*[,]*[0-9]*$/) != null )
							val.value = cap.value;
					}
					else
					{
						val.value = cap.value;
					}
				}

			}
    </script>

</head>
<body>
    <table width="100%" cellspacing="0" cellpadding="0" id="header">
        <tr>
            <td>
                <strong>
                    <dw:TranslateLabel runat="server" Text="Edit dropdown list item" />
                </strong>
            </td>
        </tr>
    </table>
    <div id="containerNews">
        <form method="post" runat="server" id="Form1" class="formNews">
            <dw:TabHeader ID="tabheader1" runat="server" ReturnWhat="all"></dw:TabHeader>
            <div id="Tab1">
                <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
                    <tbody>
                        <tr valign="top">
                            <td colspan="2">
                                <dw:GroupBoxStart runat="server" ID="GroupBoxStart1" Title="General" />
                                <table border="0" cellpadding="5" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td class="leftCol">
                                                <dw:TranslateLabel runat="server" Text="Text" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="_txCaption" CssClass="std" MaxLength="50" runat="server" onkeyup="CaptionChanged()"></asp:TextBox></td>
                                            <td>
                                                &nbsp;<asp:RequiredFieldValidator ID="_CaptionValidator" runat="server" ErrorMessage="required"
                                                    ControlToValidate="_txCaption"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="leftCol">
                                                <dw:TranslateLabel runat="server" Text="Value" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="_txValue" CssClass="std" MaxLength="50" runat="server" onkeyup="ValueChanged()"></asp:TextBox></td>
                                            <td>
                                                &nbsp;<asp:RequiredFieldValidator ID="_ValueValidator" runat="server" ErrorMessage="required"
                                                    ControlToValidate="_txValue"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <dw:GroupBoxEnd ID="GroupBoxEnd1" runat="server" />
                            </td>
                        </tr>
                        <tr valign="bottom">
                            <td valign="bottom" style="width: 70%;">
                                <asp:CustomValidator OnServerValidate="ServerValidate" ID="_cusValidator" runat="server"
                                    Display="Static" ErrorMessage="The specified value is already exits. Please type another."
                                    ControlToValidate="_txValue"></asp:CustomValidator></td>
                            <td class="buttonsRow">
                                <table cellpadding="2" cellspacing="0" border="0">
                                    <tr>
                                        <td align="right">
                                            <asp:Button ID="_btnSubmit" CausesValidation="True" CssClass="buttonSubmit" Text="OK"
                                                runat="server"></asp:Button></td>
                                        <td align="right">
                                            <asp:Button ID="_btnCancel" CausesValidation="False" CssClass="buttonSubmit" Text="Cancel"
                                                runat="server"></asp:Button>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </form>
    </div>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>
