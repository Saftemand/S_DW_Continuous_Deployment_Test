<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PhraseEdit.aspx.vb" inherits="Dynamicweb.Admin.PhraseEdit"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
		    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
		    <script type="text/javascript" src="/Admin/Content/JsLib/dw/RequestQueue.js"></script>
		    <script type="text/javascript" src="/Admin/Module/Seo/Seo.js"></script>
		
			<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
			<script language="javascript">
			function deletePhrase(PhraseId){
				location = "PhraseEdit.aspx?cmd=delete&ID=<%=Base.Request("ID")%>&PhraseId=" + PhraseId;
			}
			
			var lang = '<%=CurrentLanguage %>';
			var list = null;
			
			function updatePhraseList() {
			    if(!list) {
			        list = new Seo.PhrasesList('tabPhrases');
			        list.set_state(new Seo.Progress('progressContainer'));
			    }
			    
			    list.update({ language: lang });
			}
			
			</script>
	</head>
	<body onload="parent.ac1(parent.document.getElementById('PhraseEdit'))">
		<form id="Form1" method="post" runat="server">
			<dw:tabheader id="TabHeader1" runat="server" title="Phrases" returnwhat="All" headers="Phrases"></dw:tabheader>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
				<tr>
					<td valign="top">
						<table border="0" cellpadding="0" width="598" id="tabPhrases">
						    <tr id="progressContainer" style="display: none">
				                <td colspan="4">
				                    <dw:GroupBox ID="gbUpdating" Title="Updating" runat="server">
                                        <table width="100%">
                                            <tr>
                                                <td align="center">
                                                    <dw:TranslateLabel ID="lpPleaseWait" Text="Please wait while data is being retrieved..." runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <img src="Dynamicweb_wait.gif" alt="" border="0" />
                                                </td>
                                            </tr>
                                        </table>
                                    </dw:GroupBox>
                                </td>
                            </tr>
							<tr>
								<td width="250">
									<strong><dw:translatelabel id="TranslateLabel1" runat="server" text="Phrase"></dw:translatelabel></strong>
								</td>
								<td width="30">
									<strong><dw:translatelabel id="Translatelabel5" runat="server" text="Competition"></dw:translatelabel></strong>
								</td>
								<td width="288">
									<strong><dw:translatelabel id="Translatelabel4" runat="server" text="Number 1"></dw:translatelabel></strong>
								</td>
								<td align="right"><nobr><strong><dw:translatelabel id="Translatelabel2" runat="server" text="Slet"></dw:translatelabel></strong></nobr></td>
							</tr>
							<tr>
								<td colspan="4"><img src="../images/nothing.gif" width="591" height="1" alt="" border="0" style="BACKGROUND-COLOR:#cccccc"></td>
							</tr>
							
							<%=getPhraseList()%>
							
							<tr>
								<td colspan="4"><dw:translatelabel id="TranslateLabel3" runat="server" text="Add phrase"></dw:translatelabel> <asp:textbox id="NewPhrase" runat="server" cssclass="std"></asp:textbox> <asp:button id="AddPhraseButton" CssClass="buttonSubmit" runat="server" text="Add"></asp:button></td>
							</tr>
							
						</table>
					</td>
				</tr>
			</table>
		</form>
		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
	
	<script language="javascript">
	    updatePhraseList();
	</script>
</html>
