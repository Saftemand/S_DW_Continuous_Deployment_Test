<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim ShopGroupProductTemplate As String
Dim ShopGroupDocTemplateID As Integer
Dim ShopGroupID As Integer
Dim ShopGroupActiveTo As Date
Dim SQL As String
Dim ShopGroupName As String
Dim ShopCustomFieldsList As String
Dim ShopGroupActive As String
Dim ShopGroupNumber As String
Dim ShopGroupActiveFrom As Date
Dim ShopGroupFieldGroupID As String
Dim ShopGroupParentID As Integer
Dim ShopCustomFieldsListElement As String
Dim Tabs As String
Dim strTopHeader as string
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			01-08-2002
'	Last modfied:		01-08-2002
'
'	Purpose: Show/edit groups
'
'	Revision history:
'		1.0   - 01-08-2002 - Nicolai Pedersen
'		First Version
'**************************************************************************************************
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script language="JavaScript">
function Send(FileToHandle){
	if (document.getElementById('ShopGroup').ShopGroupName.value.length < 1){
		alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
	}else{
		document.getElementById('ShopGroup').action = FileToHandle;
		document.getElementById('ShopGroup').submit();
	}
}

function AddPage(ID, AreaID, Name){
	movepageWindow = window.open(Home + "Menu.aspx?ID=" + ID + "&Action=AddPage&Caller="+ Name + "&AreaID=" + AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=200,height=350,top=155,left=402");
}
</script>
</HEAD>
<%

Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

If IsNothing(request.QueryString("ID")) Then
	ShopGroupID = 0
	ShopGroupName = ""
	ShopGroupActive = 1
	ShopGroupActiveFrom = Dates.DWnow()
	ShopGroupActiveTo = "2999-12-31 23:59"
	ShopGroupDocTemplateID = 0
	ShopGroupFieldGroupID = "0"
	ShopGroupProductTemplate = ""
	ShopCustomFieldsList = ""
	ShopCustomFieldsListElement = ""
	
	If Not IsNothing(request.QueryString("Uid")) Then
		ShopGroupParentID = request.QueryString("Uid")
	Else
		ShopGroupParentID = "0"
	End If
Else

	ShopGroupID = request.QueryString("ID")
	SQL = "SELECT * FROM ShopGroup WHERE ShopGroupID = " & ShopGroupID

	sCmdShop.CommandText = sql

	Dim drGroupReader As IDataReader = sCmdShop.ExecuteReader()

	If drGroupReader.Read Then
		ShopGroupID = drGroupReader("ShopGroupID").ToString
		ShopGroupParentID = drGroupReader("ShopGroupParentID").ToString
		ShopGroupName = drGroupReader("ShopGroupName").ToString
		ShopGroupActive = drGroupReader("ShopGroupActive").ToString
		ShopGroupActiveFrom = drGroupReader("ShopGroupActiveFrom").ToString
		ShopGroupActiveTo = drGroupReader("ShopGroupActiveTo").ToString
		ShopGroupNumber = drGroupReader("ShopGroupNumber").ToString
		ShopGroupDocTemplateID = Base.ChkNumber(drGroupReader("ShopGroupDocTemplateID").ToString)
		ShopGroupFieldGroupID = Base.ChkNumber(drGroupReader("ShopGroupFieldGroupID").ToString)
		ShopGroupProductTemplate = drGroupReader("ShopGroupProductTemplate").ToString
		ShopCustomFieldsList = drGroupReader("ShopGroupCustomFieldsList").ToString
		ShopCustomFieldsListElement = drGroupReader("ShopGroupCustomFieldsListElement").ToString
	End If
	
	drGroupReader.Dispose
	
End If

If Not IsNothing(request.QueryString("Tab")) Then%>
	<BODY>
<%Else%>
	<BODY onLoad="document.getElementById('ShopGroup').ShopGroupName.focus();">
<%End If%>

<span class="body">
<%
	Tabs = Translate.Translate("Gruppe")
	if IsNothing(request.QueryString("ID")) then 
		strTopHeader=Translate.Translate("Ny gruppe")
	else
		strTopHeader=Translate.Translate("Rediger gruppe - %%", "%%", ShopGroupName)
	end if
%>
<%=Gui.MakeHeaders(strTopHeader, Tabs, "all")%>
<table border="0" cellpadding="0" cellspacing=0 class=tabTable>
<tr><td valign=top>
	<form name="ShopGroup" id="ShopGroup" method="Post">
	<input type="hidden" name="ShopGroupID" value="<%=ShopGroupID%>">
	<input type="hidden" name="ShopGroupParentID" value="<%=ShopGroupParentID%>">
		<div ID="Tab1" STYLE="display:;">
		<br>
		<table border="0" cellpadding="0" width=598>
		<tr>
			<td colspan=2>
				<%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
				<table cellpadding=2 cellspacing=0>
					<tr>
						<td width=170><%=Translate.Translate("Navn")%></td>
						<td><input type="text" name="ShopGroupName" size="30" maxlength="255" value="<%=Server.HtmlEncode(ShopGroupName)%>" class=std></td>
					</tr>

					<tr>
						<td width=170><%=Translate.Translate("Varegruppenummer")%></td>
						<td><input type="text" name="ShopGroupNumber" size="30" maxlength="255" value="<%=Server.HtmlEncode(ShopGroupNumber)%>" class=std></td>
					</tr>
					<tr>
						<td width=170><%=Translate.Translate("Aktiv")%></td>
				      	<td><%=Gui.CheckBox(ShopGroupActive, "ShopGroupActive")%></td>
				    </tr>
				</table>
				<%=Gui.GroupBoxEnd%>
			</td>
		</tr>
		<%If Base.HasAccess("Dynamicdoc", "") Then%>
		<tr>
			<td colspan="2">
				<%=Gui.GroupBoxStart(Translate.Translate("Dynamicdoc"))%>
					<table cellpadding=2 cellspacing=0 ID="Table1">
						<tr>
							<td width=170><%=Translate.Translate("Brug template")%></td>
							<td><%=Gui.BrowseForTemplate(ShopGroupDocTemplateID, "ShopGroupDocTemplateID")%></td>
						</tr>
					</table>
				<%=Gui.GroupBoxEnd%>
			</td>
		</tr>
		<%End If%>
		<tr<%=Base.HasAccessHIDE("Publish", "")%>>
			<td colspan=2>
			<%=Gui.GroupBoxStart(Translate.Translate("Publicering"))%>
				<table cellpadding=2 cellspacing=0 border=0>
					<tr>
						<td width=170><%=Translate.Translate("Gyldig fra")%></td>
						<td><%Response.Write(Dates.DateSelect(ShopGroupActiveFrom, True, False, False, "ShopGroupActiveFrom"))%></td>
					</tr>
					<tr>
						<td valign=top><%=Translate.Translate("Gyldig til")%></td>
						<td><%Response.Write(Dates.DateSelect(ShopGroupActiveTo, True, False, True, "ShopGroupActiveTo"))%></td>
					</tr>
				</table>
			<%=Gui.GroupBoxEnd%>
			</td>
		</tr>
				<%If Base.HasVersion("18.5.1.0") Then%>
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Vare felt gruppe"))%>
						<table cellpadding=2 cellspacing=0 border=0>
							<tr>
								<td width=170><%= Translate.Translate("Vælg feltgruppe")%></td>
								<td>
								<%	
								SQL = "SELECT * FROM ShopProductFieldGroup"
								sCmdShop.CommandText = sql

								Dim drProductFieldGroup As IDataReader = sCmdShop.ExecuteReader()

								Response.Write("<SELECT NAME=""SelectFieldGroups"" ID=""SelectFieldGroups"" class=""std"">")
								Response.Write("	<option value=""0"" ")

								If ShopGroupFieldGroupID = "" Or ShopGroupFieldGroupID = 0 Or IsDbNull(ShopGroupFieldGroupID) Then
									Response.Write("SELECTED")
								End If
								Response.Write(">" & Translate.Translate("Ingen valgt") & "</option>")
								
								Do While drProductFieldGroup.Read
									Response.Write("<option value=""" & drProductFieldGroup("ShopProductFieldGroupID").ToString & """")
									If ShopGroupFieldGroupID = drProductFieldGroup("ShopProductFieldGroupID").ToString Then
										Response.Write(" SELECTED")
									End If
									Response.Write(">" & drProductFieldGroup("ShopProductFieldGroupName").ToString & "</option>")
								Loop 
								Response.Write("</select>")

								%>
								</td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr>
					<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
						<table cellpadding=2 cellspacing=0 border=0>
							<TR>
								<TD valign="top" width="170"><%=Translate.Translate("Vare template")%></TD>
								<TD valign="top"><%=Gui.FileManager(ShopGroupProductTemplate, "Templates/Shop", "ShopGroupProductTemplate")%></TD>
							</TR>
							<TR>
								<TD valign="top" width="170"><%=Translate.Translate("Varefelter liste")%></TD>
								<TD valign="top"><%=Gui.FileManager(ShopCustomFieldsList, "Templates/Shop", "ShopCustomFieldsList")%></TD>
							</TR>
							<TR>
								<TD valign="top" width="170"><%=Translate.Translate("Varefelter elementer")%></TD>
								<TD valign="top"><%=Gui.FileManager(ShopCustomFieldsListElement, "Templates/Shop", "ShopCustomFieldsListElement")%></TD>
							</TR>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<%End If%>
			</table>
		</div>
		</td>
	</tr>
	<tr>
		<td align="right">
						<%=gui.MakeOkCancelHelp("Send('Group_save.aspx');", "location='Product_List.aspx?ID=" & request.QueryString("ID") & "';", True, "modules.shop.general.group.list.item.edit", "Shop_Group_Edit")%>
		</td>
	</tr>
</table>
</form>
<%
sCmdShop.Dispose
ShopConn.Dispose
%>
<%=Gui.SelectTab()%>
</BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>