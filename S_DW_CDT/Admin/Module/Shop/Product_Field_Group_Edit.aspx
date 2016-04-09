<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim GroupName As String
Dim ShopProductFieldGroupTag As String
Dim sql As String
Dim GroupID As Integer
Dim DW_SHOP_MAX_CUSTOMFIELDS As Integer
Dim ShopProductFieldGroupName As String
Dim i As Byte
Dim intRowCount As Integer
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: List fields
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

DW_SHOP_MAX_CUSTOMFIELDS = 100

Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShop As IDbCommand = ShopConn.CreateCommand

If Not IsNothing(request.QueryString("GroupID")) Then
	GroupID = request.QueryString("GroupID")
Else
	GroupID = 0
End If


sql = "SELECT * FROM ShopProductFieldGroup WHERE ShopProductFieldGroupID = " & GroupID

cmdShop.CommandText = sql

Dim drFieldGroupReader As IDataReader = cmdShop.ExecuteReader()

Dim opShopProductFieldGroupName As Integer = drFieldGroupReader.getordinal("ShopProductFieldGroupName")
Dim opShopProductFieldGroupTag As Integer = drFieldGroupReader.getordinal("ShopProductFieldGroupTag")

If drFieldGroupReader.Read Then
	ShopProductFieldGroupName = drFieldGroupReader(opShopProductFieldGroupName)
	ShopProductFieldGroupTag = drFieldGroupReader(opShopProductFieldGroupTag)
Else
	ShopProductFieldGroupName = ""
	ShopProductFieldGroupTag = ""
End If

drFieldGroupReader.Dispose

%>

