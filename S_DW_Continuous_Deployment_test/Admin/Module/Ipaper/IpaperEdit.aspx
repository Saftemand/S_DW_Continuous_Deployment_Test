<%@ IMPORT namespace="Dynamicweb.Backend" %>
<%@ IMPORT namespace="Dynamicweb" %>
<%@ Page language="vb" autoeventwireup="false" codebehind="IpaperEdit.aspx.vb" inherits="Dynamicweb.Admin.Ipaper.Backend.IpaperEdit" %>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<script language="javascript" src="functions.js"></script>
	</HEAD>
	<body>
		<%=Gui.MakeHeaders(Translate.Translate("Ipaper", 9), Translate.Translate("Ipaper", 9) & ", " & Translate.Translate("Indeks"), "All", False, "")%>
		<form method="post" style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" runat="server">
			<input type="hidden" name="_ID" id="_ID" runat="server"> 
			<input type="hidden" name="_CategoryID" id="_CategoryID" class="std" runat="server">
			<div id="Tab1">
				<table border="0" cellpadding="0" cellspacing="0" class="tabtable" height="100%">
					<tr>
						<td valign="top"><br>
							<%=Gui.GroupBoxStart(Translate.Translate("iPaper"))%>
							<table>
								<tr>
									<td width="170"><%=Translate.Translate("Navn")%></td>
									<td><asp:TextBox runat="server" ID="txtName" CssClass="std" maxLength = "50" /></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd()%>
							<br />
							<%=Gui.GroupBoxStart(Translate.Translate("PDF"))%>
							<div style="margin: 7px">
								<% If Saved Then %>
									<% 	If Not Request.QueryString("PDF") Is Nothing And Request.QueryString("PDF") = "1" Then%>
										<span style="color: #009900">
											<%= Translate.Translate("PDF filen") %> '<%# getLastProcessedPDF() %>' <%=Translate.Translate("blev behandlet successfuldt!")%><br />
											<br />
										</span>
									<% End If %>
									<span style="width: 110px"><%= Translate.Translate("Sidst behandlet") %>:</span><%# getLastProcessedText() %><br />
									<span style="width: 110px"><%= Translate.Translate("PDF") %>:</span><%# getLastProcessedPDF() %><br />
									<span style="width: 110px"><%= Translate.Translate("Antal sider") %>:</span><%# getNumberOfPages() %><br />
									<br />
									<div style="text-align: right">
										<input type="button" value="<%=Translate.JsTranslate("Behandl ny PDF") %>" onclick="$('processPDF').style.display=''; this.style.display='none'" style="font-size: 12px; width: 118px" />
									</div>
								<% Else %>
									<%= Translate.Translate("iPaperen skal først gemmes førend PDF kan behandles") %>.
								<% End If %>
							</div>
							<%=Gui.GroupBoxEnd()%>
							<br />
							<div id="processPDF" style="display: none">
								<%=Gui.GroupBoxStart(Translate.Translate("Behandling af ny PDF")) %>
								<div style="margin: 7px">
									<table>
										<tr>
											<td style="width: 163px"><%= Translate.Translate("PDF") %></td>
											<td><%= Gui.FileManager("", Dynamicweb.Content.Management.Installation.FilesFolderName, "PDFFile", "pdf")%></td>
										</tr>
									</table>
									<br />
									<div style="text-align: right">
										<input type="button" value="<%=Translate.JsTranslate("Behandl PDF") %>" onclick="javascript:processPDF();" id="btnProcessPDF" style="font-size: 12px" />
									</div>
									<div id="dvProgress" style="display: none">
										<%= Translate.Translate("Behandler PDF") %>...
										<div style="background-color: #D1D1D1; height: 18px">
											<div style="width: 0%; background-image: url('Images/pbar.gif'); height: 18px" id="pbar"></div>
										</div>
									</div>
								</div>
								<%=Gui.GroupBoxEnd() %>
								<br />
								<iframe id="frmPDF" style="display: none"></iframe>
							</div>
							
							<script type="text/javascript">
								function doWait(e){
									if(event.srcElement != null && event.srcElement.style != null)
										event.srcElement.style.cursor = 'wait';
								}
								
								function processPDF()
								{
									if($('FM_PDFFile').value == "")
									{
										alert('<%= Translate.JsTranslate("Du skal først vælge en PDF fil") %>.');
										return;
									}
									else
									{
										//$('tblButtons').outerHTML = $('tblButtons').outerHTML.split('<INPUT').join('<INPUT disabled').split('<BUTTON').join('<BUTTON disabled');
										$('tblButtons').parentNode.innerHTML = '<div></div>';
										$('rptLanguages').disabled = true;
										$('rptSettings').disabled = true;
										$('FM_PDFFile').disabled = true;
										$('txtName').disabled = true;
										$('btnProcessPDF').style.display = 'none';
										
										document.onmousemove = doWait;
										
										$('dvProgress').style.display = ''
										
										//window.open('IpaperProcess.aspx?ID=<%= Request.QueryString("ID") %>&CategoryID=<%= Request.QueryString("CategoryID") %>&File=' + $('PDFFile').value);
										$('frmPDF').src = 'IpaperProcess.aspx?ID=<%= Request.QueryString("ID") %>&CategoryID=<%= Request.QueryString("CategoryID") %>&File=' + escape($('FM_PDFFile').value);
										
										$('pbar').style.width = '5%';
									}
								}
								
								function validate()
								{
									if($('rptSettings').value.length == 0)
									{
										alert('<%= Translate.JSTranslate("Du skal først vælge en indstilling før iPaperen kan gemmes.") %>');
										return;
									}
									
									if($('txtName').value.length == 0)
									{
										alert('<%= Translate.JSTranslate("Du skal først give iPaperen et navn.") %>');
										return;
									}
									
									if($('rptLanguages').value.length == 0)
									{
										alert('<%= Translate.JSTranslate("Du skal først vælge et sprog før iPaperen kan gemmes.") %>');
										return;
									}
									
									document.forms[0].submit()
								}
							</script>
							
							<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
							<table>
								<tr>
									<td width="170"><%=Translate.Translate("Vælg indstilling")%></td>
									<td><asp:DropDownList ID="rptSettings" runat="server" CssClass="std" DataTextField="Name" DataValueField="SetID" /></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Vælg sprog")%></td>
									<td><asp:DropDownList ID="rptLanguages" runat="server" CssClass="std" DataTextField="Name" DataValueField="LanguageID" /></td>
								</tr>
								<tr <% If NOT Base.HasAccess("IpaperExtended", "") Then %>style="display: none"<% End If %>>
									<td width="170"><%=Translate.Translate("Medtag kategori som arkiv")%></td>
									<td><asp:CheckBox runat="server" ID="chkArchive" style="cursor: pointer" /></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd()%>
							<br />
							<%=Gui.GroupBoxStart(Translate.Translate("Logo"))%>
							<table>
								<tr>
									<td width="170"></td>
									<td><i><%=Translate.Translate("Logoet vil blive vist med en højde på 35px.")%></i></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Vælg logo")%></td>
									<td><%= Gui.FileManager(logoFile, Dynamicweb.Content.Management.Installation.FilesFolderName, "Logo", "jpg,gif")%></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Link")%></td>
									<td><asp:TextBox runat="server" ID="txtLogoURL" CssClass="std" maxLength = "255" /></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd()%>
							<br />
						</td>
					</tr>
					<tr valign="bottom">
						<td align="right" colspan="2">
						<br />
							<table id="tblButtons">
								<tr>
									<td><%=Gui.Button("OK", "validate();", 0)%></td>
									<td><%=Gui.Button(Translate.Translate("Annuller"), "location = 'IpaperList.aspx?ID=" & Request("CategoryID") & "';", 0)%>
                                    <%=Gui.HelpButton("form", "modules.ipaper.general.category.edit.ipaper.edit")%></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<div id="Tab2" style="DISPLAY: none">
				<table border="0" cellpadding="0" cellspacing="0" class="tabtable" height="100%">
					<tr>
						<td valign="top"><br>
							<%=Gui.GroupBoxStart(Translate.Translate("Indeks"))%>
							<table>
								<tr>
									<td width="170"><b><%=Translate.Translate("Side")%> #</b></td>
									<td><b><%= Translate.Translate("Indeks") %></b></td>
								</tr>
								<asp:Repeater ID="rptIndex" runat="server">
									<ItemTemplate>
										<tr>
											<td><%#DataBinder.Eval(Container.DataItem, "Number")%></td>
											<td><input type="text" name="index_<%# DataBinder.Eval(Container.DataItem, "PageID") %>" value="<%# DataBinder.Eval(Container.DataItem, "Index") %>" class="std" maxLength = "255" /></td>
										</tr>
									</ItemTemplate>
								</asp:Repeater>
							</table>
							<asp:PlaceHolder runat="server" ID="plcNoPages">
								<br />
								<i style="padding-left: 15px"><%= Translate.Translate("Der er p.t. ingen sider") %>.</i><br />
								<br />
							</asp:PlaceHolder>
							<%=Gui.GroupBoxEnd()%>
						</td>
					</tr>
					<tr valign="bottom">
						<td align="right" colspan="2">
						<br />
							<table id="tblButtons">
								<tr>
									<td><%=Gui.Button("OK", "validate();", 0)%></td>
									<td><%=Gui.Button(Translate.Translate("Annuller"), "location = 'IpaperList.aspx?ID=" & Request("CategoryID") & "';", 0)%>
                                    <%=Gui.HelpButton("form", "modules.ipaper.general.category.edit.ipaper.edit")%></td>
                                </tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<%=Gui.SelectTab()%>
		<%Translate.GetEditOnlineScript()%>
	</body>
</HTML>