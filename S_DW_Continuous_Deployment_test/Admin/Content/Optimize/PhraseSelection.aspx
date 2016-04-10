<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PhraseSelection.aspx.vb" Inherits="Dynamicweb.Admin.PhraseSelection" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<dw:ControlResources ID="ControlResources1" runat="server">
	</dw:ControlResources>
	
	<script type="text/javascript">
		function choose(phrase) {
			phrase = phrase.toString();
			if(phrase.length == 0){
				alert("Please specify word");
				return false;
			}
			location = "Optimize.aspx?id=<%=Dynamicweb.Base.Request("ID")%>&phrase=" + encodeURIComponent(phrase);
		}
	</script>

    <script type="text/javascript">
        function help() {
            <%=Gui.Help("page.optimizeexpress")%>
        }
    </script>

	<link href="/Admin/Module/eCom_Catalog/dw7/css/Optimize.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<form id="form1" runat="server">
	    <dw:Toolbar ID="TopTools" ShowStart="false" ShowEnd="false" runat="server">
            <dw:ToolbarButton ID="cmdHelp" Image="Help" Text="Help" OnClientClick="help()" runat="server" />
        </dw:Toolbar>
		<h2 class="subtitle">F
		    <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Choose a phrase or keyword you want to optimize this page for." />
		</h2>
		
		<div id="Div1" class="optimize-phrase-list" runat="server">
		    <table border="0">
		        <tr id="rowNothingFound" runat="server" valign="top">
		            <td class="optimize-no-phrases">
		                <div>
		                    <dw:TranslateLabel ID="lbNothingFound" Text="No phrases found" runat="server" />
		                </div>
		            </td>
		        </tr>
		        <asp:Literal ID="Phrase1" runat="server"></asp:Literal>
		        <asp:Literal ID="Phrase2" runat="server"></asp:Literal>
		        <asp:Literal ID="Phrase3" runat="server"></asp:Literal>
		        <asp:Literal ID="Phrase4" runat="server"></asp:Literal>
		        <asp:Literal ID="Phrase5" runat="server"></asp:Literal>
		    </table>
		</div>
		
		<div class="optimize-phrase-custom">
            <span>
                <dw:TranslateLabel ID="lbUserDefined" Text="Brugerdefineret" runat="server" />
            </span>
            <input type="text" autocomplete="off" id="customPhrase" name="customPhrase" onfocus="this.select();" oncontextmenu="return false;" value="" /><input id="cmdSubmitPhrase" type="image" src="/Admin/Module/eCom_Catalog/dw7/images/optimize-keyword-add.png" onclick="choose(document.getElementById('customPhrase').value); return false;" alt="" border="0" />
        </div>
	</form>
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
