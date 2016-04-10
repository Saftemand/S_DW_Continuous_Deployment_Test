<%@ Page AutoEventWireup="false" Codebehind="List.aspx.vb" Inherits="Dynamicweb.Admin.List1"
	Language="vb" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<link href="/Admin/Stylesheet.css" rel="stylesheet" />
	<script type="text/javascript" src="../../Filemanager/FileEditor/jquery/jquery.js"></script>
	
	<title>Untitled Page</title>

	<script language="javascript" type="text/javascript">
	    $(document).ready(function() {

	        var textbox = $('div.search input[type="text"]');
	        if (textbox && textbox.length > 0) {
	            textbox = $(textbox[0]);
	            
	            textbox.bind('keydown', function(event) {
	                return event.keyCode != 13;
	            });

	            textbox.bind('keyup', { caller: textbox }, function(event) {
	                var value = event.data.caller.val();
	                var highlighted = $('tr.highlight');
	                var matchedData = null;

	                // clearing all previously highlighted rows
	                if (highlighted && highlighted.length > 0) {
	                    for (var i = 0; i < highlighted.length; i++)
	                        $(highlighted[i]).removeClass('highlight');
	                }

	                // highlighting all matched rows (searching in a hidden field which contains concatenated row values)
	                if (value.length > 0) {
	                    matchedData = $('tr.row input[value*="' + value + '"]');
	                    if (matchedData && matchedData.length > 0) {
	                        for (var i = 0; i < matchedData.length; i++)
	                            $(matchedData[i]).parent().parent().addClass('highlight');
	                    }
	                }
	            });
	        }
	    });
	
	function Del(PathID){
		if(confirm('<%=Translate.Translate("Slet")%>?')){
			location = "List.aspx?Action=Delete&ID="+PathID
		}
	}
	function Active(PathID, CurrentState){
		location = "List.aspx?SetState="+CurrentState+"&ID="+PathID
	}
	</script>

	<style type="text/css">
	.CTrue{display:;}
	.CFalse{display:none;}
	.MTrue{display:none;}
	.MFalse{display:;}
	
	.highlight
	{
		background-color: #ffefe5;
	}
	
	</style>
</head>
<body>
	<form id="form1" enableviewstate="false" runat="server">
		<dw:TabHeader ID="header1" runat="server" Headers="" Title="" />
		<div id="Tab1">
			<table class="tabTable" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td valign="top">
					    <asp:Panel ID="panelSearch" CssClass="search" runat="server">
					    <dw:GroupBoxStart ID="gbSerchStart" Title="Search" runat="server" />
					        <table cellspacing="0" cellpadding="0" border="0" width="100%">
					            <tr>
					                <td>&nbsp;</td>
					            </tr>
					            <tr>
					                <td>
					                    <dw:TranslateLabel ID="lbSearch" Text="Search" runat="server" />
					                </td>
					                <td width="80%">
					                    <asp:TextBox ID="txSearch" Width="90%" runat="server" />
					                </td>
					            </tr>
					            <tr>
					                <td>&nbsp;</td>
					            </tr>
					        </table>
					        <dw:GroupBoxEnd ID="gbSearchEnd" runat="server" />
					        <br />
					    </asp:Panel>
						<asp:Repeater runat="server" EnableViewState="false" ID="PathRepeater">
							<HeaderTemplate>
								<table cellpadding="0" cellspacing="0" style="margin: 2px; width: 590px;" border="0">
									<tr height="20">
										<td id="columnPath" runat="server" style="width: 130px">
											<strong>
											    <a id="lnkSortByPath" runat="server">
												    <%=Translate.Translate("Sti")%>
												</a>
											</strong>
											<img id="imgSortByPath" src="" visible="false" alt="" runat="server" />
										</td>
										<td id="columnRedirect" runat="server" style="width: 204px">
											<strong>
											    <a id="lnkSortByRedirect" runat="server">
												    <%=Translate.Translate("Link")%>
												</a>
											</strong>
											<img id="imgSortByRedirect" src="" visible="false" alt="" runat="server" />
										</td>
										<td id="columnActive" runat="server" style="text-align: center">
											<strong>
											    <a id="lnkSortByActive" runat="server" style="width: 96px">
												    <%=Translate.Translate("Aktiv")%>
												</a>
											</strong>
											<img id="imgSortByActive" src="" visible="false" alt="" runat="server" />
										</td>
										<td id="columnStatus" runat="server" style="width: 96px; text-align: center">
											<strong>
											    <a id="lnkSortByStatus" runat="server">
												    <%=Translate.Translate("Status")%>
												</a>
											</strong>
											<img id="imgSortByStatus" src="" visible="false" alt="" runat="server" />
										</td>
										<td style="text-align: center">
											<strong>
												<%=Translate.Translate("Slet")%>
											</strong>
										</td>
									</tr>
									<tr>
										<td colspan="5" style="background-color: #C4C4C4;">
											<img alt="" src="/Admin/images/nothing.gif" style="width: 1px; height: 1px; border: none;"></td>
									</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr height="20" class="row">
									<td>
									    <input type="hidden" ID="rowData" runat="server" value="" />
									    
										<a href="http://<%# request.servervariables("SERVER_NAME") & "/" & Eval("UrlPathPath") %>"
											target="_blank">
											<img src="/Admin/Images/Icons/Module_UrlPath_small.gif" border="0" align="absmiddle" /></a>
										<asp:HyperLink ID="lnkView" runat="server" NavigateUrl='<%# "PathEdit.aspx?ID=" & Eval("UrlPathID") %>'
											Text='<%# Eval("UrlPathPath") %>'>
										</asp:HyperLink>
									</td>
									<td>
										<a href="/<%#Eval("UrlPathRedirect")%>" target="_blank">
											<nbr><%#Eval("UrlPathRedirect")%></nbr>
										</a>
									</td>
									<td style="text-align: center">
										<a href="#" onclick="Active('<%# Eval("UrlPathID") %>', '<%#Eval("UrlPathActive")%>');">
											<img border="0" class="C<%#Eval("UrlPathActive")%>" src="/Admin/Images/Check.gif" />
											<img border="0" class="M<%#Eval("UrlPathActive")%>" src="/Admin/Images/Minus.gif" /></a>
									</td>
									<td style="text-align: center">
										<%#Eval("UrlPathStatus")%>
									</td>
									<td style="text-align: center">
										<a href="#" onclick="Del('<%# Eval("UrlPathID") %>');">
											<img alt="" src="/Admin/images/Delete.gif" style="border: none;" runat="server" id="delimg" /></a></td>
								</tr>
								<tr>
									<td colspan="5" style="background-color: #C4C4C4;">
										<img alt="" src="/Admin/images/nothing.gif" style="width: 1px; height: 1px; border: none;"></td>
								</tr>
							</ItemTemplate>
							<FooterTemplate>
								</table>
							</FooterTemplate>
						</asp:Repeater>
						
					</td>
				</tr>
				<tr>
				<td valign="bottom" align="right" style="padding:5px;">
					<%=Dynamicweb.Gui.Button(Translate.Translate("Ny sti"), "location='PathEdit.aspx';", 200)%>
					<%=Dynamicweb.Gui.Button(Translate.Translate("Luk"), "location='/Admin/Module/Modules.aspx';", 200)%>
					<%=Dynamicweb.Gui.HelpButton("modules.urlpath.general.list.item")%>
				</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>