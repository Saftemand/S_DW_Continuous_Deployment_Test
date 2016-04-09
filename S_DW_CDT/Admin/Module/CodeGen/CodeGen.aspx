<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CodeGen.aspx.vb" Inherits="Dynamicweb.Admin.CodeGen.CodeGen1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script type="text/javascript">       
        function help() {
		    <%=Gui.Help("registermodule", "modules.codegen.default")%>
	    }

        function highlightWord(node,word) {
			// Iterate into this nodes childNodes
			if (node.hasChildNodes) {
				var hi_cn;
				for (hi_cn=0;hi_cn<node.childNodes.length;hi_cn++) {
					//alert(node.nodeName);
					highlightWord(node.childNodes[hi_cn],word);
				}
			}
			
			// And do this node itself
			if (node.nodeType == 3) { // text node
				tempNodeVal = node.nodeValue.toLowerCase();
				tempWordVal = word.toLowerCase();
				if (tempNodeVal.indexOf(tempWordVal) != -1) {
					pn = node.parentNode;
					if (pn.className != "searchword") {
						// word has not already been highlighted!
						nv = node.nodeValue;
						ni = tempNodeVal.indexOf(tempWordVal);
						// Create a load of replacement nodes
						before = document.createTextNode(nv.substr(0,ni));
						docWordVal = nv.substr(ni,word.length);
						after = document.createTextNode(nv.substr(ni+word.length));
						hiwordtext = document.createTextNode(docWordVal);
						hiword = document.createElement("span");
						hiword.className = "searchword";
						hiword.appendChild(hiwordtext);
						pn.insertBefore(before,node);
						pn.insertBefore(hiword,node);
						pn.insertBefore(after,node);
						pn.removeChild(node);
					}
				}
			}
		}
		
		function highlight(){
			if(document.getElementById('Form1').ReplaceString){
				var strWord = document.getElementById('Form1').ReplaceString.value;
				if(strWord.length > 0){
					highlightWord(document.getElementById('table1'),strWord);
				}
			}
		}
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel runat="server" ID="Script" Visible="False">
        <script language="javascript">
            function Copy2ClipBoard() {
                if (document.all) // IE only
                {
                    var preSource = document.getElementById("PreSource");
                    var source = document.getElementById("Source");
                    if (source && preSource) {
                        source.innerText = preSource.innerText;
                        var copied = source.createTextRange();
                        copied.execCommand("Copy");
                    }
                }
                return false;
            }
        </script>
    </asp:Panel>
    <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">
        <dw:ToolbarButton ID="ToolbarButton3" runat="server" Divide="None" Image="Help" Text="Help"
            OnClientClick="help();">
        </dw:ToolbarButton>
    </dw:Toolbar>
    <dw:StretchedContainer ID="OuterContainer" Scroll="Auto" Stretch="Fill" Anchor="document"
        runat="server">
        <table class="tabTable" cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td valign="top">
                    <br>
                    <dw:GroupBoxStart ID="GroupBoxStart1" Title="Indstillinger" runat="server"></dw:GroupBoxStart>
                    <table>
                        <tr>
                            <td width="170">
                                <%=Translate.Translate("Database")%>
                            </td>
                            <td>
                                <asp:DropDownList ID="DatabaseList" runat="server" CssClass="std" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="TableListRow" runat="server">
                            <td>
                                <%=Translate.Translate("Tabel")%>
                            </td>
                            <td>
                                <asp:DropDownList ID="TableList" runat="server" CssClass="std" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="FieldListRow" runat="server">
                            <td>
                                <%=Translate.Translate("Nøglefelt")%>
                            </td>
                            <td>
                                <asp:DropDownList ID="FieldList" runat="server" CssClass="std" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="ProgLanguageRow" runat="server">
                            <td valign="top">
                                <%=Translate.Translate("Programeringssprog")%>
                            </td>
                            <td>
                                <asp:DropDownList ID="ProgLanguageList" runat="server" CssClass="std">
                                </asp:DropDownList>
                                <br />
                                <asp:CheckBox ID="GenerateCollection" Checked="True" runat="server" /><label for="GenerateCollection"><%=Translate.Translate("Generate collection class")%></label>
                            </td>
                        </tr>
                        <tr id="ButtonRow" runat="server">
                            <td align="right" colspan="2">
                                <asp:Button ID="GenerateButton" runat="server" Text="Generate"></asp:Button>&nbsp;
                                <asp:Button ID="CopyButton" runat="server" Text="Copy to Clipboard" Visible="False">
                                </asp:Button>
                            </td>
                        </tr>
                    </table>
                    <dw:GroupBoxEnd ID="GroupBoxEnd1" runat="server"></dw:GroupBoxEnd>
                </td>
            </tr>
            <tr id="DisplaySearchResultRow" runat="server" name="DisplaySearchResultRow">
                <td>
                    <dw:GroupBoxStart ID="GroupBoxStart2" Title="Poster" runat="server"></dw:GroupBoxStart>
                    <div style="overflow: auto; width: 570px; height: 500px">
                        <table id="table1">
                            <tr>
                                <td>
                                </td>
                            </tr>
                        </table>
                        <pre id="PreSource">
<asp:Literal ID="SourceCode" runat="server"></asp:Literal></pre>
                        <textarea id="Source" style="display: none"></textarea>
                    </div>
                    <dw:GroupBoxEnd ID="Groupboxend2" runat="server"></dw:GroupBoxEnd>
                    <dw:GroupBoxStart ID="Groupboxstart3" Title="CreateTable" runat="server"></dw:GroupBoxStart>
                    <div style="overflow: auto; width: 570px;">
                        <table id="table2">
                            <tr>
                                <td>
                                </td>
                            </tr>
                        </table>
                        Script:
                        <pre>
<asp:Literal ID="CreateTableScript" runat="server"></asp:Literal></pre>
                    </div>
                    <dw:GroupBoxEnd ID="Groupboxend3" runat="server"></dw:GroupBoxEnd>
                </td>
            </tr>
        </table>
    </dw:StretchedContainer>
    </form>
    <%Translate.GetEditOnlineScript()%>
</body>
</html>
