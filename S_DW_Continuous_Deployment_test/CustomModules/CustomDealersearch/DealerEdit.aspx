<%@ Page AutoEventWireup="true" Codebehind="DealerEdit.aspx.cs" Inherits="DealerEdit" Language="C#" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%
	string Description = this.Description;
	int CategoryID = Dynamicweb.Base.chkInteger(Request.QueryString["CategoryID"]);
%>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<title></title>
		<link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<%=Gui.MakeHeaders("Rediger forhandler", "Forhandler, Beskrivelse", "Javascript", false, "")%>
	</head>
	<body>
		<%=Gui.MakeHeaders("Forhandler", "Forhandler, Beskrivelse", "Html", false, "")%>
		<table class="tabTable" style="HEIGHT: 180px" cellspacing="0" cellpadding="0" border="0">
			<form action="DealerSave.aspx" method="post">
				<input id="_ID" type="hidden" name="_ID" runat="server"> 
				<input id="CategoryID" type="hidden" name="CategoryID" value="<%=CategoryID%>">
					<tr>
						<td valign="top"><br>
							<div id="Tab1" style="display:;">
							<%=Gui.GroupBoxStart("Adresse")%>
							<table>
								<tr>
									<td width="170">Navn</td>
									<td><input class="std" id="Name" type="text" name="Name" runat="server"></td>
								</tr>
								<tr>
									<td>Adresse</td>
									<td><input class="std" id="Adress" type="text" name="Adress" runat="server"></td>
								</tr>
								<tr>
									<td>Adresse 2</td>
									<td><input class="std" id="Adress2" type="text" name="Adress2" runat="server"></td>
								</tr>
								<tr>
									<td>Postnummer</td>
									<td><input type="text" name="Zip" id="Zip" class="std" runat="server"></td>
								</tr>
								<tr>
									<td>By</td>
									<td><input type="text" name="City" id="City" class="std" runat="server"></td>
								</tr>
								<tr>
									<td>Land</td>
									<td><input type="text" name="Country" id="Country" class="std" runat="server"></td>
								</tr>
								</table>
							<%=Gui.GroupBoxEnd()%>
							<%=Gui.GroupBoxStart("Kontakt")%>
							<table>
								<tr>
									<td width="170">Telefon 1</td>
									<td><input type="text" name="Phone1" id="Phone1" class="std" runat="server"></td>
								</tr>
								<tr>
									<td>Telefon 2</td>
									<td><input type="text" name="Phone2" id="Phone2" class="std" runat="server"></td>
								</tr>
								<tr>
									<td>Fax 1</td>
									<td><input type="text" name="Fax1" id="Fax1" class="std" runat="server"></td>
								</tr>
								<tr>
									<td>Fax 2</td>
									<td><input type="text" name="Fax2" id="Fax2" class="std" runat="server"></td>
								</tr>
								<tr>
									<td>E-mail</td>
									<td><input type="text" name="Email" id="Email" class="std" runat="server"></td>
								</tr>
								<tr>
									<td>Website</td>
									<td><input type="text" name="Website" id="Website" class="std" runat="server"></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd()%>
							</div>
							<div id="Tab2" style="display:none;">
							<%=Gui.GroupBoxStart("Beskrivelse")%>
							<table>
								<tr>
									<td><%=Gui.Editor("Description", 0, 0, Description)%></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd()%>
							</div>
						</td>
					</tr>
					<tr>
						<td align="right" colspan="2">
							<table>
								<tr>
									<td><%=Gui.Button("OK", "html();document.forms[0].submit();", 0)%></td>
									<td><%=Gui.Button("Annuller", "location = 'DealerList.aspx?ID=" & CategoryID.ToString & "';", 0)%></td>
								</tr>
							</table>
						</td>
					</tr>
			</form>
		</table>
	</body>
</html>
