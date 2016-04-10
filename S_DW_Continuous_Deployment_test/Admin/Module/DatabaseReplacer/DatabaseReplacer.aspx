<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DatabaseReplacer.aspx.vb" Inherits="Dynamicweb.Admin.DatabaseReplacer" ValidateRequest="False"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<title>
			<%=Translate.JSTranslate("DB Søg og erstat",9)%>
		</title>
		<link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
		<style type="text/css">
		.searchword { BACKGROUND-COLOR: yellow }
		</style>
		<script type="text/javascript">
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
				//alert(strWord);
				if(strWord.length > 0){
					//alert(document.getElementById('table1'));
					highlightWord(document.getElementById('table1'),strWord);
				}
			}
		}
		</script>
	</HEAD>
	<body onload="highlight();">
		<form id="Form1" style="MARGIN: 0px" method="post" runat="server">
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td valign="top">
						<dw:groupboxstart id="GroupBoxStart1" runat="server" title="Indstillinger" />
						<table>
							<tr>
								<td width="170"><%=Translate.Translate("Database")%></td>
								<td><asp:dropdownlist id="DatabaseList" runat="server" cssclass="std" autopostback="True"></asp:dropdownlist></td>
								<td></td>
							</tr>
							<tr id="TableListRow" runat="server" name="ResultTextRow">
								<td><%=Translate.Translate("Tabel")%></td>
								<td><asp:dropdownlist id="TableList" runat="server" cssclass="std" autopostback="True"></asp:dropdownlist></td>
								<td></td>
							</tr>
							<tr id="FieldListRow" runat="server" name="ResultTextRow">
								<td><%=Translate.Translate("Felt")%></td>
								<td><asp:dropdownlist id="FieldList" runat="server" cssclass="std" autopostback="True"></asp:dropdownlist></td>
								<td></td>
							</tr>
							<tr id="ReplaceStringRow" runat="server" name="ResultTextRow">
								<td><%=Translate.Translate("Søg efter")%></td>
								<td><asp:textbox id="ReplaceString" runat="server" cssclass="std" name="ReplaceString"></asp:textbox></td>
								<td><asp:RequiredFieldValidator ID="replaceStringValidator" runat="server"
                                            ErrorMessage="required" ControlToValidate="ReplaceString" /></td>
							</tr>
							<tr id="ReplaceWithRow" runat="server" name="ResultTextRow">
								<td><%=Translate.Translate("Erstat med")%></td>
								<td><asp:textbox id="ReplaceWith" runat="server" cssclass="std"></asp:textbox></td>
								<td></td>
							</tr>
							<tr id="ResultTextRow" height="25" runat="server" name="ResultTextRow">
								<td colspan="2"><asp:label id="ResultText" runat="server" font-bold="True" forecolor="#C00000"></asp:label></td>
								<td></td>
							</tr>
							<tr id="ButtonRow" runat="server" name="ButtonRow">
								<td colspan="2" align="right">
									<asp:textbox id="PrimaryKey" runat="server" visible="False"></asp:textbox>
									<asp:button id="DisplaySearchButton" runat="server" text="Find" />
									<asp:button id="SearchButton" runat="server" text="Erstat alle" />
								</td>
								<td></td>
							</tr>
						</table>
						<dw:groupboxend id="GroupBoxEnd1" runat="server" />
					</td>
				</tr>
				<tr id="DisplaySearchResultRow" runat="server" name="DisplaySearchResultRow">
					<td>
						<dw:groupboxstart id="GroupBoxStart2" title="Poster" runat="server" />
						<div style="OVERFLOW:auto;WIDTH:570px;HEIGHT:500px">
							<table id="table1">
								<tr>
									<td>
										<asp:datagrid id="DisplaySearchResult" runat="server" datasource="<%# SearchResult %>" width="560px" enableviewstate="False" bordercolor="White" borderstyle="Ridge" borderwidth="2px" backcolor="White" cellpadding="3" gridlines="None" cellspacing="1">
											<FooterStyle ForeColor="Black" BackColor="#C6C3C6"></FooterStyle>
											<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#9471DE"></SelectedItemStyle>
											<ItemStyle ForeColor="Black" BackColor="#DEDFDE"></ItemStyle>
											<HeaderStyle Font-Bold="True" ForeColor="#E7E7FF" BackColor="InactiveCaptionText"></HeaderStyle>
											<PagerStyle HorizontalAlign="Right" ForeColor="Black" BackColor="#C6C3C6"></PagerStyle>
										</asp:datagrid>
									</td>
								</tr>
							</table>
						</div>
						<dw:groupboxend id="Groupboxend2" runat="server" />
					</td>
				</tr>
			</table>
		</form>
		<%Translate.GetEditOnlineScript()%>
	</body>
</HTML>
