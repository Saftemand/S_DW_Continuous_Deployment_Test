<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DealerEdit.aspx.vb" Inherits="Dynamicweb.Admin.DealerSearch.Backend.DealerEdit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%
Dim CategoryID As Integer = Request.QueryString("CategoryID")
%>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
			<%=Gui.MakeHeaders(Translate.JSTranslate("%m% - Rediger %c%","%m%",Translate.JSTranslate("Forhandlersøgning",9),"%c%",Translate.JSTranslate("forhandler")), Translate.JSTranslate("Forhandler"), "Javascript", false, "")%>
			<script>
function setDotPosition(x,y){
 document.getElementById('ElementForm').CoordinateX.value=x
 document.getElementById('ElementForm').CoordinateY.value=y
}
			</script>
			<SCRIPT language="javascript">
		<!--
			function Show(item) {
				document.all[item].style.display = '';
			}
			function Hide(item) {
				document.all[item].style.display = 'none';
			}
			function ValidateThisForm()
			{
				var form = document.forms["ElementForm"];
				var controlToValidate = form.elements["Name"];
				ValidateForm(form, controlToValidate, 
					"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>")
			}
		//-->
			</SCRIPT>
	</head>
	<body>
		<%
		Dim posTxt as String = Translate.Translate("position")
		
		%>
	
		<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Forhandlersøgning",9),"%c%",Translate.Translate("forhandler")), Translate.Translate("Forhandler"), "Html", false, "")%>
		<table class="tabTable" cellspacing="0" cellpadding="0" border="0">
			<form action="DealerSave.aspx" method="post" name="ElementForm">
				<input id="_ID" type="hidden" name="_ID" runat="server"> <input id="CategoryID" type="hidden" name="CategoryID" value="<%=CategoryID%>">
				<tr>
					<td valign="top"><br>
						<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
						<table cellspacing="0" cellpadding="2" border="0">
							<tr>
								<td width="170"><%=Translate.Translate("Type")%></td>
								<td valign="top">
									<SELECT name="TypeDealer" id="TypeDealer" class="std">
										<%
											Dim strSQL As String
											strSQL = "SELECT * FROM DealerSearchDealerType ORDER BY DealerSearchDealerTypeName "
											Dim cnDealerType As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
											Dim cmdDealerType As IDbCommand = cnDealerType.CreateCommand
											cmdDealerType.CommandText = strSQL
											Dim drDealerType as IDataReader = cmdDealerType.ExecuteReader()

											Do While drDealerType.Read()
												Response.Write("<OPTION " & IIf(CStr(TypeDealerID) = CStr(drDealerType("DealerSearchDealerTypeID")), "selected", "") & " value=""" & drDealerType("DealerSearchDealerTypeID") & """>" & drDealerType("DealerSearchDealerTypeName") & "</OPTION>")
											Loop 

											drDealerType.Close()
											drDealerType.Dispose()
											cmdDealerType.Dispose()
											cnDealerType.Dispose()
											%>
									</SELECT>
								</td>
							</tr>
							<tr>
								<td width="170"><%=Translate.Translate("Visning",1)%></td>
								<td><%=GetView()%></td>
							</tr>
							<tr>
								<td colspan="2"><strong><%=Translate.Translate("Detaljer")%></strong></td>
							</tr>
							<tr>
								<td width="170"><%=Translate.Translate("Navn")%></td>
								<td><input class="std" id="Name" type="text" name="Name" runat="server"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Adresse")%></td>
								<td><input class="std" id="Adress" type="text" name="Adress" runat="server"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Adresse2")%></td>
								<td><input class="std" id="Adress2" type="text" name="Adress2" runat="server"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Postnummer")%></td>
								<td><input type="text" name="Zip" id="Zip" class="std" runat="server"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("By")%></td>
								<td><input type="text" name="City" id="City" class="std" runat="server"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Land")%></td>
								<td><input type="text" name="Country" id="Country" class="std" runat="server"></td>
							</tr>
							<tr>
								<td width="170"><%=Translate.Translate("Telefon")%></td>
								<td><input type="text" name="Phone1" id="Phone1" class="std" runat="server"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Telefon2")%></td>
								<td><input type="text" name="Phone2" id="Phone2" class="std" runat="server"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Fax")%></td>
								<td><input type="text" name="Fax1" id="Fax1" class="std" runat="server"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Fax2")%></td>
								<td><input type="text" name="Fax2" id="Fax2" class="std" runat="server"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("E-mail")%></td>
								<td><input type="text" name="Email" id="Email" class="std" runat="server"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("URL")%></td>
								<td><input type="text" name="Website" id="Website" class="std" runat="server"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Billed")%></td>
								<td><%= Dynamicweb.Gui.FileManager(DealerImage, Dynamicweb.Content.Management.Installation.ImagesFolderName, "DealerImage")%></td>
							</tr>
							<tr>
								<td colspan="2"><strong><%=Translate.Translate("Brugerdefinerede felter")%></strong></td>
							</tr>
							<%=strUserFields%>
						</table>
						<%=Gui.GroupBoxEnd()%>
						<%=Gui.GroupBoxStart(Translate.Translate("Placering"))%>
						<table cellspacing="0" cellpadding="2" border="0">
							<tr style="display: none;">
								<td width="170"><%=Translate.Translate("X")%>-<%=posTxt%></td>
								<td><input type="text" name="CoordinateX" id="CoordinateX" class="std" runat="server"></td>
							</tr>
							<tr style="display: none;">
								<td><%=Translate.Translate("Y")%>-<%=posTxt%></td>
								<td><input type="text" name="CoordinateY" id="CoordinateY" class="std" runat="server"></td>
							</tr>
							<tr style="display: none;">
								<td valign="top" colspan="2"><%=Translate.Translate("Flyt markering")%></td>
							</tr>
							<tr>
								<td colspan="2">
								<%
								Dim builder As New System.Text.StringBuilder
								    builder.Append("<div class=""Object0"">")
								    builder.Append("<object width=""" & mapWidth & """ height=""" & mapHeight & """ classid=""clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"" codebase=""http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0"" id=""storelocator"" align=""middle"">")
								    builder.Append("<param name=""movie"" value=""/Admin/Module/DealerSearch/flash/storelocator_setdot.swf"" />")
								    builder.Append("<param name=""allowScriptAccess"" value=""sameDomain"" />")
								    builder.Append("<param name=""quality"" value=""high"" />")
								    builder.Append("<param name=""bgcolor"" value=""#ffffff"" />")
								    builder.Append("<param name=""menu"" value=""false"" />")
								    builder.Append("<param name=""FlashVars"" value=""imageURL=" & imageURL & "&xpos=" & objDealer.CoordinateX & "&ypos=" & objDealer.CoordinateY & "&xmlURL=" & HttpContext.Current.Server.UrlEncode("DealerList.aspx?id=" & Request.QueryString("CategoryID") & "&adminXML=true") & "&dotID=" & objDealer.ID & """ />")
										
								    builder.Append("<!--[if !IE]>-->")
								    builder.Append("<object type=""application/x-shockwave-flash"" data=""/Admin/Module/DealerSearch/flash/storelocator_setdot.swf"" width=""" & mapWidth & """ height=""" & mapHeight & """/>")
								    builder.Append("<param name=""movie"" value=""/Admin/Module/DealerSearch/flash/storelocator_setdot.swf"" />")
								    builder.Append("<param name=""allowScriptAccess"" value=""sameDomain"" />")
								    builder.Append("<param name=""quality"" value=""high"" />")
								    builder.Append("<param name=""bgcolor"" value=""#ffffff"" />")
								    builder.Append("<param name=""menu"" value=""false"" />")
								    builder.Append("<param name=""FlashVars"" value=""imageURL=" & imageURL & "&xpos=" & objDealer.CoordinateX & "&ypos=" & objDealer.CoordinateY & "&xmlURL=" & HttpContext.Current.Server.UrlEncode("DealerList.aspx?id=" & Request.QueryString("CategoryID") & "&adminXML=true") & "&dotID=" & objDealer.ID & """ />")

               
								    builder.Append("<!--<![endif]-->")
								    builder.Append("<a href=""http://www.adobe.com/go/getflashplayer"">")
								    builder.Append("<img src=""http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif"" alt=""Get Adobe Flash player"">")
								    builder.Append("</a>")
								    builder.Append("<!--[if !IE]>-->")
								    builder.Append("</object>")
								    builder.Append("<!--<![endif]-->")
								    builder.Append("</object>")
								    builder.Append("</div>")
									response.write(builder.ToString)
								%>
								
								</td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>
						<%=Gui.GroupBoxStart(Translate.Translate("Handlinger"))%>
						<table cellspacing="0" cellpadding="2" border="0">					
							<tr valign="top">
								<td width="170"><%=Translate.Translate("Mouseover")%></td>
								<td nowrap>
									<INPUT type="radio" class="clean" <%=Base.IIf(ActionRolloverID=1,"checked","") %> OnClick="javascript:Hide('RolloverText');" name="ActionRolloverID" id="radio01" value="1">
									<label for="radio01"><%=Translate.Translate("Intet")%></label><br />
									
									<INPUT type="radio" class="clean" <%=Base.IIf(ActionRolloverID=2,"checked","") %> OnClick="javascript:Hide('RolloverText');" name="ActionRolloverID" id="radio02" value="2">
									<label for="radio02"><%=Translate.Translate("Vis navn")%></label><br />
									
									<INPUT type="radio" class="clean" <%=Base.IIf(ActionRolloverID=3,"checked","") %> OnClick="javascript:Show('RolloverText');" name="ActionRolloverID" id="radio03" value="3">
									<label for="radio03"><%=Translate.Translate("Vis tekst")%></label><br />
									
									<span id="RolloverText" style="display:<%=Base.IIf(ActionRolloverID=3,"","none")%>; padding-left: 25px;">
									<input type="text" name="ActionRolloverText" value="<%=ActionRolloverText%>" class="std"><br />
									</span>
								</td>
							</tr>
							<tr valign="top">
								<td width="170"><%=Translate.Translate("Klik")%></td>
								<td nowrap>
									<input type="radio" class="clean" <%=Base.IIf(ActionClickID=1,"checked","") %> OnClick="Hide('RolloverURL'); Hide('RolloverTarget');" name="ActionClickID" id="radio1" value="1">
									<label for="radio1"><%=Translate.Translate("Vis detaljer", 1)%> (<%=Translate.Translate("Flash")%>)</label><br />
									
									<input type="radio" class="clean" <%=Base.IIf(ActionClickID=3,"checked","") %> onclick="Hide('RolloverURL'); Hide('RolloverTarget');" name="ActionClickID" id="radio3" value="3">
									<label for="radio3"><%=Translate.Translate("Vis detaljer", 1)%> (<%=Translate.Translate("Html")%>)</label><br />
									
									<input type="radio" class="clean" <%=Base.IIf(ActionClickID=2,"checked","") %> OnClick="Show('RolloverURL'); Show('RolloverTarget');" name="ActionClickID" id="radio2" value="2">
									<label for="radio2"><%=Translate.Translate("Link")%></label><br />
									
									<!--
									<input type="radio" class="clean" <%=Base.IIf(ActionClickID=3,"checked","") %> OnClick="javascript:Show('RolloverFile'); Hide('RolloverURL');" name="ActionClickID" id="radio3" value="3">
									<label for="radio3"><%=Translate.Translate("Fil")%></label><br />
									<span id="RolloverFile" style="display:<%=Base.IIf(ActionClickID=3,"","none")%>; padding-left:25px;">
									<%=Gui.FileManager(ActionClickFile, Dynamicweb.Content.Management.Installation.ImagesFolderName, "ActionClickFile")%>
									-->
									</span>
								</td>
							</tr>
							<tr valign="top" id="RolloverURL" style="display:<%=Base.IIf(ActionClickID=2,"","none")%>;">
								<td width="170"><%=Translate.Translate("Link")%></td>
								<td nowrap>
									<span style="padding-left:25px;">
									<%=Dynamicweb.Gui.LinkManager(ActionClickFile, "url", "ActionClickFile")%><br />
									</span>
								</td>
							</tr>
							<tr valign="top" id="RolloverTarget" style="display:<%=Base.IIf(ActionClickID=2,"","none")%>;">
								<td width="170"><%=Translate.Translate("Target")%></td>
								<td nowrap>
									<span style="padding-left:25px;">
									<select name="ActionClickTarget" id="ActionClickTarget" class="std">
										<option <%=Base.IIf(objDealer.ActionClickTarget = "", "selected", "")%> value=""><%=Translate.Translate("Standard")%></option>
										<option <%=Base.IIf(objDealer.ActionClickTarget = "_blank", "selected", "")%> value="_blank"><%=Translate.Translate("Nyt vindue (_blank)")%></option>
										<option <%=Base.IIf(objDealer.ActionClickTarget = "_top", "selected", "")%> value="_top"><%=Translate.Translate("Samme vindue (_top)")%></option>
										<option <%=Base.IIf(objDealer.ActionClickTarget = "_self", "selected", "")%> value="_self"><%=Translate.Translate("Samme ramme (_self)")%></option>
									</select>
									</span>
								</td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>
					</td>
				</tr>
				<tr>
					<td align="right" colspan="2">
						<table>
							<tr>
								<td><%=Gui.Button("OK", "ValidateThisForm();", 0)%></td>
								<td><%=Gui.Button(Translate.Translate("Annuller"), "location = 'DealerList.aspx?ID=" & CategoryID.ToString & "';", 0)%></td>
							</tr>
						</table>
					</td>
				</tr>
			</form>
		</table>
	</body>
</html>
<%Translate.GetEditOnlineScript()%>