<script>
function Send(FileToHandle){
	if (document.getElementById('ShopProductField').ShopProductFieldGroupName.value.length < 1){
		alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
	}else{
		document.getElementById('ShopProductField').action = FileToHandle;
		document.getElementById('ShopProductField').submit();
	}
}
</script>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<TITLE></TITLE>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</HEAD>
<%=Gui.MakeHeaders(Translate.Translate("Rediger gruppespecifik felter") & " " & GroupName, Translate.Translate("Indstillinger"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
<form name="ShopProductField" id="ShopProductField" method="Post">
	<tr>
		<td valign=top>
			<div ID="Tab1" STYLE="display:;width:598;">
			<table border="0" cellpadding="0" width="598">
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Gruppe"))%>
						<table cellpadding=2 cellspacing=0 border=0>
							<tr>
								<td width=170><%=Translate.Translate("Gruppenavn")%><input Type="hidden" Name="GroupID" value="<%=GroupID%>"></td>
								<td><INPUT TYPE="TEXT" NAME="ShopProductFieldGroupName" VALUE="<%=Server.HtmlEncode(ShopProductFieldGroupName)%>" maxlength="255" class="std"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Gruppe TemplateTag")%></td>
								<td><INPUT TYPE="TEXT" NAME="ShopProductFieldGroupTag" VALUE="<%=Server.HtmlEncode(ShopProductFieldGroupTag)%>" maxlength="255" class="std"></td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr>
					<td>&nbsp;
					</td>
				</tr>

				<tr>
					<td>
					<%
					If GroupID <> 0 Then
						Response.Write(Gui.GroupBoxStart(Translate.Translate("Felter")))
						%>
							<table width="100%" cellpadding=2 cellspacing=0 border=0>
						<%	

						sql = "SELECT ShopProductField.*, ShopProductFieldType.ShopProductFieldTypeName FROM ShopProductFieldType RIGHT JOIN ShopProductField ON ShopProductFieldType.ShopProductFieldTypeID = ShopProductField.ShopProductFieldTypeID WHERE ShopProductField.ShopProductFieldGroupID = " & GroupID & " ORDER BY ShopProductField.ShopProductFieldSort, ShopProductField.ShopProductFieldID"

						cmdShop.CommandText = sql
						Dim drProductCountReader As IDataReader = cmdShop.ExecuteReader()

						intRowCount = 0
						Do While drProductCountReader.Read
							intRowCount = intRowCount + 1
						Loop

						drProductCountReader.Dispose




						sql = "SELECT ShopProductField.*, ShopProductFieldType.ShopProductFieldTypeName FROM ShopProductFieldType RIGHT JOIN ShopProductField ON ShopProductFieldType.ShopProductFieldTypeID = ShopProductField.ShopProductFieldTypeID WHERE ShopProductField.ShopProductFieldGroupID = " & GroupID & " ORDER BY ShopProductField.ShopProductFieldSort, ShopProductField.ShopProductFieldID"

						cmdShop.CommandText = sql
						Dim drFieldTypeReader As IDataReader = cmdShop.ExecuteReader()

						Dim opShopProductFieldLocked As Integer = drFieldTypeReader.getordinal("ShopProductFieldLocked")
						Dim opShopProductFieldName As Integer = drFieldTypeReader.getordinal("ShopProductFieldName")
						Dim opShopProductFieldTemplateName As Integer = drFieldTypeReader.getordinal("ShopProductFieldTemplateName")
						Dim opShopProductFieldTypeName As Integer = drFieldTypeReader.getordinal("ShopProductFieldTypeName")
						Dim opShopProductFieldGroupID As Integer = drFieldTypeReader.getordinal("ShopProductFieldGroupID")
						Dim opShopProductFieldID As Integer = drFieldTypeReader.getordinal("ShopProductFieldID")

						i = 0
						Do While drFieldTypeReader.Read   'Then we list the fields
							i = i + 1

							If i = 1 Then%>
								<tr><br>
									<td><img src="../../../images/Nothing.gif" width="15" height="1" alt="" border="0"> <strong><%=Translate.Translate("Feltnavn")%></strong></td>
									<td width="140"><strong><%=Translate.Translate("Templatetag")%></strong></td>
									<td width="140"><strong><%=Translate.Translate("Felttype")%></strong></td>
									<td width="40"><strong><%=Translate.Translate("Sorter")%></strong></td>
									<td width=30 align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
								</tr>
							<%
							End If

							If drFieldTypeReader(opShopProductFieldLocked) And Session("DW_Admin_UserID") > 2 Then
							%>
								<TR>
									<td><img src="../../images/icons/Module_Form_small.gif" border="0" align=absmiddle>&nbsp;<%=drFieldTypeReader(opShopProductFieldName)%></td>
									<td><%=drFieldTypeReader(opShopProductFieldTemplateName)%></td>
									<td><%=Translate.Translate(drFieldTypeReader(opShopProductFieldTypeName))%></td>
									<%If i = 1 And i = intRowCount Then%>
										<td align="center"></td>
									<%ElseIf i = 1 Then %>
										<td align="center"><img src="/Admin/images/nothing.gif" width="15" border="0"><a href="Product_Field_Group_Sort.aspx?GroupID=<%=drFieldTypeReader(opShopProductFieldGroupID)%>&FieldID=<%=drFieldTypeReader(opShopProductFieldID)%>&MoveDirection=down"><img src="/Admin/images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"></a></td>
									<%ElseIf i = intRowCount Then %>
										<td align="center"><a href="Product_Field_Group_Sort.aspx?GroupID=<%=drFieldTypeReader(opShopProductFieldGroupID)%>&FieldID=<%=drFieldTypeReader(opShopProductFieldID)%>&MoveDirection=up"><img src="/Admin/images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"></a><img src="/Admin/images/nothing.gif" width="15" border="0"></td>
									<%Else%>
										<td align="center"><a href="Product_Field_Group_Sort.aspx?GroupID=<%=drFieldTypeReader(opShopProductFieldGroupID)%>&FieldID=<%=drFieldTypeReader(opShopProductFieldID)%>&MoveDirection=up"><img src="/Admin/images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"></a><a href="Product_Field_Group_Sort.aspx?GroupID=<%=drFieldTypeReader(opShopProductFieldGroupID)%>&FieldID=<%=drFieldTypeReader(opShopProductFieldID)%>&MoveDirection=down"><img src="/Admin/images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"></a></td>
									<%End If%>
									<td align="center"></td>
								</TR>
							<%				
							Else
							%>
								<TR>
									<td><a href="Product_Field_Edit.aspx?GroupID=<%=drFieldTypeReader(opShopProductFieldGroupID)%>&ID=<%=drFieldTypeReader(opShopProductFieldID)%>"><img src="../../images/icons/Module_Form_small.gif" border="0" align=absmiddle>&nbsp;<%=drFieldTypeReader(opShopProductFieldName)%></a></td>
									<td><%=drFieldTypeReader(opShopProductFieldTemplateName)%></td>
									<td><%=Translate.Translate(drFieldTypeReader(opShopProductFieldTypeName))%></td>
									<%If i = 1 And i = intRowCount Then%>
										<td align="center"></td>
									<%ElseIf i = 1 Then %>
										<td align="center"><img src="/Admin/images/nothing.gif" width="15" border="0"><a href="Product_Field_Group_Sort.aspx?GroupID=<%=drFieldTypeReader(opShopProductFieldGroupID)%>&FieldID=<%=drFieldTypeReader(opShopProductFieldID)%>&MoveDirection=down"><img src="/Admin/images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"></a></td>
									<%ElseIf i = intRowCount Then %>
										<td align="center"><a href="Product_Field_Group_Sort.aspx?GroupID=<%=drFieldTypeReader(opShopProductFieldGroupID)%>&FieldID=<%=drFieldTypeReader(opShopProductFieldID)%>&MoveDirection=up"><img src="/Admin/images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"></a><img src="/Admin/images/nothing.gif" width="15" border="0"></td>
									<%Else%>
										<td align="center"><a href="Product_Field_Group_Sort.aspx?GroupID=<%=drFieldTypeReader(opShopProductFieldGroupID)%>&FieldID=<%=drFieldTypeReader(opShopProductFieldID)%>&MoveDirection=up"><img src="/Admin/images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"></a><a href="Product_Field_Group_Sort.aspx?GroupID=<%=drFieldTypeReader(opShopProductFieldGroupID)%>&FieldID=<%=drFieldTypeReader(opShopProductFieldID)%>&MoveDirection=down"><img src="/Admin/images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"></a></td>
									<%End If%>
									<td align="center"><a href="javascript:if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("felt")) & "\n(" & Base.JSEnable(Server.HtmlEncode(drFieldTypeReader(opShopProductFieldName))) &")"%>')){location='Product_Field_Delete.aspx?GroupID=<%=drFieldTypeReader(opShopProductFieldGroupID)%>&ID=<%=drFieldTypeReader(opShopProductFieldID)%>';}"><img src="../../images/Delete.gif" border="0" alt="<%=Translate.JSTranslate("Slet felt")%>"></a></td>
								</TR>
							<%
							End If
							%>
							<tr>
								<td colspan="5" height="1px" bgcolor="#C4C4C4"></td>
							</tr>
						<%			
						Loop 
						%>
						</table>
						<%	
						Response.Write(Gui.GroupBoxEnd)
					End If
					%>
					</td>
				</tr>
				<tr align="right"> 
					<td colspan="5" align="right">
						<%If (Not CShort(i) >= DW_SHOP_MAX_CUSTOMFIELDS) Then%>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td colspan="6"><br></td>
							</tr>
							<tr>
							<%	If GroupID <> "0" Then%>
								<td align="right"><%=Gui.Button(Translate.Translate("Nyt felt"), "location='Product_Field_edit.aspx?GroupID=" & GroupID & "';", 0)%></td>
								<td width="10"></td>
							<%	End If%>
								<td align="right"><%=Gui.Button(Translate.Translate("OK"), "Send('Product_Field_Group_save.aspx');", 0)%></td>
								<td width="10"></td>
								<td align="right"><%=Gui.Button(Translate.Translate("Luk"), "location='Product_field_list.aspx?Tab=2'", 0)%></td>
								<td width="10"></td>
							</tr>
							<tr>
								<td colspan="4" height="5"></td>
							</tr>			
						</table>
						<%End If%>
					</td>
				</tr>
			</TABLE>
		</div>
		</td>
	</tr>
</table>
</FORM>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
